ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local users = {}
local apiKey = GetConvar('steam_webApiKey')
local players = {}

RegisterNetEvent('ta-base:server:openCharacter')
AddEventHandler('ta-base:server:openCharacter', function()
    local src = source 
    
    local data = {}
    local identifierlist = ExtractIdentifiers(src)
    discord = "<@"..identifierlist.discord:gsub("discord:", "")..">"
    identifier = identifierlist.ip
    local identifier = GetPlayerIdentifier(src, 0)
    local hex = string.gsub(identifier, 'steam:', '')
    local decimal = tonumber(hex, 16)
    SetPlayerRoutingBucket(src, src)
    local main_background = exports["oxmysql"]:query_async("SELECT main_coord FROM users WHERE identifier = @identifier",
    { ['@identifier'] = PlayerIdentifier('steam', src) })[1]
    PerformHttpRequest('http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. apiKey .. '&steamids=' .. decimal, function(error, result, header)
        local result = json.decode(result)
        if result ~= nil then
            local url = result.response.players[1].avatarfull
            characterPhoto = url
            table.insert(data, {discord = discord, steam = PlayerIdentifier('steam', src), id = src, playerid ="ID "..src, name = GetPlayerName(src), avatar = characterPhoto, ping = GetPlayerPing(src), players = #GetPlayers()})
            TriggerClientEvent('ta-base:client:main-menu', src, data, main_background.main_coord)
            data = {}
        else
            table.insert(data, {discord = discord, steam = PlayerIdentifier('steam', src), id = src, playerid ="ID "..src, name = GetPlayerName(src), avatar = "https://cdn.discordapp.com/attachments/671389525309784105/1074156624094179358/New_Logo.png", ping = GetPlayerPing(src), players = #GetPlayers()})
            TriggerClientEvent('ta-base:client:main-menu', src, data, main_background.main_coord)
            data = {}
        end
    end)
end)

function PlayerIdentifier(type, id)
    local identifiers = {}
    local numIdentifiers = GetNumPlayerIdentifiers(id)

    for a = 0, numIdentifiers do
        table.insert(identifiers, GetPlayerIdentifier(id, a))
    end

    for b = 1, #identifiers do
        if string.find(identifiers[b], type, 1) then
            return identifiers[b]
        end
    end
    return false
end

function ExtractIdentifiers(id)
    local identifiers = {steam = "", ip = "", discord = "", license = "", xbl = "", live = ""}
    for i = 0, GetNumPlayerIdentifiers(id) - 1 do
        local playerID = GetPlayerIdentifier(id, i)

        if string.find(playerID, "steam") then
            identifiers.steam = playerID
        elseif string.find(playerID, "ip") then
            identifiers.ip = playerID
        elseif string.find(playerID, "discord") then
            identifiers.discord = playerID
        elseif string.find(playerID, "license") then
            identifiers.license = playerID
        elseif string.find(playerID, "xbl") then
            identifiers.xbl = playerID
        elseif string.find(playerID, "live") then
            identifiers.live = playerID
        end
    end

    return identifiers
end

RegisterServerEvent('ta-base:server:set-bucket')
AddEventHandler('ta-base:server:set-bucket', function(bucket)
    local src = source
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(src))
    SetPlayerRoutingBucket(src, bucket)
    SetEntityRoutingBucket(vehicle, bucket)
end)

RegisterServerEvent('ta-base:server:default-bucket')
AddEventHandler('ta-base:server:default-bucket', function()
    local src = source
    SetPlayerRoutingBucket(src, src)
    SetEntityRoutingBucket(vehicle, src)
end)

ESX.RegisterServerCallback("ta-base:getPlayerData", function(src, cb)
    cb(getPlayerData(src))
end)

ESX.RegisterServerCallback("ta-base:getPlayers", function(src, cb)
    local result = exports["oxmysql"]:query_async("SELECT * FROM users")
    cb({players = result, identifier = getPlayerData(src).identifier}) 
end)

ESX.RegisterServerCallback("ta-base:getMatchmakingData", function(src, cb)
    local result = exports["oxmysql"]:query_async("SELECT * FROM ta_matchmaking")
    cb({players = result, identifier = getPlayerData(src).identifier}) 
end)

function getPlayerData(src)
    local result = exports["oxmysql"]:query_async("SELECT * FROM users WHERE identifier = @identifier",
    { ['@identifier'] = PlayerIdentifier('steam', src) })
    return result[1]
end

-- POINTS
function removePoints(src, amount)
    exports["oxmysql"]:query_async("UPDATE users SET point = point - ? WHERE identifier = ?", {
        amount,
        PlayerIdentifier('steam', src)
    })
end

function addPoints(src, amount)
    exports["oxmysql"]:query_async("UPDATE users SET point = point + ? WHERE identifier = ?", {
        amount,
        PlayerIdentifier('steam', src)
    })
end

-- XP
function removeExperience(src, amount)
    exports["oxmysql"]:query_async("UPDATE users SET xp = xp - ? WHERE identifier = ?", {
        amount,
        PlayerIdentifier('steam', src)
    })
end

function addExperience(src, amount)
    exports["oxmysql"]:query_async("UPDATE users SET xp = xp + ? WHERE identifier = ?", {
        amount,
        PlayerIdentifier('steam', src)
    })
end

-- KILLS
function removeKills(src, amount)
    exports["oxmysql"]:query_async("UPDATE users SET kills = kills - ? WHERE identifier = ?", {
        amount,
        PlayerIdentifier('steam', src)
    })
end

function addKills(src, amount)
    exports["oxmysql"]:query_async("UPDATE users SET kills = kills + ? WHERE identifier = ?", {
        amount,
        PlayerIdentifier('steam', src)
    })
end

-- DEATH
function removeDeath(src, amount)
    exports["oxmysql"]:query_async("UPDATE users SET death = death - ? WHERE identifier = ?", {
        amount,
        PlayerIdentifier('steam', src)
    })
end

function addDeath(src, amount)
    exports["oxmysql"]:query_async("UPDATE users SET death = death + ? WHERE identifier = ?", {
        amount,
        PlayerIdentifier('steam', src)
    })
end

-- COIN
function removeCoin(src, amount)
    exports["oxmysql"]:query_async("UPDATE users SET coin = coin - ? WHERE identifier = ?", {
        amount,
        PlayerIdentifier('steam', src)
    })
end

function addCoin(src, amount)
    exports["oxmysql"]:query_async("UPDATE users SET coin = coin + ? WHERE identifier = ?", {
        amount,
        PlayerIdentifier('steam', src)
    })
end

exports("getPlayerData", getPlayerData);

exports("removePoints", removePoints);
exports("addPoints", addPoints);

exports("removeExperience", removeExperience);
exports("addExperience", addExperience);

exports("removeKills", removeKills);
exports("addKills", addKills);

exports("removeDeath", removeDeath);
exports("addDeath", addPoints);

exports("removeCoin", removeCoin);
exports("addCoin", addCoin);
