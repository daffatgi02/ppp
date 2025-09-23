Lobbies = {}

local function addLobby(player, lobbyName)
    for id, lobby in ipairs(Lobbies) do 
        for i, lobbyPlayer in ipairs(lobby.players) do
            if lobbyPlayer == player or GetPlayerRoutingBucket(lobbyPlayer) ~= lobby.bucket  then
                table.remove(lobby.players, i)
            end
        end

        if lobby.name == lobbyName then
            table.insert(lobby.players, player)

            SetPlayerRoutingBucket(player, lobby.bucket) 
        else
            if #lobby.players == 0 then
                table.remove(Lobbies, id)
            end
        end
    end
end

RegisterServerEvent("ta-lobbys:createLobby", function(lobby)
    local src = source

    local freeBucket = 10000

    while true do
        local found = false
        for _, lobby2 in ipairs(Lobbies) do
            if lobby2.bucket == freeBucket then
                found = true
                freeBucket = freeBucket + 1
                break
            end
        end
    
        if not found then
            break
        end
    
      Wait(0)
    end

    lobby.owner = src
    lobby.bucket = freeBucket
    lobby.players = {}

    table.insert(Lobbies, lobby)

    addLobby(src, lobby.name)
        
    TriggerClientEvent("ta-lobbys:sendCreatedLobby", -1, Lobbies)

    SetPlayerRoutingBucket(src, freeBucket)

    TriggerClientEvent("ta-lobbys:joined", src, lobby.gameMode, {lobby.x, lobby.y, lobby.z})
end)

RegisterServerEvent("ta-lobbys:joinLobby", function(lobby)
    local src = source

    addLobby(src, lobby.name)

    for key, lobbies in pairs(Lobbies) do
        if #lobbies.players < 1 then
            table.remove(Lobbies, key)
        end
    end

    TriggerClientEvent("ta-lobbys:sendCreatedLobby", -1, Lobbies)
    TriggerClientEvent("ta-lobbys:joined", src, lobby.gameMode, {lobby.x, lobby.y, lobby.z})
end)

RegisterServerEvent("ta-lobbys:playerLeft", function()
    local src = source

    for id, lobby in ipairs(Lobbies) do 
        for i, lobbyPlayer in ipairs(lobby.players) do
            if lobbyPlayer == src then
                table.remove(lobby.players, i)

                break
            end
        end

        if #lobby.players == 0 then
            table.remove(Lobbies, id)
        end
    end

    TriggerClientEvent("ta-lobbys:sendCreatedLobby", -1, Lobbies)
end)

AddEventHandler("playerDropped", function()
    local src = source

    for id, lobby in ipairs(Lobbies) do 
        for i, lobbyPlayer in ipairs(lobby.players) do
            if lobbyPlayer == src then
                table.remove(lobby.players, i)

                break
            end
        end

        if #lobby.players == 0 then
            table.remove(Lobbies, id)
        end
    end

    TriggerClientEvent("ta-lobbys:sendCreatedLobby", -1, Lobbies)
end)