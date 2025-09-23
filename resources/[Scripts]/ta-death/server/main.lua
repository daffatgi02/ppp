ESX = nil
local messages = {}

RegisterServerEvent("ta-vip:set:dsMessage", function(message)
    local src = source
    if humm(src) then
        table.insert(messages, {id = src, message = message})
    end
end)

function humm(src)
    for _, msg in pairs(messages) do
        if msg.id == src then
            return false
        end
    end

    return true
end

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local apiKey = GetConvar('steam_webApiKey')

if Config.Framework == "qb" or Config.Framework == "oldqb" then
    QBCore.Functions.CreateCallback('ta-death:server:getKillerCoords', function(source, cb, target)
        local xPlayer = QBCore.Functions.GetPlayer(target)
        if xPlayer ~= nil then
            local player = GetPlayerPed(target)
            local coord = GetEntityCoords(player)
            cb(coord)
        end
    end)
    
    QBCore.Functions.CreateCallback('ta-death:server:getKillerIInfo', function(source, cb, killer)
        local src = source 
        local identifier = GetPlayerIdentifier(killer, 0)
        local hexfull = string.gsub(identifier, 'steam:', '')
        local hex = tonumber(hexfull, 16)
        PerformHttpRequest('http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. apiKey .. '&steamids=' .. hex, function(error, result, header)
            local result = json.decode(result)
            local url = result.response.players[1].avatarfull
            local name = "("..killer..") ".. GetPlayerName(killer)
            cb(name, url, message)
        end)
    end)

elseif Config.Framework == "esx" or Config.Framework == "oldesx" then
    ESX.RegisterServerCallback('ta-death:server:getKillerCoords', function(source, cb, target)
        local xPlayer = ESX.GetPlayerFromId(target)
        if xPlayer ~= nil then
            local player = GetPlayerPed(target)
            local coord = GetEntityCoords(player)
            cb(coord)
        end
    end)
    
    ESX.RegisterServerCallback('ta-death:server:getKillerIInfo', function(source, cb, killer)
        local src = source 
        local identifier = GetPlayerIdentifier(killer, 0)
        local hexfull = string.gsub(identifier, 'steam:', '')
        local hex = tonumber(hexfull, 16)
        local message 

        for _, msg in pairs(messages) do
            if msg.id == killer then
                message = msg.message
            end
        end
    
        PerformHttpRequest('http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. apiKey .. '&steamids=' .. hex, function(error, result, header)
            local result = json.decode(result)
            local url = result.response.players[1].avatarfull
            local name = "("..killer..") ".. GetPlayerName(killer)
            cb(name, url, message)
        end)
    end)
end