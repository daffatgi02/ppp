local fplayers = {}

local function updateFPlayers()
    for _, player in pairs(fplayers) do
        TriggerClientEvent("ta-base:client:updateBoard", player.src, fplayers)
    end
end

local function canAddFPlayer(src)
    for _, player in pairs(fplayers) do
        if src == player.src then
            return false
        end
    end

    return true
end

local function finishGame()
    for _, player in pairs(fplayers) do
        fplayers = {}
        TriggerClientEvent('ta-base:facetoface:client:finish', player.src, name)
    end
end

RegisterServerEvent("ta-base:server:joinfacetoface", function()
    local src = source
    if canAddFPlayer(src) then
        table.insert(fplayers, {score = 0, src = src, name = GetPlayerName(src)})
        updateFPlayers()
    end
end)

RegisterServerEvent("ta-base:server:leftfacetoface", function()
    local src = source
    for k, player in pairs(fplayers) do
        if player.src == src then
            table.remove(fplayers, k)
            updateFPlayers()
        end
    end
end)

RegisterServerEvent("ta-base:server:updateScore", function(score)
    local src = source
    for k, player in pairs(fplayers) do
        if player.src == src then
            player.score = score
            updateFPlayers()
        end
    end
end)

AddEventHandler('playerDropped', function()
    local src = source
    for k, player in pairs(fplayers) do
        if player.src == src then
            table.remove(fplayers, k)
            updateFPlayers()
        end
    end
end)

RegisterServerEvent('ta-base:facetoface:server:finish')
AddEventHandler('ta-base:facetoface:server:finish', function(winner)
    local src = winner
    local name = GetPlayerName(winner)
    finishGame()
    TriggerClientEvent('ta-base:facetoface:client:finish-winner', src)
end)