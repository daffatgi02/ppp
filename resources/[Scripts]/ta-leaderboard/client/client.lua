local isLeaderboardOpen = false
local isTop3Visible = false
local currentGamemode = nil

-- Debug function (define first)
local function debugPrint(message)
    if Config.EnableDebug then
        print("^3[ta-leaderboard CLIENT]^7 " .. message)
    end
end

-- Initialize ESX
ESX = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(100)
    end
    debugPrint("ESX initialized successfully")
end)

-- Track farm_and_fight gamemode via direct event from ta-base
RegisterNetEvent('ta-leaderboard:gamemode-changed')
AddEventHandler('ta-leaderboard:gamemode-changed', function(gamemode, active)
    debugPrint("Direct gamemode event received: " .. tostring(gamemode) .. " = " .. tostring(active))

    if gamemode == "farm_and_fight" then
        if active == true then
            currentGamemode = "farm_and_fight"
            debugPrint("Received farm_and_fight = true, showing TOP 3")
            showTop3Leaderboard()
        else
            currentGamemode = nil
            debugPrint("Received farm_and_fight = false, hiding TOP 3")
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
    debugPrint("Legacy gamemode event received: " .. tostring(active))
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
                debugPrint("Farm and fight state changed: " .. tostring(currentState))
                lastFarmAndFightState = currentState
                if currentState == true then
                    currentGamemode = "farm_and_fight"
                    debugPrint("Detected farm_and_fight = true, showing TOP 3")
                    showTop3Leaderboard()
                else
                    currentGamemode = nil
                    debugPrint("Detected farm_and_fight = false/nil, hiding TOP 3")
                    hideTop3Leaderboard()
                    if isLeaderboardOpen then
                        toggleLeaderboard()
                    end
                end
            end
        else
            -- Variable doesn't exist yet, keep checking
            if lastFarmAndFightState ~= nil then
                debugPrint("farm_and_fight variable not found, hiding TOP 3")
                lastFarmAndFightState = nil
                currentGamemode = nil
                hideTop3Leaderboard()
            end
        end
    end
end)

-- Show TOP 3 mini leaderboard (always visible during farm_and_fight)
function showTop3Leaderboard()
    debugPrint("Showing TOP 3 leaderboard")
    isTop3Visible = true

    -- Check if ESX is ready
    if not ESX then
        debugPrint("ESX not ready yet, waiting...")
        CreateThread(function()
            while not ESX do
                Wait(100)
            end
            showTop3Leaderboard() -- Retry
        end)
        return
    end

    debugPrint("ESX ready, requesting TOP 3 data from server...")
    ESX.TriggerServerCallback('ta-leaderboard:getTop3Data', function(data)
        if data then
            debugPrint("TOP 3 data received: " .. #data .. " players")
            for i, player in ipairs(data) do
                debugPrint("TOP " .. i .. ": " .. (player.playername or "N/A") .. " - " .. (player.kills or 0) .. "K/" .. (player.death or 0) .. "D")
            end
            SendNUIMessage({
                action = "showTop3",
                data = data
            })
        else
            debugPrint("ERROR: No data received from server")
        end
    end)
end

-- Hide TOP 3 mini leaderboard
function hideTop3Leaderboard()
    debugPrint("Hiding TOP 3 leaderboard")
    isTop3Visible = false
    SendNUIMessage({
        action = "hideTop3"
    })
end

-- Toggle leaderboard function (F6 - Full leaderboard)
function toggleLeaderboard()
    local farmFightState = _G["farm_and_fight"]
    debugPrint("Toggle attempt - farm_and_fight state: " .. tostring(farmFightState))

    if not farmFightState or farmFightState ~= true then
        debugPrint("Cannot toggle leaderboard - not in farm_and_fight mode (state: " .. tostring(farmFightState) .. ")")
        return
    end

    isLeaderboardOpen = not isLeaderboardOpen
    debugPrint("Toggling full leaderboard: " .. tostring(isLeaderboardOpen))

    if isLeaderboardOpen then
        ESX.TriggerServerCallback('ta-leaderboard:getLeaderboardData', function(data)
            ESX.TriggerServerCallback('ta-leaderboard:getPlayerStats', function(playerStats)
                debugPrint("Showing full leaderboard with " .. #data .. " players")
                SendNUIMessage({
                    action = "showLeaderboard",
                    data = data,
                    playerStats = playerStats
                })
                SetNuiFocus(true, true) -- Enable focus for F6 modal
            end)
        end)
    else
        debugPrint("Hiding full leaderboard")
        SendNUIMessage({
            action = "hideLeaderboard"
        })
        SetNuiFocus(false, false) -- Disable focus when closed
    end
end

-- Keybind registration
RegisterCommand('toggle_leaderboard', function()
    toggleLeaderboard()
end, false)

RegisterKeyMapping('toggle_leaderboard', 'Toggle Farm & Fight Leaderboard', 'keyboard', "F6")

-- Refresh data event (F6 Full leaderboard)
RegisterNetEvent('ta-leaderboard:refreshData')
AddEventHandler('ta-leaderboard:refreshData', function()
    debugPrint("Refresh data event triggered")
    local farmFightState = _G["farm_and_fight"]
    if isLeaderboardOpen and farmFightState == true then
        ESX.TriggerServerCallback('ta-leaderboard:getLeaderboardData', function(data)
            ESX.TriggerServerCallback('ta-leaderboard:getPlayerStats', function(playerStats)
                debugPrint("Updating full leaderboard data")
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
    debugPrint("Refresh TOP 3 event triggered")
    local farmFightState = _G["farm_and_fight"]
    if isTop3Visible and farmFightState == true then
        ESX.TriggerServerCallback('ta-leaderboard:getTop3Data', function(data)
            debugPrint("Updating TOP 3 data")
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
        local farmFightState = _G["farm_and_fight"]
        if farmFightState == true and Config.EnableRealTimeUpdates then
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
        debugPrint("Client resource started successfully!")
        CreateThread(function()
            Wait(3000) -- Wait for other resources to load
            local farmFightState = _G["farm_and_fight"]
            debugPrint("Checking farm_and_fight status after 3s: " .. tostring(farmFightState))

            -- Manual check if player is already in farm_and_fight
            if farmFightState == true then
                debugPrint("Player already in farm_and_fight on resource start!")
                currentGamemode = "farm_and_fight"
                showTop3Leaderboard()
            end
        end)
    end
end)

-- Kill/Death events from ta-base
RegisterNetEvent('ta-leaderboard:kill-event')
AddEventHandler('ta-leaderboard:kill-event', function(killerId, victimId)
    debugPrint("Kill event received - Killer: " .. tostring(killerId) .. ", Victim: " .. tostring(victimId))
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
    debugPrint("Death event received - Victim: " .. tostring(victimId))
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