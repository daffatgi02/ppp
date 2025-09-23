ESX = exports['es_extended']:getSharedObject()

local badWords = {
    "allah",
    "a l l a h",
    "4llah",
    "4ll4h",
    "a11ah",
    "4114h",
    "ALLAH",
    "4LLAH",
    "A L L A H",
    "sik",
    "sikiş",
    "sikko",
    "siker",
    "siksok",
    "penis",
    "pipi",
    "çük",
    "büllük",
    "bulluk",
    "büzzük",
    "buzzuk",
    "nigga",
    "nibba",
    "niga",
    "niba",
    "nibbar",
    "niggar",
    "nigger",
    "negro",
    "nero",
    "niger",
    "nigar",
    "zenci",
    "zencuk",
    "zencu",
    "fave",
    "f a v e",
    "f 4 v 3",
    "f4v3",
    "fav3",
    "f4ve",
    "f a v 3",
    "f 4 v e",
    "discord.gg",
    "discord",
    "gg.",
    "gg/",
    "yarrak",
    "y4rrak",
    "y4rr4k",
    "yarra4k",
    "rrr",
    "amcık",
    "amcik",
    "4mcik",
    "vajina",
    "4mcık",
    "sex",
    "gerdek",
    "s3x",
    "sakso",
    "kuran",
    "kitap",
    "peygamber",
    "muhammed",
    "kabe",
    "kur-an",
    "islam",
    "atatürk",
    "atat",
    "kürt",
    "ataturk",
    "4t4t",
    "kürdo"
}
local crew_table = {}
local dev = true

Citizen.CreateThread(function()
    local result = json.decode(LoadResourceFile(GetCurrentResourceName(), "data.json"))
    if result then
        crew_table = result
    end
end)

function CheckTable(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    
    return false
end

function checkCrewNameHasBadWords(name)
    local p = promise.new()
    for _, words in pairs(badWords) do
        local lowerName = name:lower()
        local lowerWord = words:lower()
        if lowerName:match(lowerWord) then
            p:resolve(true)
        end
    end
    p:resolve(false)
	return Citizen.Await(p)
end

function checkPlayerIsInAnyCrew(identifier)
    local p = promise.new()
    crew_table = json.decode(LoadResourceFile(GetCurrentResourceName(), "data.json"))
    for k,istanbultrip in pairs(crew_table) do
        for k,v in pairs(istanbultrip["leaders"]) do
            if v == identifier then 
                p:resolve( istanbultrip, true )
                break
            end
        end
        for k,v in pairs(istanbultrip["members"]) do
            if v == identifier then 
                p:resolve( istanbultrip, false )
                break
            end
        end
    end
    p:resolve(false)
	return Citizen.Await(p)
end

function checkIsPlayerLeader(identifier, crew)
    local p = promise.new()
    crew_table = json.decode(LoadResourceFile(GetCurrentResourceName(), "data.json"))
    for k, v in pairs(crew_table[crew]["leaders"]) do
        if v == identifier then 
            p:resolve( true )
            break
        end
    end
    p:resolve(false)
	return Citizen.Await(p)
end

exports("CheckTable", CheckTable)
exports("checkPlayerIsInAnyCrew", checkPlayerIsInAnyCrew)
exports("checkCrewNameHasBadWords", checkCrewNameHasBadWords)
exports("checkIsPlayerLeader", checkIsPlayerLeader)

ESX.RegisterServerCallback("ta-crew:getPlayerInformation", function(source, cb, members)
    allMembers = {}

    for k, v in pairs(members) do
        MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
			['@identifier'] = v
		}, function(result)
            result[1].identifier = v
            table.insert(allMembers, result[1])
		end)
        
    end
    
    Wait(1000)
    cb(allMembers)
end)

