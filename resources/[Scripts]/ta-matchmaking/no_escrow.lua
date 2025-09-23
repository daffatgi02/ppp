RegisterNetEvent("ta-matchmaking:respawn", function()
    DoScreenFadeOut(500)
    Wait(100)
    Citizen.Wait(1000)
    SetEntityVisible(PlayerPedId(), false, 0)
    SetLocalPlayerAsGhost(true)
    Wait(500)
    NetworkSetInSpectatorMode(0, PlayerPedId())
    Wait(0)
    TriggerEvent('hopbala123')
    SetEntityInvincible(PlayerPedId(), false)
    SetPlayerInvincible(PlayerPedId(), false)
    while not IsScreenFadedOut() do Citizen.Wait(100) end
    Wait(100)
    DoScreenFadeIn(500)
    SetEntityVisible(PlayerPedId(), true, 0)
    SetLocalPlayerAsGhost(false)
    FreezeEntityPosition(PlayerPedId(), false)
    SetPedArmour(PlayerPedId(), 200)
    SetEntityHealth(PlayerPedId(), 200)
    SetLocalPlayerAsGhost(false)
    if Bools.ingame then
        SetEntityCoords(PlayerPedId(), curmap.x, curmap.y, curmap.z, false, false, false, false)
    end
    BQFunctions.Revive()
    if Bools.ingame then
        SetEntityCoords(PlayerPedId(), curmap.x, curmap.y, curmap.z, false, false, false, false)
    end
    TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_pistol", "remove")
    TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_pistol", "add", true)
    TriggerServerEvent("ta-matchmaking:JoinChunk")
    BQFunctions.GeriSayim()
end)

BQFunctions.Revive = function()    
    if BQVersus.ReviveTrigger then
        TriggerEvent(BQVersus.ReviveTrigger)
    end
end


BQFunctions.JoinMatch = function()

end

BQFunctions.MatchEnd = function()
    TriggerEvent('ta-death:client:matchmaking', "left")
    TriggerEvent('ta-base:client:joingame')
end