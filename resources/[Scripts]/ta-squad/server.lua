ESX = nil

if Config.NewEsx then
    ESX = exports['es_extended']:getSharedObject()
else
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

local squads    = {}
local invites   = {}
local icons     = {"alibi","ash","bandit","blackbeard","blitz","buck","capitao"}
local webapikey = false

-----------------------------------------------------------------------------------------
-- EVENT'S --
-----------------------------------------------------------------------------------------

RegisterNetEvent('wais:playerloaded:squad', function()
    local src     = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then 
        TriggerClientEvent('wais:try:loadp', src)
        return
    end
    xPlayer.set('insquad', false)
    xPlayer.set('squadname', nil)
    TriggerClientEvent('wais:send:hex', src, xPlayer.identifier)
    TriggerClientEvent('wais:firstload:rooms', src, squads)
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        local webapi = GetConvar('steam_webApiKey', 'NULL')
        if webapi == "none" or webapi == "" then
            webapikey = false
        else
            webapikey = true
        end
    end
end)

AddEventHandler('playerDropped', function(reason)
    local src     = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local pinsquad = xPlayer.get('insquad')
    local squadname = xPlayer.get('squadname')

    if pinsquad then
        LeaveSquad(xPlayer, squadname, false)
    end
end)

-----------------------------------------------------------------------------------------
-- CALLBACK'S --
-----------------------------------------------------------------------------------------

ESX.RegisterServerCallback('wais:createsquad', function(source, cb, name, private)
    local src     = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if squads[name] == nil then
        CreateSquad(name, private)
        Wait(250)
        local joined = JoinSquad(xPlayer, name, true, false)
        cb(joined)
    else
        cb(false)
    end

end)

ESX.RegisterServerCallback('wais:leave:squad', function(source, cb, name)
    local src     = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local insquad = xPlayer.get('insquad')

    if insquad then
        local leaved = LeaveSquad(xPlayer, name, false)
        cb(leaved)
    else
        cb(false)
    end

end)

ESX.RegisterServerCallback('wais:join:squad', function(source, cb, name)
    local src     = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local insquad = xPlayer.get('insquad')

    if not insquad then
        if squads[name] == nil then
            cb(false)
        else
            local joined = JoinSquad(xPlayer, name, false, false)
            cb(joined)
        end
    else
        cb(false)
    end

end)

ESX.RegisterServerCallback('wais:squad:kickp', function(source, cb, name, targetid)
    local xTarget = ESX.GetPlayerFromId(targetid)
    local insquad = xTarget.get('insquad')

    if insquad then
        if squads[name] == nil then
            cb(false)
        else
            local leaveds = LeaveSquad(xTarget, name, true)
            cb(leaveds)
        end
    else
        cb(false)
    end

end)

ESX.RegisterServerCallback('wais:invite:accept', function(source, cb, name)
    local src     = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local insquad = xPlayer.get('insquad')

    if insquad then
        cb(false)
    else
        if squads[name] == nil then
            cb(false)
        else
            local joined = JoinSquad(xPlayer, name, false, true)
            cb(joined)
        end
    end

end)

-----------------------------------------------------------------------------------------
-- COMMAND'S --
-----------------------------------------------------------------------------------------

RegisterCommand('invite', function(source,  args)
    local src      = source
    local xPlayer  = ESX.GetPlayerFromId(src)
    local xTarget  = ESX.GetPlayerFromId(tonumber(args[1]))
    if not xTarget then return end
    local pinsquad = xPlayer.get('insquad')
    local tinsquad = xTarget.get('insquad')
    local pleader  = hasLeader(xPlayer.identifier, xPlayer.get('squadname'))

    if pinsquad and pleader then
        if not tinsquad then
            TriggerClientEvent('wais:come:invite', xTarget.source, squads[xPlayer.get('squadname')])
        end
    end

end)

-----------------------------------------------------------------------------------------
-- FUNCTİON'S --
-----------------------------------------------------------------------------------------

