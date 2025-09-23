PlayerKillList = {}

WeaponListServer = {
    {level = "WEAPON_CUSTOMADVANCEDRIFLE", value = 5, name="ADVANCED RIFLE"},
	{level = "WEAPON_CUSTOMASSAULTRIFLE", value = 7, name="ASSAULT RIFLE"},
	{level = "WEAPON_CUSTOMCOMPACTRIFLE", value = 4, name="COMPACT RIFLE"},
    {level = "WEAPON_CUSTOMCOMBATPDW", value = 5, name="COMBAT PDW"},
    {level = "WEAPON_CUSTOMSMG_MK2", value = 4, name="SMG MK II"},
    {level = "WEAPON_CUSTOMSMG", value = 4, name="SMG"},
	{level = "WEAPON_CUSTOMMICROSMG", value = 6, name="MICRO SMG"},
	{level = "WEAPON_CUSTOMMACHINEPISTOL", value = 4, name="MACHINE PISTOL"},
	{level = "WEAPON_CUSTOMCOMBATPISTOL", value = 3, name="COMBAT PISTOL"},
	{level = "WEAPON_CUSTOMPISTOL_MK2", value = 2, name="PISTOL MK II"},
    {level = "WEAPON_CUSTOMPISTOL", value = 2, name="PISTOL"},
}

gungame_map_1 = true
gungame_map_2 = false
gungame_map_3 = false
gungame_map_4 = false
gungame_map_5 = false
gungame_map_6 = false

RegisterServerEvent('ta-base:server:gungame:get-map')
AddEventHandler('ta-base:server:gungame:get-map', function()
    local src = source
    if gungame_map_1 == true then
        TriggerClientEvent('ta-base:client:gungame:set-coords', src, 1)
    elseif gungame_map_2 == true then
        TriggerClientEvent('ta-base:client:gungame:set-coords', src, 2)
    elseif gungame_map_3 == true then
        TriggerClientEvent('ta-base:client:gungame:set-coords', src, 3)
    elseif gungame_map_4 == true then
        TriggerClientEvent('ta-base:client:gungame:set-coords', src, 4)
    elseif gungame_map_5 == true then
        TriggerClientEvent('ta-base:client:gungame:set-coords', src, 5)
    elseif gungame_map_6 == true then
        TriggerClientEvent('ta-base:client:gungame:set-coords', src , 6)
    end
end)

RegisterServerEvent('ta-base:gamemodes:server:gungame:kill')
AddEventHandler('ta-base:gamemodes:server:gungame:kill', function(killer)
    local src = killer
    if PlayerKillList[src] == nil then
        PlayerKillList[src] = {name=GetPlayerName(src), board = 1, kill = 1}
        TriggerClientEvent('ta-base:gamemodes:client:gungame:update-kill', src, PlayerKillList[src].kill)
    else 
        if PlayerKillList[src].board == 11 then
            TriggerEvent('ta-base:gamemodes:server:gungame:finishgame', src)
            return
        end
        PlayerKillList[src].kill = PlayerKillList[src].kill + 1
        TriggerClientEvent('ta-base:gamemodes:client:gungame:update-kill', src, PlayerKillList[src].kill)
        
        local lastKill = WeaponListServer[PlayerKillList[src].board].level
        if PlayerKillList[src].kill >= WeaponListServer[PlayerKillList[src].board].value then
            PlayerKillList[src].board = PlayerKillList[src].board + 1
            PlayerKillList[src].kill = 0
            TriggerClientEvent('ta-base:gamemodes:client:gungame:levelup', src, PlayerKillList[src].board)
        end
    end
end)

RegisterServerEvent('ta-base:gamemodes:server:gungame:get-level')
AddEventHandler('ta-base:gamemodes:server:gungame:get-level', function()
    local src = source
    TriggerClientEvent('ta-base:gamemodes:client:gungame:update-level', src, PlayerKillList[src].board)
end)

RegisterServerEvent('ta-base:gamemodes:server:gungame:leave')
AddEventHandler('ta-base:gamemodes:server:gungame:leave', function()
    local src = source
    PlayerKillList[src] = nil
end)

