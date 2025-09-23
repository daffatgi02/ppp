driveby_car = nil

local vehicles = {
    'jugular',
    'gauntlet4',
    'elegy',
    'kuruma',
    'dominator3',
}

function rancomcar()
    return vehicles[math.random(#vehicles)]
end

function Driveby_SpawnVehicle(vehicle)
    model2 = vehicle
    ESX.Streaming.RequestModel(model2)
    local kordinat = GetEntityCoords(PlayerPedId())
    driveby_car = CreateVehicle(model2, kordinat.x, kordinat.y, kordinat.z - 1, GetEntityHeading(PlayerPedId()), true, false)
    local networkId = NetworkGetNetworkIdFromEntity(driveby_car)
    SetVehicleNumberPlateText(driveby_car, 'TA')
    SetVehicleRadioEnabled(driveby_car, false)
    SetNetworkIdCanMigrate(networkId, true)
    SetVehicleHasBeenOwnedByPlayer(driveby_car, true)
    SetModelAsNoLongerNeeded(model2)
    SetVehicleFixed(driveby_car)
    SetVehicleDeformationFixed(driveby_car)
    SetVehicleEngineHealth(driveby_car, 910.00)
    SetVehiclePetrolTankHealth(driveby_car, 910.00)    
    SetPedIntoVehicle(PlayerPedId(), driveby_car, -1)
    RequestCollisionAtCoord(kordinat.x, kordinat.y, kordinat.z)
    FreezeEntityPosition(PlayerPedId(), false)
    Wait(200)
    TaskWarpPedIntoVehicle(PlayerPedId(), driveby_car, -1)
	SetVehicleEngineOn(driveby_car, true, true)
end

RegisterNetEvent('ta-base:driveby:spawncar')
AddEventHandler('ta-base:driveby:spawncar', function()
    DeleteVehicle(driveby_car)
    Driveby_SpawnVehicle(rancomcar())
end)

RegisterNetEvent('ta-base:driveby:delcar')
AddEventHandler('ta-base:driveby:delcar', function()
    DeleteVehicle(driveby_car) 
    driveby_car = nil
end)