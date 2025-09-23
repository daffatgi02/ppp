ESX = exports['es_extended']:getSharedObject()

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

ESX.RegisterServerCallback("ta-vip:getPlayerIsVip", function(src, cb)
    local result = exports["oxmysql"]:query_async("SELECT vip FROM users WHERE identifier = @identifier",
    { ['@identifier'] = PlayerIdentifier('steam', src) })
    cb(result[1])
end)

RegisterServerEvent("ta-vip:setPlayerSettings", function(id)
    local src = id and id or source
    local nickColor = exports["oxmysql"]:query_async("SELECT nick_color FROM users WHERE identifier = @identifier",
    { ['@identifier'] = PlayerIdentifier('steam', src) })[1]

    local dsMessage = exports["oxmysql"]:query_async("SELECT dc_message FROM users WHERE identifier = @identifier",
    { ['@identifier'] = PlayerIdentifier('steam', src) })[1]

    local dsBanner = exports["oxmysql"]:query_async("SELECT dc_banner FROM users WHERE identifier = @identifier",
    { ['@identifier'] = PlayerIdentifier('steam', src) })[1]
 
    local maincoord = exports["oxmysql"]:query_async("SELECT main_coord FROM users WHERE identifier = @identifier",
    { ['@identifier'] = PlayerIdentifier('steam', src) })[1]

    TriggerClientEvent("ta-vip:nickColor", src, nickColor.nick_color)
    TriggerClientEvent("ta-vip:dsMessage", src, dsMessage.dc_message)
    TriggerClientEvent("ta-vip:dsBanner", src, dsBanner.dc_banner)
    TriggerClientEvent("ta-vip:maincoord", src, maincoord.main_coord)
end)
  
RegisterServerEvent("ta-vip:setNickColor", function(color) 
    local src = source
    exports["oxmysql"]:query_async("UPDATE users SET nick_color = ? WHERE identifier = ?", { color, PlayerIdentifier('steam', src) })
    TriggerEvent("ta-vip:setPlayerSettings", src)
end)
  
RegisterServerEvent("ta-vip:setDeathMessage", function(mesg) 
    local src = source
    exports["oxmysql"]:query_async("UPDATE users SET dc_message = ? WHERE identifier = ?", { mesg, PlayerIdentifier('steam', src) })
    TriggerEvent("ta-vip:setPlayerSettings", src)
end)
  
RegisterServerEvent("ta-vip:setMainScreen", function(id) 
    local src = source
    exports["oxmysql"]:query_async("UPDATE users SET main_coord = ? WHERE identifier = ?", { id, PlayerIdentifier('steam', src) })
    TriggerEvent("ta-vip:setPlayerSettings", src)
end)