function GetAvatar(identifier)
    if string.len(identifier) >= 30 then return "https://i.pinimg.com/474x/5c/be/a6/5cbea638934c3a0181790c16a7832179.jpg" end
    local sid  = tonumber(identifier:gsub("steam:",""), 16)
    local link = "http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=3753B61005BAFCB2E37A5A03A727A8AE&steamids="..sid
    local p = promise:new()
    PerformHttpRequest(link, function(errorCode, resultData, resultHeaders)
        a = json.decode(resultData)
        if not a then
            print('Steam api is temporarily unavailable, or too busy to respond')
            p:resolve("https://i.pinimg.com/474x/5c/be/a6/5cbea638934c3a0181790c16a7832179.jpg")
        else
            for k,v in pairs(a["response"].players) do
                p:resolve(v.avatarfull)
            end
        end
    end)
    return Citizen.Await(p)
end

RegisterServerEvent('ta-base:gamemodes:server:gungame:finishgame')
AddEventHandler('ta-base:gamemodes:server:gungame:finishgame', function(winner)
    local src = winner
    local name = GetPlayerName(winner)
    local identifier = GetPlayerIdentifier(src, 0)
    local avatar = GetAvatar(identifier)
    PlayerKillList = {}
    local modeplayers = GetPlayers()
    for _, player in pairs(modeplayers) do
        if GetPlayerRoutingBucket(player) == 2019 then
            TriggerClientEvent('ta-base:gamemodes:client:gungame:finishgame', player, name, avatar)
        end
    end
end)

RegisterServerEvent('ta-base:gungame:server:new-game')
AddEventHandler('ta-base:gungame:server:new-game', function(map)
    local src = source
    PlayerKillList[src] = nil
    PlayerKillList = {}
    if map == "1" then
        gungame_map_1 = true
        gungame_map_2 = false
        gungame_map_3 = false
        gungame_map_4 = false
        gungame_map_5 = false
        gungame_map_6 = false        
        TriggerClientEvent('ta-base:client:gungame:set-coords', src, 1)
        Wait(500)
        TriggerClientEvent('ta-base:gungame:client:new-game', src)
    elseif map == "2" then
        gungame_map_1 = false
        gungame_map_2 = true
        gungame_map_3 = false
        gungame_map_4 = false
        gungame_map_5 = false
        gungame_map_6 = false       
        TriggerClientEvent('ta-base:client:gungame:set-coords', src, 2)
        Wait(500)
        TriggerClientEvent('ta-base:gungame:client:new-game', src)
    elseif map == "3" then
        gungame_map_1 = false
        gungame_map_2 = false
        gungame_map_3 = true
        gungame_map_4 = false
        gungame_map_5 = false
        gungame_map_6 = false  
        TriggerClientEvent('ta-base:client:gungame:set-coords', src, 3)
        Wait(500)
        TriggerClientEvent('ta-base:gungame:client:new-game', src)
    elseif map == "4" then
        gungame_map_1 = false
        gungame_map_2 = false
        gungame_map_3 = false
        gungame_map_4 = true
        gungame_map_5 = false
        gungame_map_6 = false  
        TriggerClientEvent('ta-base:client:gungame:set-coords', src, 4)
        Wait(500)
        TriggerClientEvent('ta-base:gungame:client:new-game', src)
    elseif map == "5" then
        gungame_map_1 = false
        gungame_map_2 = false
        gungame_map_3 = false
        gungame_map_4 = false
        gungame_map_5 = true
        gungame_map_6 = false  
        TriggerClientEvent('ta-base:client:gungame:set-coords', src, 5)
        Wait(500)
        TriggerClientEvent('ta-base:gungame:client:new-game', src)
    elseif map == "6" then
        gungame_map_1 = false
        gungame_map_2 = false
        gungame_map_3 = false
        gungame_map_4 = false
        gungame_map_5 = false
        gungame_map_6 = true  
        TriggerClientEvent('ta-base:client:gungame:set-coords', src , 6)
        Wait(500)
        TriggerClientEvent('ta-base:gungame:client:new-game', src)
    end
end)
