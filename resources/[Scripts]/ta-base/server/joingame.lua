local gamemodes = {}

RegisterServerEvent("ta-base:server:joingame", function(sentgamemode)
    local src = source
    local addedGame = AddPlayer(sentgamemode, src)

    TriggerClientEvent("ta-base:client:updatePlayers", -1, addedGame.mode, addedGame.players)
end)

function AddPlayer(sentgamemode, src)
    local gameModeData = gamemodes[sentgamemode] and gamemodes[sentgamemode] or {
        players = 0,
        mode = sentgamemode,
        sources = {}
    }

    gameModeData.sources[src] = true
    gameModeData.players = gameModeData.players + 1
    gamemodes[sentgamemode] = gameModeData
    return gameModeData
end

function GetPlayerGamemode(src)
    for _, gamemode in pairs(gamemodes) do
        if gamemode.sources[src] then
            return gamemodes[_]
        end
    end

    return false
end


RegisterServerEvent("ta-base:server:firstJoin", function()
    TriggerClientEvent("ta-base:client:firstJoin", source, gamemodes)
end)

RegisterServerEvent("ta-base:server:gamemodeLeft", function()
    local src = source
    local gamemode = GetPlayerGamemode(src)
    if gamemode then 
        gamemodes[gamemode.mode].players = gamemodes[gamemode.mode].players - 1
        gamemodes[gamemode.mode].sources[src] = false
        -- gamemode.players = gamemode.players - 1
        TriggerClientEvent("ta-base:client:updatePlayers", -1, gamemodes[gamemode.mode].mode, gamemodes[gamemode.mode].players)
    end
end)

RegisterServerEvent("ta-base:server:gamemodeLeftServer", function(playerId)
    local src = playerId
    local gamemode = GetPlayerGamemode(src)
    if gamemode then 
        gamemodes[gamemode.mode].players = gamemodes[gamemode.mode].players - 1
        gamemodes[gamemode.mode].sources[src] = false
        TriggerClientEvent("ta-base:client:updatePlayers", -1, gamemodes[gamemode.mode].mode, gamemodes[gamemode.mode].players)
    end
end)

RegisterServerEvent('ta-base:server:UpdatePlayerCounts', function()
    local src = source 
    print("update deniyoz")

    for k, v in pairs(gamemodes) do
        print(v.mode, v.players)
        TriggerClientEvent("ta-base:client:updatePlayers", src, v.mode, v.players)
    end
end)

AddEventHandler("esx:playerDropped", function(playerid)
    local src = playerid
    TriggerEvent("ta-base:server:gamemodeLeftServer", src)
    PlayerKillList[src] = nil
end)