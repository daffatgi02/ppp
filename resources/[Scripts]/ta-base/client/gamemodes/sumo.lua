sumo_yokoldi = false
sumo_pasifmod = false
sumo_pasifmod_kapa = false

sumo_car = nil

RegisterNetEvent('ta-base:sumo:spawncar')
AddEventHandler('ta-base:sumo:spawncar', function()
    Sumo_SpawnVehicle('issi5')
end)

RegisterNetEvent('ta-base:sumo:deletecar')
AddEventHandler('ta-base:sumo:deletecar', function()
    sumo_car = nil
    DeleteVehicle(sumo_car)
end)

function Sumo_SpawnVehicle(vehicle)
    model2 = vehicle
    ESX.Streaming.RequestModel(model2)
    local kordinat = GetEntityCoords(PlayerPedId())
    sumo_car = CreateVehicle(model2, kordinat.x, kordinat.y, kordinat.z - 1, GetEntityHeading(PlayerPedId()), true, false)
    local networkId = NetworkGetNetworkIdFromEntity(sumo_car)
    SetVehicleNumberPlateText(sumo_car, 'TA')
    SetVehicleRadioEnabled(sumo_car, false)
    SetNetworkIdCanMigrate(networkId, true)
    SetVehicleHasBeenOwnedByPlayer(sumo_car, true)
    SetModelAsNoLongerNeeded(model2)
    SetVehicleFixed(sumo_car)
    SetVehicleEngineHealth(sumo_car, 1000.00)
    SetVehiclePetrolTankHealth(sumo_car, 1000.00)    
    SetPedIntoVehicle(PlayerPedId(), sumo_car, -1)
    RequestCollisionAtCoord(kordinat.x, kordinat.y, kordinat.z)
    Wait(200)
    TaskWarpPedIntoVehicle(PlayerPedId(), sumo_car, -1)
	SetVehicleEngineOn(sumo_car, true, true)
    FreezeEntityPosition(PlayerPedId(), false)
end

Citizen.CreateThread(function()
	while true do 
		wait = 1000
        if advanced_sumo then
            wait = 1
            local kordinat = GetEntityCoords(PlayerPedId())
            if not sumo_yokoldi then
                if kordinat.z < 1345.0 then
                    FreezeEntityPosition(PlayerPedId(), true)
                    DisableControlAction(0, 32, true)
                    DisableControlAction(0, 33, true)
                    DisableControlAction(0, 34, true)
                    DisableControlAction(0, 35, true)
                    sumo_yokoldi = true
                    DoScreenFadeOut(500) Wait(1000)
                    sumo_pasifmod = true
                    DeleteVehicle(GetVehiclePedIsUsing(PlayerPedId()))
                    while not IsScreenFadedOut() do Citizen.Wait(100) end
                    Wait(200) DoScreenFadeIn(500)
                    RandomSpawn('advanced_sumo')
                    Wait(4000)
                    sumo_pasifmod = false
                    sumo_yokoldi = false
                    sumo_pasifmod_kapa = true
                end
            end
        end
        Wait(wait)
    end
end)

Citizen.CreateThread(function()
	while true do 
		wait = 1000
        if advanced_sumo then
            wait = 1
            DisableControlAction(0, 75, true) 
            SetPedSuffersCriticalHits(PlayerPedId(), true)
            SetEntityCanBeDamaged(sumo_car, false)
            SetVehicleExplodesOnHighExplosionDamage(sumo_car, false)
            DisablePlayerFiring(PlayerPedId()) SetEntityInvincible(PlayerPedId(), true) SetPlayerInvincible(PlayerPedId(), true)
            if sumo_pasifmod then
                local vehicles = GetGamePool("CVehicle")
                for _, vehicle in pairs(vehicles) do
                    SetEntityAlpha(vehicle, 155, false)
                    SetEntityNoCollisionEntity(vehicle, PlayerPedId(), true)
                end
                SetPedCanRagdoll(PlayerPedId(), false) SetEntityAlpha(PlayerPedId(), 155, false) SetLocalPlayerAsGhost(true)
                DisableControlAction(0, 24,true) DisableControlAction(0, 69,true) DisableControlAction(0, 92,true)
                DisableControlAction(0, 106,true) DisableControlAction(0, 122,true) DisableControlAction(0, 135,true)
                DisableControlAction(0, 142,true) DisableControlAction(0, 144,true) DisableControlAction(0, 257,true)
                DisableControlAction(0, 329,true) DisableControlAction(0, 346,true) DisableControlAction(0, 45,true)
                DisableControlAction(0, 80,true) DisableControlAction(0, 140,true) DisableControlAction(0, 250,true)
                DisableControlAction(0, 263,true)
                for _, player in ipairs(GetActivePlayers()) do
                    if player ~= PlayerId() and NetworkIsPlayerActive(player) then
                        SetEntityAlpha(GetPlayerPed(player), 155, false)
                    end
                end
            else
                if sumo_pasifmod_kapa then
                    local vehicles = GetGamePool("CVehicle")
                    for _, vehicle in pairs(vehicles) do
                        SetEntityAlpha(vehicle, 255, false)
                    end
                    SetPedCanRagdoll(PlayerPedId(), true)
                    SetEntityAlpha(PlayerPedId(), 255, false) SetLocalPlayerAsGhost(false) EnableControlAction(0, 24,true)
                    EnableControlAction(0, 69,true) EnableControlAction(0, 92,true) EnableControlAction(0, 106,true)
                    EnableControlAction(0, 122,true) EnableControlAction(0, 135,true) EnableControlAction(0, 142,true)
                    EnableControlAction(0, 144,true) EnableControlAction(0, 257,true) EnableControlAction(0, 329,true)
                    EnableControlAction(0, 346,true)
                    sumo_pasifmod_kapa = false
                end
                for _, player in ipairs(GetActivePlayers()) do
                    if player ~= PlayerId() and NetworkIsPlayerActive(player) then
                        SetEntityAlpha(GetPlayerPed(player), 255, false)
                    end
                end
            end
        end
        Wait(wait)
    end
end)
