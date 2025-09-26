local isLeaderboardOpen = false
local isTop3Visible = false
local currentGamemode = nil


-- Initialize ESX
ESX = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(100)
    end
end)

-- Track farm_and_fight gamemode via direct event from ta-base
RegisterNetEvent('ta-leaderboard:gamemode-changed')
AddEventHandler('ta-leaderboard:gamemode-changed', function(gamemode, active)

    if gamemode == "farm_and_fight" then
        if active == true then
            currentGamemode = "farm_and_fight"
            showTop3Leaderboard()
        else
            currentGamemode = nil
            hideTop3Leaderboard()
            if isLeaderboardOpen then
                toggleLeaderboard()
            end
        end
    end
end)

-- Backup: Track farm_and_fight gamemode (legacy)
RegisterNetEvent('ta-base:client:gamemode:farm_and_fight')
AddEventHandler('ta-base:client:gamemode:farm_and_fight', function(active)
    if active then
        currentGamemode = "farm_and_fight"
        showTop3Leaderboard()
    else
        currentGamemode = nil
        hideTop3Leaderboard()
        if isLeaderboardOpen then
            toggleLeaderboard()
        end
    end
end)

-- Listen for farm_and_fight variable changes
CreateThread(function()
    local lastFarmAndFightState = nil
    while true do
        Wait(500) -- Check more frequently

        -- Check if farm_and_fight variable exists and has changed
        if _G["farm_and_fight"] ~= nil then
            local currentState = _G["farm_and_fight"]
            if currentState ~= lastFarmAndFightState then
                lastFarmAndFightState = currentState
                if currentState == true then
                    currentGamemode = "farm_and_fight"
                    showTop3Leaderboard()
                else
                    currentGamemode = nil
                    hideTop3Leaderboard()
                    if isLeaderboardOpen then
                        toggleLeaderboard()
                    end
                end
            end
        else
            -- Variable doesn't exist yet, keep checking
            if lastFarmAndFightState ~= nil then
                lastFarmAndFightState = nil
                currentGamemode = nil
                hideTop3Leaderboard()
            end
        end
    end
end)

-- Show TOP 3 mini leaderboard (always visible during farm_and_fight)
function showTop3Leaderboard()
    isTop3Visible = true

    -- Check if ESX is ready
    if not ESX then
        CreateThread(function()
            while not ESX do
                Wait(100)
            end
            showTop3Leaderboard() -- Retry
        end)
        return
    end

    ESX.TriggerServerCallback('ta-leaderboard:getTop3Data', function(data)
        if data then
            SendNUIMessage({
                action = "showTop3",
                data = data
            })
        else
        end
    end)
end

-- Hide TOP 3 mini leaderboard
function hideTop3Leaderboard()
    isTop3Visible = false
    SendNUIMessage({
        action = "hideTop3"
    })
end

-- Toggle leaderboard function (F6 - Full leaderboard)
function toggleLeaderboard()
    -- Use same logic as TOP 3: if TOP 3 is visible, then F6 should work
    if currentGamemode ~= "farm_and_fight" and not isTop3Visible then
        return
    end

    isLeaderboardOpen = not isLeaderboardOpen

    if isLeaderboardOpen then
        ESX.TriggerServerCallback('ta-leaderboard:getLeaderboardData', function(data)
            ESX.TriggerServerCallback('ta-leaderboard:getPlayerStats', function(playerStats)
                SendNUIMessage({
                    action = "showLeaderboard",
                    data = data,
                    playerStats = playerStats
                })
                SetNuiFocus(true, true) -- Enable focus for F6 modal
            end)
        end)
    else
        SendNUIMessage({
            action = "hideLeaderboard"
        })
        SetNuiFocus(false, false) -- Disable focus when closed
    end
end

-- F6 Keybind
RegisterCommand('leaderboard', function(source, args, user)
    toggleLeaderboard()
end)

RegisterKeyMapping('leaderboard', 'Farm & Fight Leaderboard', 'keyboard', 'F6')

-- Refresh data event (F6 Full leaderboard)
RegisterNetEvent('ta-leaderboard:refreshData')
AddEventHandler('ta-leaderboard:refreshData', function()
    if isLeaderboardOpen and currentGamemode == "farm_and_fight" then
        ESX.TriggerServerCallback('ta-leaderboard:getLeaderboardData', function(data)
            ESX.TriggerServerCallback('ta-leaderboard:getPlayerStats', function(playerStats)
                SendNUIMessage({
                    action = "updateData",
                    data = data,
                    playerStats = playerStats
                })
            end)
        end)
    end
end)

-- Refresh TOP 3 data event
RegisterNetEvent('ta-leaderboard:refreshTop3')
AddEventHandler('ta-leaderboard:refreshTop3', function()
    if isTop3Visible and currentGamemode == "farm_and_fight" then
        ESX.TriggerServerCallback('ta-leaderboard:getTop3Data', function(data)
            SendNUIMessage({
                action = "updateTop3",
                data = data
            })
        end)
    end
end)

-- Auto refresh leaderboard data
CreateThread(function()
    while true do
        Wait(Config.RefreshInterval)
        if currentGamemode == "farm_and_fight" and Config.EnableRealTimeUpdates then
            -- Refresh full leaderboard if open
            if isLeaderboardOpen then
                TriggerEvent('ta-leaderboard:refreshData')
            end
            -- Always refresh TOP 3 if visible
            if isTop3Visible then
                TriggerEvent('ta-leaderboard:refreshTop3')
            end
        end
    end
end)

-- Resource start debug
AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
            CreateThread(function()
            Wait(3000) -- Wait for other resources to load
            local farmFightState = _G["farm_and_fight"]

            -- Manual check if player is already in farm_and_fight
            if farmFightState == true then
                currentGamemode = "farm_and_fight"
                showTop3Leaderboard()
            end
        end)
    end
end)

-- Kill/Death events from ta-base
RegisterNetEvent('ta-leaderboard:kill-event')
AddEventHandler('ta-leaderboard:kill-event', function(killerId, victimId)
    -- Refresh leaderboard data
    if isTop3Visible then
        TriggerEvent('ta-leaderboard:refreshTop3')
    end
    if isLeaderboardOpen then
        TriggerEvent('ta-leaderboard:refreshData')
    end
end)

RegisterNetEvent('ta-leaderboard:death-event')
AddEventHandler('ta-leaderboard:death-event', function(victimId)
    -- Refresh leaderboard data
    if isTop3Visible then
        TriggerEvent('ta-leaderboard:refreshTop3')
    end
    if isLeaderboardOpen then
        TriggerEvent('ta-leaderboard:refreshData')
    end
end)


-- Close leaderboard with ESC or click
RegisterNUICallback('closeLeaderboard', function(data, cb)
    isLeaderboardOpen = false
    SendNUIMessage({
        action = "hideLeaderboard"
    })
    SetNuiFocus(false, false) -- Disable focus when closed
    cb('ok')
end)