RegisterNetEvent("getcrew")
AddEventHandler("getcrew", function()
    local src = source
    local leader = false
    local identifier = GetPlayerIdentifiers(src)[1]
    local leadercrew = ""

    crew_table = json.decode(LoadResourceFile(GetCurrentResourceName(), "data.json"))

    for p,l in pairs(crew_table) do
        for k,v in pairs(l["leaders"]) do
            if v:match(identifier) then 
                leader = true
                leadercrew = l
            else
                leader = false
            end
            if leader then break end
        end
        if leader then break end
    end

    local member = false
    local membercrew = ""
    for p,l in pairs(crew_table) do
        for k,v in pairs(l["members"]) do
            if v:match(identifier) then 
                member = true
                membercrew = l
                break
            else
                member = false
            end
            if member then break end
        end
        if member then break end
    end
    
    if leader then
        TriggerClientEvent("send-data:cl", src, leadercrew.name, true, #leadercrew.members + #leadercrew.leaders, leadercrew.crewPhoto)
    elseif member then
        TriggerClientEvent("send-data:cl", src, membercrew.name, false, #membercrew.members + #membercrew.leaders, membercrew.crewPhoto)
    end
end)

RegisterNetEvent("createcrew:sv")
AddEventHandler("createcrew:sv", function(pfp, gangname, altname, color)
    local src = source
    local identifier = GetPlayerIdentifiers(src)[1]
    local result = true
    crew_table = json.decode(LoadResourceFile(GetCurrentResourceName(), "data.json"))
    local crew_name = string.gsub(gangname, "%s+", "-")
    
    if checkCrewNameHasBadWords(crew_name) then print("got bad words nibba") return end

    if not checkPlayerIsInAnyCrew(identifier) then 
        -- print("sucess u created crew")
        crew_table[crew_name] = {["leaders"]={},["members"]={}}
        table.insert(crew_table[crew_name]["leaders"], identifier)
        crew_table[crew_name]["name"] = crew_name
        crew_table[crew_name]["kill"] = 0
        crew_table[crew_name]["death"] = 0
        crew_table[crew_name]["altname"] = altname
        crew_table[crew_name]["color"] = color
        crew_table[crew_name]["crewPhoto"] = pfp or "https://cdn.discordapp.com/attachments/962535218403754054/1065744986131410965/20221103_193904.jpg"
    end

    SaveResourceFile(GetCurrentResourceName(), "data.json", json.encode(crew_table, { indent = true }))
    -- createRole(crew_name, crew_table)
    Wait(1000)
    for k,v in ipairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            -- TODO COLOR ON DISCORD
            -- giveCrewRoleToPlayer(crew_name, v:gsub("discord:", ""), crew_table, color)
        end
    end
end)

RegisterNetEvent("joincrew:sv")
AddEventHandler("joincrew:sv", function(gangname)
    local src = source
    local identifier = GetPlayerIdentifiers(src)[1]
    local result = false
    crew_table = json.decode(LoadResourceFile(GetCurrentResourceName(), "data.json"))
    local crew_name = string.gsub(gangname, "%s+", "-")
    if not checkPlayerIsInAnyCrew(identifier) then 
        -- print("sucess u joined crew")
        table.insert(crew_table[crew_name]["members"], identifier)
    else
    --    print("u have already crew before creating new u must close ur crew")
    end
    SaveResourceFile(GetCurrentResourceName(), "data.json", json.encode(crew_table, { indent = true }))
    for k,v in ipairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            -- giveCrewRoleToPlayer(crew_name, v:gsub("discord:", ""), crew_table)
        end
    end
end)

RegisterNetEvent("closecrew:sv")
AddEventHandler("closecrew:sv", function(gangname)
    local src = source
    local identifier = GetPlayerIdentifiers(src)[1]
    crew_table = json.decode(LoadResourceFile(GetCurrentResourceName(), "data.json"))
    local res = false
    for k,v in pairs(crew_table[gangname]["leaders"]) do
        if res == false then 
            if v == identifier then 
                crew_table[gangname] = nil
                res = true
            else 
                res = false
            end
        end
    end
    
    if res then 
        -- print(gangname, "u closed crew")
    else
        -- print("u dont have any crew")
    end
    
    SaveResourceFile(GetCurrentResourceName(), "data.json", json.encode(crew_table, { indent = true }))
end)

RegisterNetEvent("leavecrew:sv")
AddEventHandler("leavecrew:sv", function(gangname)
    local src = source
    local identifier = GetPlayerIdentifiers(src)[1]
    crew_table = json.decode(LoadResourceFile(GetCurrentResourceName(), "data.json"))
    local res = false
    for k,v in pairs(crew_table[gangname]["members"]) do
        if res == false then 
            if v == identifier then 
                crew_table[gangname]["members"][k] = nil
                res = true
            else 
                res = false
            end
        end
    end

    if res then 
        -- print(gangname, "u closed crew")
    else
        -- print("u dont have any crew")
    end

    SaveResourceFile(GetCurrentResourceName(), "data.json", json.encode(crew_table, { indent = true }))
end)

RegisterNetEvent("kickmember:sv")
AddEventHandler("kickmember:sv", function(name, num)
    local identifier = num.identifier
    crew_table = json.decode(LoadResourceFile(GetCurrentResourceName(), "data.json"))
    for k, v in ipairs(crew_table[name]["members"]) do
        if (v == identifier) then
            table.remove(crew_table[name]["members"], k)
        end
    end
    SaveResourceFile(GetCurrentResourceName(), "data.json", json.encode(crew_table, { indent = true }))
end)

RegisterNetEvent("invitemember:sv")
AddEventHandler("invitemember:sv", function(name, num)
    local src = num
    local identifier = GetPlayerIdentifiers(source)[1]
    crew_table = json.decode(LoadResourceFile(GetCurrentResourceName(), "data.json"))
    local pCount = #crew_table[name]["members"] + #crew_table[name]["leaders"]
    TriggerClientEvent("invitemember:cl", src, name, pCount, crew_table[name]["crewPhoto"])
end)

RegisterNetEvent("ta-crew:server:change-name")
AddEventHandler("ta-crew:server:change-name", function(data)
    local src = num
    local identifier = GetPlayerIdentifiers(source)[1]
    local name = checkPlayerIsInAnyCrew(identifier).name
    if not name then return end
    local leader = checkIsPlayerLeader(identifier, name)
    if not leader then return end
    if checkCrewNameHasBadWords(data) then print("got bad words nibba") return end
    crew_table = json.decode(LoadResourceFile(GetCurrentResourceName(), "data.json"))
    print("changed2", name, data)
    local newData = crew_table[name]
    crew_table[name].name = data
    crew_table[name] = nil
    crew_table[data] = newData
    SaveResourceFile(GetCurrentResourceName(), "data.json", json.encode(crew_table, { indent = true }))
end)

RegisterNetEvent("ta-crew:server:change-photo")
AddEventHandler("ta-crew:server:change-photo", function(data)
    local src = num
    local identifier = GetPlayerIdentifiers(source)[1]
    local name = checkPlayerIsInAnyCrew(identifier).name
    if not name then return end
    local leader = checkIsPlayerLeader(identifier, name)

    print(name, leader)
    if not leader then return end
    print("changed", name, data)
    crew_table = json.decode(LoadResourceFile(GetCurrentResourceName(), "data.json"))
    crew_table[name].crewPhoto = data
    SaveResourceFile(GetCurrentResourceName(), "data.json", json.encode(crew_table, { indent = true }))
end)

ESX.RegisterServerCallback("ta-crew:fetchAllCrew", function(source, cb)
    cb(crew_table)
end)

ESX.RegisterServerCallback("ta-crew:getCrewBanner", function(source, cb, crewName)
    if not (crew_table[crewName] == nil) then
        cb(crew_table[crewName]["crewPhoto"])
    else
        cb("null")
    end
end)

-- ### MM
crewMatchmaking = {}
RegisterServerEvent('ta-crew:mm:server:createParty', function()
    if (crewMatchmaking[source]) then
        return
    end

    leader = ESX.GetPlayerFromId(source)
    crewMatchmaking[source] = {}
    crewMatchmaking[source].players = {}
    crewMatchmaking[source]["playerInformations"] = {}
    crewMatchmaking[source].isReady = false
    crewMatchmaking[source].inMatch = false
    table.insert(crewMatchmaking[source]["playerInformations"], {name = GetPlayerName(source), avatar = leader.avatar, rank = leader.rank})
    table.insert(crewMatchmaking[source].players, source)
    -- print("Party successfully created!")
end)

RegisterServerEvent('ta-crew:mm:server:invitePlayer', function(data)
    local target = data.id

    if (target == source) then
        -- print("you cant invite yourself xD")
        return
    end

    if not (GetPlayerName(target)) then
        -- print("player is not online")
        return
    end

    if (crewMatchmaking[target]) then
        -- print("player is on another crew.")
        return
    end

    if not (crewMatchmaking[source]) then
        -- print("you are not in a party or you dont leader of the party")
        return
    end

    if (#crewMatchmaking[source].players > 1) then
        -- print("your party is full")
        return
    end

    if (crewMatchmaking[source].inMatch) then
        -- print("you cant invite someone while in match")
        return
    end

    local plyCrew = checkPlayerIsInAnyCrew(GetPlayerIdentifiers(source)[1]).name
    local tgtCrew = checkPlayerIsInAnyCrew(GetPlayerIdentifiers(target)[1]).name

    if not (plyCrew or tgtCrew) or not (plyCrew == tgtCrew) then
        -- print("you are not in same crew")
        return
    end
    crewMatchmaking[target] = crewMatchmaking[source]
    crewMatchmaking[target]["accepted"] = false
    -- print("sended")
    Wait(15000)
    
    if (crewMatchmaking[target]["accepted"] == false) then
        crewMatchmaking[target] = nil
        -- print("The " .. GetPlayerName(target) .. " is not accepted your party request")
    end
end)

-- RegisterCommand("acceptparty", function(source, args, raw)
--     if not (crewMatchmaking[source]) then
--         print("you are not invited in a party")
--         return
--     end

--     if (#crewMatchmaking[source].players > 1) then
--         print("you cant join party is full")
--         return
--     end

--     if (crewMatchmaking[source].inMatch) then
--         print("your party is already in a match")
--         return
--     end

--     member = ESX.GetPlayerFromId(source)
--     crewMatchmaking[source]["accepted"] = true
--     table.insert(crewMatchmaking[source].players, source)
--     table.insert(crewMatchmaking[source]["playerInformations"], {name = GetPlayerName(source), avatar = member.avatar, rank = member.rank})
--     print("you are in party!")
-- end)

-- RegisterCommand("partymm", function(source, args, raw)
--     if (#crewMatchmaking[source].players > 1) then
--         print("your party is not allowed to matchmake (because of player count)")
--         return
--     end

--     if (crewMatchmaking[source].inMatch) then
--         print("your party is already in a match")
--         return
--     end

--     crewMatchmaking[source].isReady = true
--     stopWhile = false
    
--     CreateThread(function()
--         while true do
--             for k, v in pairs(crewMatchmaking) do
--                 if (crewMatchmaking[source] == crewMatchmaking[k]) then return end

--                 if (v.isReady) then
--                     for _, playerId in pairs(crewMatchmaking[source].players) do
--                         local playerPed = GetPlayerPed(playerId)
--                         SetEntityCoords(playerPed, 90.5572, -1928.8, 20.8075, false, false, false, false)
--                     end

--                     for _, playerId in pairs(v.players) do
--                         local playerPed = GetPlayerPed(playerId)
--                         SetEntityCoords(playerPed, 90.5572, -1928.8, 20.8075, false, false, false, false)
--                     end

--                     crewMatchmaking[source].isReady = false
--                     v.isReady = false

--                     crewMatchmaking[source].inMatch = true
--                     v.inMatch = true

--                     crewMatchmaking[source].kills = 0
--                     v.kills = 0

--                     stopWhile = true
--                 end
--             end
--             if stopWhile then break end
--             Wait(2000)
--         end
--     end)
-- end)

ESX.RegisterServerCallback("ta-crew:mm:callback:fetchPlayerInformations", function(source, cb)
    cb(crewMatchmaking[source]["playerInformations"])
end)

-- RegisterServerEvent('esx:onPlayerDeath', function(data)
--     if not crewMatchmaking[data.killerServerId] then return end
--     crewMatchmaking[data.killerServerId].kills = crewMatchmaking[data.killerServerId].kills + 1

--     if (crewMatchmaking[data.killerServerId].kills) > 5 or (crewMatchmaking[data.victimServer].kills > 5) then
--         crewMatchmaking[data.killerServerId].inMatch = false
--         crewMatchmaking[data.victimServer].inMatch = false
--         crewMatchmaking[data.killerServerId].kills = nil
--         crewMatchmaking[data.victimServer].kills = nil
--     end
-- end)

-- ### DISCORD ROL ACMA VIBERIN ANASINI BACISINI SIKIYIM
local guildId = "1109257823424090214"
local botToken = "MTEzMjc1ODMzMDYwNDAxNTY0Nw.GHGC78.rJVch_p_7TPgVbNyjnMdYW_H5LHz8uVzPAVKTI"

function removeFirst(tbl, val)
    for i, v in ipairs(tbl) do
      if v == val then
        return table.remove(tbl, i)
      end
    end
end

function createRole(name, crew_table, dcId)
    PerformHttpRequest("https://discord.com/api/v9/guilds/" .. guildId .. "/roles", function(err, response, headers, errData)
        local responseData = json.decode(response)
        crew_table[name]["roleId"] = responseData.id
        SaveResourceFile(GetCurrentResourceName(), "data.json", json.encode(crew_table))
    end, "POST", json.encode({name=name}), {["authorization"]=botToken, ["Content-Type"]="application/json"})
end

function deleteRole(crew_name, crew_table)
    PerformHttpRequest("https://discord.com/api/v9/guilds/" .. guildId .. "/roles/" .. crew_table[crew_name]["roleId"], function(err, response, headers, errData)
        SaveResourceFile(GetCurrentResourceName(), "data.json", json.encode(crew_table))
    end, "DELETE", "", {["authorization"]=botToken, ["Content-Type"]="application/json"})
end

function giveCrewRoleToPlayer(crew_name, dcId, crew_table)
    PerformHttpRequest("https://discord.com/api/v9/users/" .. dcId .. "/profile?with_mutual_guilds=true&with_mutual_friends_count=false&guild_id=" .. guildId, function(err, response, headers, errData)
        local roles = json.decode(response).guild_member.roles
        table.insert(roles, crew_table[crew_name]["roleId"])
        PerformHttpRequest("https://discord.com/api/v9/guilds/" .. guildId .. "/members/" .. dcId, function(err, response, headers, errData)
            SaveResourceFile(GetCurrentResourceName(), "data.json", json.encode(crew_table))
        end, "PATCH", json.encode({roles=roles}), {["authorization"]=botToken, ["Content-Type"]="application/json"})
    end, "GET", "", {["authorization"]=botToken})
end

function removeCrewRoleToPlayer(crew_name, dcId, crew_table)
    PerformHttpRequest("https://discord.com/api/v9/users/" .. dcId .. "/profile?with_mutual_guilds=true&with_mutual_friends_count=false&guild_id=" .. guildId, function(err, response, headers, errData)
        local roles = json.decode(response).guild_member.roles
        removeFirst(roles, crew_table[crew_name]["roleId"])
        PerformHttpRequest("https://discord.com/api/v9/guilds/" .. guildId .. "/members/" .. dcId, function(err, response, headers, errData)
            SaveResourceFile(GetCurrentResourceName(), "data.json", json.encode(crew_table))
        end, "PATCH", json.encode({roles=roles}), {["authorization"]=botToken, ["Content-Type"]="application/json"})
    end, "GET", "", {["authorization"]=botToken})
end