function GetRandomIcon() 
    math.randomseed(GetGameTimer())
    local random = math.random(1, #icons)
    return icons[random] 
end

function GenerateRandomRoomId()
    math.randomseed(GetGameTimer())
    local random = math.random(1, 500)
    return random
end

function CreateSquad(name, private)
    squads[name] = { roomid = GenerateRandomRoomId(), roomname = name, isPrivate = private, icon = GetRandomIcon(), maxp = Config.MaxSquadPlayers, pcounts = 0, players = {}}
    local object = {
        name = name,
        squadlist = squads
    }
    TriggerClientEvent('wais:addNewSquad', -1, object)
end

function JoinSquad(player, name, isLeader, invited)
    local p = promise:new()
    if not player.get('insquad') then
        if not squads[name].isPrivate then
            if squads[name].pcounts < Config.MaxSquadPlayers then
                if squads[name].pcounts + 1 <= Config.MaxSquadPlayers then
                    squads[name].pcounts = squads[name].pcounts + 1
                    table.insert(squads[name].players, { id = player.source, identifier = player.identifier, leader = isLeader, name = GetPlayerName(player.source), avatar = GetAvatar(player.identifier), hexlast = player.identifier:sub(-5) })
                    player.set('insquad', true)
                    player.set('squadname', name)
                    for k,v in pairs(squads[name].players) do
                        TriggerClientEvent('wais:build:squad', v.id, squads[name])
                    end
                    local counts = {
                        roomid = squads[name].roomid,
                        name = name,
                        maxp = squads[name].maxp,
                        nowp = squads[name].pcounts
                    }
                    TriggerClientEvent('wais:chanceCountSquad', -1, counts)
                    p:resolve(true)
                else
                    p:resolve(false)
                end
            else
                p:resolve(false)
            end
        elseif squads[name].isPrivate and isLeader then
            if squads[name].pcounts < Config.MaxSquadPlayers then
                if squads[name].pcounts + 1 <= Config.MaxSquadPlayers then
                    squads[name].pcounts = squads[name].pcounts + 1
                    table.insert(squads[name].players, { id = player.source, identifier = player.identifier, leader = isLeader, name = GetPlayerName(player.source), avatar = GetAvatar(player.identifier), hexlast = player.identifier:sub(-5) })
                    player.set('insquad', true)
                    player.set('squadname', name)
                    for k,v in pairs(squads[name].players) do
                        TriggerClientEvent('wais:build:squad', v.id, squads[name])
                    end
                    local counts = {
                        roomid = squads[name].roomid,
                        name = name,
                        maxp = squads[name].maxp,
                        nowp = squads[name].pcounts
                    }
                    TriggerClientEvent('wais:chanceCountSquad', -1, counts)
                    p:resolve(true)
                else
                    p:resolve(false)
                end
            else
                p:resolve(false)
            end
        elseif squads[name].isPrivate and invited then
            if squads[name].pcounts < Config.MaxSquadPlayers then
                if squads[name].pcounts + 1 <= Config.MaxSquadPlayers then
                    squads[name].pcounts = squads[name].pcounts + 1
                    table.insert(squads[name].players, { id = player.source, identifier = player.identifier, leader = isLeader, name = GetPlayerName(player.source), avatar = GetAvatar(player.identifier), hexlast = player.identifier:sub(-5)})
                    player.set('insquad', true)
                    player.set('squadname', name)
                    for k,v in pairs(squads[name].players) do
                        TriggerClientEvent('wais:build:squad', v.id, squads[name])
                    end
                    local counts = {
                        roomid = squads[name].roomid,
                        name = name,
                        maxp = squads[name].maxp,
                        nowp = squads[name].pcounts
                    }
                    TriggerClientEvent('wais:chanceCountSquad', -1, counts)
                    p:resolve(true)
                else
                    p:resolve(false)
                end
            else
                p:resolve(false)
            end
        else
            p:resolve(false)
        end
    else
        p:resolve(false)
    end
    return Citizen.Await(p)
end

function LeaveSquad(player, name, kicked)
    local p = promise:new()
    local members = {}
    local leaders = false

    if squads[name].pcounts - 1 >= 1 then
        for k,v in pairs(squads[name].players) do
            if v.identifier == player.identifier then 
                if v.leader then
                    leaders = true
                end
            else 
                if leaders then
                    leaders = false
                    table.insert(members, { id = v.id, identifier = v.identifier, leader = true, name = v.name, avatar = v.avatar, hexlast = v.hexlast}) 
                else
                    table.insert(members, { id = v.id, identifier = v.identifier, leader = v.leader, name = v.name, avatar = v.avatar, hexlast = v.hexlast}) 
                end
            end
        end

        squads[name].pcounts = squads[name].pcounts - 1
        squads[name].players = members

        for k,v in pairs(squads[name].players) do
            TriggerClientEvent('wais:build:squad', v.id, squads[name])
        end 

        local counts = {
            roomid = squads[name].roomid,
            name = name,
            maxp = squads[name].maxp,
            nowp = squads[name].pcounts
        }

        if kicked then
            TriggerClientEvent('wais:squad:kicked', player.source)
            player.set('insquad', false)
            player.set('squadname', nil)
            TriggerClientEvent('wais:load:rooms', player.source, squads)
        else
            TriggerClientEvent('wais:leave:squad', player.source)
            player.set('insquad', false)
            player.set('squadname', nil)
            TriggerClientEvent('wais:load:rooms', player.source, squads)
        end

        TriggerClientEvent('wais:chanceCountSquad', -1, counts)
        p:resolve(true)
    else
        if kicked then
            TriggerClientEvent('wais:squad:kicked', player.source)
            player.set('insquad', false)
            player.set('squadname', nil)
            TriggerClientEvent('wais:load:rooms', player.source, squads)
        else
            TriggerClientEvent('wais:leave:squad', player.source)
            player.set('insquad', false)
            player.set('squadname', nil)
            TriggerClientEvent('wais:load:rooms', player.source, squads)
        end

        TriggerClientEvent('wais:deleted:squad', -1, squads[name].roomid)
        squads[name] = nil
        p:resolve(true)
    end

    return Citizen.Await(p)
end


function hasLeader(identifier, name)
    local p = promise:new()

    if squads[name] == nil then
        p:resolve(false)
    else
        for k,v in pairs(squads[name].players) do
            if v.identifier == identifier then
                if v.leader then 
                    p:resolve(true)
                    break
                else
                    p:resolve(false)
                    break
                end
            end
        end
    end

    return Citizen.Await(p)

end

function GetAvatar(identifier)
    if string.len(identifier) >= 30 then return "https://i.pinimg.com/474x/5c/be/a6/5cbea638934c3a0181790c16a7832179.jpg" end
    local sid  = tonumber(identifier:gsub("steam:",""), 16)
    local link = "http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=3753B61005BAFCB2E37A5A03A727A8AE&steamids="..sid
    local p = promise:new()
    PerformHttpRequest(link, function(errorCode, resultData, resultHeaders)
        a = json.decode(resultData)
        if not a then
            p:resolve("https://i.pinimg.com/474x/5c/be/a6/5cbea638934c3a0181790c16a7832179.jpg")
        else
            for k,v in pairs(a["response"].players) do
                p:resolve(v.avatarfull)
            end
        end
    end)
    return Citizen.Await(p)
end