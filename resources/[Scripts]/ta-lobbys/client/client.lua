Lobbies = {}

RegisterNetEvent("ta-lobbys:sendCreatedLobby", function(lobbies)
    Lobbies = lobbies
end)

RegisterNUICallback("loaded", function(_, cb)
    cb(Config.Maps)
end)

RegisterNUICallback("createLobby", function(lobby, cb)
    local status = true
    for _, Lobby in pairs(Lobbies) do
        if Lobby.name == lobby.name then
            status = false
            break
        end
    end

    if status then
        SetNuiFocus(0, 0)
        TriggerServerEvent("ta-lobbys:createLobby", lobby)
        TriggerEvent('ta-base:privatelobby', lobby.map, lobby.gameMode, lobby.damageType, lobby.name)
    end

    cb(status)
end)

RegisterNetEvent("ta-lobbys:openMainLobby", function()
    SetNuiFocus(1, 1)
    SendNUIMessage({
        action = "openUi",
        lobbies = Lobbies
    })
end)

RegisterNUICallback("ta-lobbys:client:menu-back", function()
    DoScreenFadeOut(500) Wait(600)
    TriggerEvent('ta-base:client:joingame')
    while not IsScreenFadedOut() do Citizen.Wait(100) end
    Wait(700) DoScreenFadeIn(1500)
    SetNuiFocus(0, 0)
end)

RegisterNUICallback("joinLobby", function(lobby)
    SetNuiFocus(0, 0)
    TriggerServerEvent("ta-lobbys:joinLobby", lobby)
    TriggerEvent('ta-base:privatelobby', lobby.map, lobby.gameMode, lobby.damageType, lobby.name)
end)

RegisterNetEvent("ta-lobbys:joined", function()
    SetNuiFocus(0, 0)
    SendNUIMessage({
        action = "close",
    })
end)