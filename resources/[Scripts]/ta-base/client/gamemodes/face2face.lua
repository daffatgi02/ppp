facetoface_level = 0
f2f_yokoldi = false
f2f_pasifmod = false
f2f_pasifmod_kapa = false
local facetoface_blip

local facetoface_marker_coords = { -- fix
	[1] = {coords = vector3(-2649.7, -901.84, 1412.45)}, 
	[2] = {coords = vector3(-2784.8, -1017.2, 1412.45)}, 
	[3] = {coords = vector3(-2649.8, -1141.3, 1412.45)}, 
	[4] = {coords = vector3(-2515.3, -1017.4, 1412.44)}, 
}

local facetoface_spawns_1 = { -- fix
	[1] = {coords = vector3(-2628.3, -887.02, 1412.45), heading = 184.95}, 
	[2] = {coords = vector3(-2627.7, -907.53, 1412.45), heading = 174.76}, 
	[3] = {coords = vector3(-2668.4, -888.16, 1412.45), heading = 211.33}, 
	[4] = {coords = vector3(-2670.5, -915.27, 1412.45), heading = 236.46}, 
}
local facetoface_spawns_2 = { -- fix
	[1] = {coords = vector3(-2791.7, -1001.1, 1412.45), heading = 258.05}, 
	[2] = {coords = vector3(-2759.7, -1001.4, 1412.45), heading = 231.05}, 
	[3] = {coords = vector3(-2788.8, -1036.6, 1412.45), heading = 279.07}, 
	[4] = {coords = vector3(-2758.1, -1035.2, 1412.45), heading = 321.86}, 
}
local facetoface_spawns_3 = { -- fix
	[1] = {coords = vector3(-2668.2, -1146.6, 1412.45), heading = 334.34}, 
	[2] = {coords = vector3(-2630.9, -1130.7, 1412.45), heading = 34.1},
}
local facetoface_spawns_4 = { -- fix
	[1] = {coords = vector3(-2502.2, -1033.3, 1412.45), heading = 84.56}, 
	[2] = {coords = vector3(-2540.2, -1031.4, 1412.45), heading = 55.7}, 
	[3] = {coords = vector3(-2508.4, -997.81, 1412.45), heading = 103.11}, 
	[4] = {coords = vector3(-2538.5, -1000.7, 1412.45), heading = 119.86}, 
}

RegisterNetEvent('ta-base:facetoface:first')
AddEventHandler('ta-base:facetoface:first', function()
    facetoface_blip = F2F_MainBlip(facetoface_marker_coords[2].coords.x, facetoface_marker_coords[2].coords.y, facetoface_marker_coords[2].coords.z, "Point")
    facetoface_level = 0
end)

RegisterNetEvent('ta-base:client:updateBoard', function(fplayers)
    SendNUIMessage({
        action = "updateFPlayers",
        fplayers = fplayers
    })
end)

function F2F_SpawnVehicle(vehicle)
    model2 = vehicle
    ESX.Streaming.RequestModel(model2)
    local kordinat = GetEntityCoords(PlayerPedId())
    DeleteVehicle(GetVehiclePedIsUsing(PlayerPedId()))
    f2f_car = CreateVehicle(model2, kordinat.x, kordinat.y, kordinat.z -1.0, GetEntityHeading(PlayerPedId()), true, false)
    local networkId = NetworkGetNetworkIdFromEntity(f2f_car)
    SetVehicleNumberPlateText(f2f_car, 'TA')
    SetVehicleRadioEnabled(f2f_car, false)
    SetNetworkIdCanMigrate(networkId, true)
    SetVehicleHasBeenOwnedByPlayer(f2f_car, true)
    SetModelAsNoLongerNeeded(model2)
    TaskWarpPedIntoVehicle(PlayerPedId(), f2f_car, -1)
    SetVehicleFixed(f2f_car)
    SetVehicleEngineHealth(f2f_car, 1000.00)
    SetVehiclePetrolTankHealth(f2f_car, 1000.00)    
    SetPedIntoVehicle(PlayerPedId(), f2f_car, -1)
    RequestCollisionAtCoord(kordinat.x, kordinat.y, kordinat.z -1.0)
    SetVehicleEngineOn(f2f_car, true, false, true)
end

function F2F_MainBlip(x, y, z, text)
    local f2f_blip = AddBlipForCoord(x, y, z)
    SetBlipSprite(f2f_blip, 225)
    SetBlipDisplay(f2f_blip, 6)
    SetBlipScale(f2f_blip, 0.8)
    SetBlipColour(f2f_blip, 1)
    SetBlipAsShortRange(f2f_blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(f2f_blip)
    return f2f_blip
end

RegisterNetEvent('ta-base:facetoface:spawn')
AddEventHandler('ta-base:facetoface:spawn', function()
    local ped = PlayerPedId()
    if facetoface_level == 0 then
        local random = math.random(1,4)
        SetEntityCoords(ped, facetoface_spawns_1[random].coords.x, facetoface_spawns_1[random].coords.y, facetoface_spawns_1[random].coords.z - 2.0)
        SetEntityHeading(ped, facetoface_spawns_1[random].heading)
    elseif facetoface_level == 1 then
        local random = math.random(1,4)
        SetEntityCoords(ped, facetoface_spawns_2[random].coords.x, facetoface_spawns_2[random].coords.y, facetoface_spawns_2[random].coords.z - 2.0)
        SetEntityHeading(ped, facetoface_spawns_2[random].heading)
    elseif facetoface_level == 2 then
        local random = math.random(1,4)
        SetEntityCoords(ped, facetoface_spawns_4[random].coords.x, facetoface_spawns_4[random].coords.y, facetoface_spawns_4[random].coords.z - 2.0)
        SetEntityHeading(ped, facetoface_spawns_4[random].heading)
    elseif facetoface_level == 3 then
        local random = math.random(1,2)
        SetEntityCoords(ped, facetoface_spawns_3[random].coords.x, facetoface_spawns_3[random].coords.y, facetoface_spawns_3[random].coords.z - 2.0)
        SetEntityHeading(ped, facetoface_spawns_3[random].heading)
    elseif facetoface_level == 4 then
        local random = math.random(1,4)
        SetEntityCoords(ped, facetoface_spawns_1[random].coords.x, facetoface_spawns_1[random].coords.y, facetoface_spawns_1[random].coords.z - 2.0)
        SetEntityHeading(ped, facetoface_spawns_1[random].heading)
    elseif facetoface_level == 5 then
        local random = math.random(1,2)
        SetEntityCoords(ped, facetoface_spawns_3[random].coords.x, facetoface_spawns_3[random].coords.y, facetoface_spawns_3[random].coords.z - 2.0)
        SetEntityHeading(ped, facetoface_spawns_3[random].heading)
    elseif facetoface_level == 6 then
        local random = math.random(1,4)
        SetEntityCoords(ped, facetoface_spawns_2[random].coords.x, facetoface_spawns_2[random].coords.y, facetoface_spawns_2[random].coords.z - 2.0)
        SetEntityHeading(ped, facetoface_spawns_2[random].heading)
    elseif facetoface_level == 7 then
        local random = math.random(1,4)
        SetEntityCoords(ped, facetoface_spawns_4[random].coords.x, facetoface_spawns_4[random].coords.y, facetoface_spawns_4[random].coords.z - 2.0)
        SetEntityHeading(ped, facetoface_spawns_4[random].heading)
    elseif facetoface_level == 8 then
        local random = math.random(1,4)
        SetEntityCoords(ped, facetoface_spawns_1[random].coords.x, facetoface_spawns_1[random].coords.y, facetoface_spawns_1[random].coords.z - 2.0)
        SetEntityHeading(ped, facetoface_spawns_1[random].heading)
    elseif facetoface_level == 9 then
        local random = math.random(1,2)
        SetEntityCoords(ped, facetoface_spawns_3[random].coords.x, facetoface_spawns_3[random].coords.y, facetoface_spawns_3[random].coords.z - 2.0)
        SetEntityHeading(ped, facetoface_spawns_3[random].heading)
    elseif facetoface_level == 10 then
        local random = math.random(1,4)
        SetEntityCoords(ped, facetoface_spawns_4[random].coords.x, facetoface_spawns_4[random].coords.y, facetoface_spawns_4[random].coords.z - 2.0)
        SetEntityHeading(ped, facetoface_spawns_4[random].heading)
    elseif facetoface_level == 11 then
        local random = math.random(1,4)
        SetEntityCoords(ped, facetoface_spawns_2[random].coords.x, facetoface_spawns_2[random].coords.y, facetoface_spawns_2[random].coords.z - 2.0)
        SetEntityHeading(ped, facetoface_spawns_2[random].heading)
    elseif facetoface_level == 12 then
        local random = math.random(1,4)
        SetEntityCoords(ped, facetoface_spawns_1[random].coords.x, facetoface_spawns_1[random].coords.y, facetoface_spawns_1[random].coords.z - 2.0)
        SetEntityHeading(ped, facetoface_spawns_1[random].heading)
    end
    TriggerEvent('ta-base:facetoface:spawncar')
end)

RegisterNetEvent('ta-base:facetoface:spawncar')
AddEventHandler('ta-base:facetoface:spawncar', function()
    if facetoface_level == 0 then
        F2F_SpawnVehicle('caddy')
    elseif facetoface_level == 1 then
        F2F_SpawnVehicle('rhino')
    elseif facetoface_level == 2 then
        F2F_SpawnVehicle('cheetah')
    elseif facetoface_level == 3 then
        F2F_SpawnVehicle('cruiser')
    elseif facetoface_level == 4 then
        F2F_SpawnVehicle('brawler')
    elseif facetoface_level == 5 then
        F2F_SpawnVehicle('adder')
    elseif facetoface_level == 6 then
        F2F_SpawnVehicle('brawler')
    elseif facetoface_level == 7 then
        F2F_SpawnVehicle('pounder')
    elseif facetoface_level == 8 then
        F2F_SpawnVehicle('veto2')
    elseif facetoface_level == 9 then
        F2F_SpawnVehicle('kuruma2')
    elseif facetoface_level == 10 then
        F2F_SpawnVehicle('dune5')
    elseif facetoface_level == 11 then
        F2F_SpawnVehicle('phantom2')
    elseif facetoface_level == 12 then
        F2F_SpawnVehicle('futo2')
    end
end)

Citizen.CreateThread(function()
    while true do
        local wait = 1000
        if advanced_parkour then
            wait = 0
            local player = PlayerPedId()
            local playercoords = GetEntityCoords(player)
            if facetoface_level == 0 then
                local distance = GetDistanceBetweenCoords(playercoords, facetoface_marker_coords[2].coords.x, facetoface_marker_coords[2].coords.y, facetoface_marker_coords[2].coords.z, true)
                DrawMarker(4, facetoface_marker_coords[2].coords.x, facetoface_marker_coords[2].coords.y, facetoface_marker_coords[2].coords.z + 3.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 8.0, 8.0, 8.0, 238, 37, 37, 100, true, true, false, false, false, false, false)
                if   distance < 5.5 then
                    F2F_Levelup()
                end
            elseif facetoface_level == 1 then
                local distance = GetDistanceBetweenCoords(playercoords, facetoface_marker_coords[4].coords.x, facetoface_marker_coords[4].coords.y, facetoface_marker_coords[4].coords.z, true)
                DrawMarker(4, facetoface_marker_coords[4].coords.x, facetoface_marker_coords[4].coords.y, facetoface_marker_coords[4].coords.z + 3.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 8.0, 8.0, 8.0, 238, 37, 37, 100, true, true, false, false, false, false, false)
                if   distance < 5.5 then
                    F2F_Levelup()
                end
            elseif facetoface_level == 2 then
                local distance = GetDistanceBetweenCoords(playercoords, facetoface_marker_coords[3].coords.x, facetoface_marker_coords[3].coords.y, facetoface_marker_coords[3].coords.z, true)
                DrawMarker(4, facetoface_marker_coords[3].coords.x, facetoface_marker_coords[3].coords.y, facetoface_marker_coords[3].coords.z + 3.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 8.0, 8.0, 8.0, 238, 37, 37, 100, true, true, false, false, false, false, false)
                if   distance < 5.5 then
                    F2F_Levelup()
                end
            elseif facetoface_level == 3 then
                local distance = GetDistanceBetweenCoords(playercoords, facetoface_marker_coords[1].coords.x, facetoface_marker_coords[1].coords.y, facetoface_marker_coords[1].coords.z, true)
                DrawMarker(4, facetoface_marker_coords[1].coords.x, facetoface_marker_coords[1].coords.y, facetoface_marker_coords[1].coords.z + 3.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 8.0, 8.0, 8.0, 238, 37, 37, 100, true, true, false, false, false, false, false)
                if   distance < 5.5 then
                    F2F_Levelup()
                end
            elseif facetoface_level == 4 then
                local distance = GetDistanceBetweenCoords(playercoords, facetoface_marker_coords[3].coords.x, facetoface_marker_coords[3].coords.y, facetoface_marker_coords[3].coords.z, true)
                DrawMarker(4, facetoface_marker_coords[3].coords.x, facetoface_marker_coords[3].coords.y, facetoface_marker_coords[3].coords.z + 3.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 8.0, 8.0, 8.0, 238, 37, 37, 100, true, true, false, false, false, false, false)
                if   distance < 5.5 then
                    F2F_Levelup()
                end
            elseif facetoface_level == 5 then
                local distance = GetDistanceBetweenCoords(playercoords, facetoface_marker_coords[2].coords.x, facetoface_marker_coords[2].coords.y, facetoface_marker_coords[2].coords.z, true)
                DrawMarker(4, facetoface_marker_coords[2].coords.x, facetoface_marker_coords[2].coords.y, facetoface_marker_coords[2].coords.z + 3.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 8.0, 8.0, 8.0, 238, 37, 37, 100, true, true, false, false, false, false, false)
                if   distance < 5.5 then
                    F2F_Levelup()
                end
            elseif facetoface_level == 6 then
                local distance = GetDistanceBetweenCoords(playercoords, facetoface_marker_coords[4].coords.x, facetoface_marker_coords[4].coords.y, facetoface_marker_coords[4].coords.z, true)
                DrawMarker(4, facetoface_marker_coords[4].coords.x, facetoface_marker_coords[4].coords.y, facetoface_marker_coords[4].coords.z + 3.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 8.0, 8.0, 8.0, 238, 37, 37, 100, true, true, false, false, false, false, false)
                if   distance < 5.5 then
                    F2F_Levelup()
                end
            elseif facetoface_level == 7 then
                local distance = GetDistanceBetweenCoords(playercoords, facetoface_marker_coords[1].coords.x, facetoface_marker_coords[1].coords.y, facetoface_marker_coords[1].coords.z, true)
                DrawMarker(4, facetoface_marker_coords[1].coords.x, facetoface_marker_coords[1].coords.y, facetoface_marker_coords[1].coords.z + 3.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 8.0, 8.0, 8.0, 238, 37, 37, 100, true, true, false, false, false, false, false)
                if   distance < 5.5 then
                    F2F_Levelup()
                end
            elseif facetoface_level == 8 then
                local distance = GetDistanceBetweenCoords(playercoords, facetoface_marker_coords[3].coords.x, facetoface_marker_coords[3].coords.y, facetoface_marker_coords[3].coords.z, true)
                DrawMarker(4, facetoface_marker_coords[3].coords.x, facetoface_marker_coords[3].coords.y, facetoface_marker_coords[3].coords.z + 3.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 8.0, 8.0, 8.0, 238, 37, 37, 100, true, true, false, false, false, false, false)
                if   distance < 5.5 then
                    F2F_Levelup()
                end
            elseif facetoface_level == 9 then
                local distance = GetDistanceBetweenCoords(playercoords, facetoface_marker_coords[4].coords.x, facetoface_marker_coords[4].coords.y, facetoface_marker_coords[4].coords.z, true)
                DrawMarker(4, facetoface_marker_coords[4].coords.x, facetoface_marker_coords[4].coords.y, facetoface_marker_coords[4].coords.z + 3.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 8.0, 8.0, 8.0, 238, 37, 37, 100, true, true, false, false, false, false, false)
                if   distance < 5.5 then
                    F2F_Levelup()
                end
            elseif facetoface_level == 10 then
                local distance = GetDistanceBetweenCoords(playercoords, facetoface_marker_coords[2].coords.x, facetoface_marker_coords[2].coords.y, facetoface_marker_coords[2].coords.z, true)
                DrawMarker(4, facetoface_marker_coords[2].coords.x, facetoface_marker_coords[2].coords.y, facetoface_marker_coords[2].coords.z + 3.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 8.0, 8.0, 8.0, 238, 37, 37, 100, true, true, false, false, false, false, false)
                if   distance < 5.5 then
                    F2F_Levelup()
                end
            elseif facetoface_level == 11 then
                local distance = GetDistanceBetweenCoords(playercoords, facetoface_marker_coords[1].coords.x, facetoface_marker_coords[1].coords.y, facetoface_marker_coords[1].coords.z, true)
                DrawMarker(4, facetoface_marker_coords[1].coords.x, facetoface_marker_coords[1].coords.y, facetoface_marker_coords[1].coords.z + 3.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 8.0, 8.0, 8.0, 238, 37, 37, 100, true, true, false, false, false, false, false)
                if   distance < 5.5 then
                    F2F_Levelup()
                end
            elseif facetoface_level == 12 then
                local distance = GetDistanceBetweenCoords(playercoords, facetoface_marker_coords[3].coords.x, facetoface_marker_coords[3].coords.y, facetoface_marker_coords[3].coords.z, true)
                DrawMarker(4, facetoface_marker_coords[3].coords.x, facetoface_marker_coords[3].coords.y, facetoface_marker_coords[3].coords.z + 3.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 8.0, 8.0, 8.0, 238, 37, 37, 100, true, true, false, false, false, false, false)
                if distance < 5.5 then
                    TriggerServerEvent('ta-base:facetoface:server:finish', GetPlayerServerId(PlayerId()))
                end
            end
        end
        Citizen.Wait(wait)
    end
end)

function F2F_Levelup()
    if facetoface_level == 0 then
        facetoface_level = 1
        RemoveBlip(facetoface_blip)
        facetoface_blip = F2F_MainBlip(facetoface_marker_coords[4].coords.x, facetoface_marker_coords[4].coords.y, facetoface_marker_coords[4].coords.z, "Point")
        TriggerEvent('ta-base:facetoface:spawncar')
        TriggerEvent('ta-base:facetoface:updateBoard', facetoface_level)
    elseif facetoface_level == 1 then
        facetoface_level = 2
        RemoveBlip(facetoface_blip)
        facetoface_blip = F2F_MainBlip(facetoface_marker_coords[3].coords.x, facetoface_marker_coords[3].coords.y, facetoface_marker_coords[3].coords.z, "Point")
        TriggerEvent('ta-base:facetoface:spawncar')
    elseif facetoface_level == 2 then
        facetoface_level = 3
        RemoveBlip(facetoface_blip)
        facetoface_blip = F2F_MainBlip(facetoface_marker_coords[1].coords.x, facetoface_marker_coords[1].coords.y, facetoface_marker_coords[1].coords.z, "Point")
        TriggerEvent('ta-base:facetoface:spawncar')
    elseif facetoface_level == 3 then
        facetoface_level = 4
        RemoveBlip(facetoface_blip)
        facetoface_blip = F2F_MainBlip(facetoface_marker_coords[3].coords.x, facetoface_marker_coords[3].coords.y, facetoface_marker_coords[3].coords.z, "Point")
        TriggerEvent('ta-base:facetoface:spawncar')
    elseif facetoface_level == 4 then
        facetoface_level = 5
        RemoveBlip(facetoface_blip)
        facetoface_blip = F2F_MainBlip(facetoface_marker_coords[2].coords.x, facetoface_marker_coords[2].coords.y, facetoface_marker_coords[2].coords.z, "Point")
        TriggerEvent('ta-base:facetoface:spawncar')
    elseif facetoface_level == 5 then
        facetoface_level = 6
        RemoveBlip(facetoface_blip)
        facetoface_blip = F2F_MainBlip(facetoface_marker_coords[4].coords.x, facetoface_marker_coords[4].coords.y, facetoface_marker_coords[4].coords.z, "Point")
        TriggerEvent('ta-base:facetoface:spawncar')
    elseif facetoface_level == 6 then
        facetoface_level = 7
        RemoveBlip(facetoface_blip)
        facetoface_blip = F2F_MainBlip(facetoface_marker_coords[1].coords.x, facetoface_marker_coords[1].coords.y, facetoface_marker_coords[1].coords.z, "Point")
        TriggerEvent('ta-base:facetoface:spawncar')
    elseif facetoface_level == 7 then
        facetoface_level = 8
        RemoveBlip(facetoface_blip)
        facetoface_blip = F2F_MainBlip(facetoface_marker_coords[3].coords.x, facetoface_marker_coords[3].coords.y, facetoface_marker_coords[3].coords.z, "Point")
        TriggerEvent('ta-base:facetoface:spawncar')
    elseif facetoface_level == 8 then
        facetoface_level = 9
        RemoveBlip(facetoface_blip)
        facetoface_blip = F2F_MainBlip(facetoface_marker_coords[4].coords.x, facetoface_marker_coords[4].coords.y, facetoface_marker_coords[4].coords.z, "Point")
        TriggerEvent('ta-base:facetoface:spawncar')
    elseif facetoface_level == 9 then
        facetoface_level = 10
        RemoveBlip(facetoface_blip)
        facetoface_blip = F2F_MainBlip(facetoface_marker_coords[2].coords.x, facetoface_marker_coords[2].coords.y, facetoface_marker_coords[2].coords.z, "Point")
        TriggerEvent('ta-base:facetoface:spawncar')
    elseif facetoface_level == 10 then
        facetoface_level = 11
        RemoveBlip(facetoface_blip)
        facetoface_blip = F2F_MainBlip(facetoface_marker_coords[1].coords.x, facetoface_marker_coords[1].coords.y, facetoface_marker_coords[1].coords.z, "Point")
        TriggerEvent('ta-base:facetoface:spawncar')
    elseif facetoface_level == 11 then
        facetoface_level = 12
        RemoveBlip(facetoface_blip)
        facetoface_blip = F2F_MainBlip(facetoface_marker_coords[3].coords.x, facetoface_marker_coords[3].coords.y, facetoface_marker_coords[3].coords.z, "Point")
        TriggerEvent('ta-base:facetoface:spawncar')
    end
    TriggerServerEvent("ta-base:server:updateScore", facetoface_level)
    f2f_pasifmod = true
    Wait(1500)
    f2f_pasifmod = false
    f2f_pasifmod_kapa = true
end

Citizen.CreateThread(function()
	while true do 
		local wait = 1000
        if advanced_parkour then
            wait = 1
            local kordinat = GetEntityCoords(PlayerPedId())
            if IsControlPressed(0, 311) then
                if not f2f_yokoldi then
                    f2f_yokoldi = true
                    f2f_pasifmod = true
                    DoScreenFadeOut(500) Wait(1000)
                    DeleteVehicle(GetVehiclePedIsUsing(PlayerPedId()))
                    while not IsScreenFadedOut() do Citizen.Wait(100) end
                    Wait(200) DoScreenFadeIn(500)
                    TriggerEvent('ta-base:facetoface:spawn')
                    Wait(3000)
                    f2f_pasifmod = false
                    f2f_yokoldi = false
                    f2f_pasifmod_kapa = true
                end
            end
            if not f2f_yokoldi then
                if kordinat.z < 1400.0 then
                    f2f_yokoldi = true
                    DoScreenFadeOut(500) Wait(1000)
                    f2f_pasifmod = true
                    DeleteVehicle(GetVehiclePedIsUsing(PlayerPedId()))
                    while not IsScreenFadedOut() do Citizen.Wait(100) end
                    Wait(200) DoScreenFadeIn(500)
                    TriggerEvent('ta-base:facetoface:spawn')
                    Wait(3000)
                    f2f_pasifmod = false
                    f2f_yokoldi = false
                    f2f_pasifmod_kapa = true
                end
            end
        end
        Wait(wait)
    end
end)

Citizen.CreateThread(function()
	while true do 
		local wait = 1000
        if advanced_parkour then
            wait = 1
            DisableControlAction(0, 75, true) DisablePlayerFiring(PlayerPedId()) SetEntityInvincible(PlayerPedId(), true) SetPlayerInvincible(PlayerPedId(), true)
            if f2f_pasifmod then
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
                if f2f_pasifmod_kapa then
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
                    f2f_pasifmod_kapa = false
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


RegisterNetEvent('ta-base:facetoface:client:finish')
AddEventHandler('ta-base:facetoface:client:finish', function(winner)
	if advanced_parkour then
        DeleteVehicle(GetVehiclePedIsUsing(PlayerPedId()))
        RemoveBlip(facetoface_blip)
        advanced_parkour = false
        facetoface_level = 0
        f2f_yokoldi = false
        f2f_pasifmod = false
        f2f_pasifmod_kapa = false
		DoScreenFadeOut(300) Wait(400)
        while not IsScreenFadedOut() do Citizen.Wait(100) end
		-----------------------------------------
        TriggerEvent("ta-crosshairs:showCrosshair", false)
        TriggerServerEvent("ta-base:server:gamemodeLeft")
        TriggerEvent('ta-basics:general-hud', "hide")
		DisplayRadar(false)
		-----------------------------------------
		FreezeEntityPosition(PlayerPedId(), false)	
        SetEntityCoords(PlayerPedId(), 72.4780, -1970.4, 20.7928, false, false, false, false)
        FreezeEntityPosition(PlayerPedId(), true) 
        f2f_cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1) SetCamActive(f2f_cam, true) RenderScriptCams(true, false, 1, true, true) SetCamCoord(f2f_cam,104.070, -1955.9, 21.3)
        PointCamAtCoord(f2f_cam, 104.070, -1955.9, 21.3, 177.38) SetCamFov(f2f_cam, 17.0) SetCamRot(f2f_cam, 0.0, 0.0, 164.0, true) Wait(100)
		-----------------------------------------
		local messageText = '~h~'..winner..'~h~'
		RemoveAllPedWeapons(PlayerPedId(), false)
		local scaleform = Scaleform.NewAsync('MIDSIZED_MESSAGE')
		scaleform:call('SHOW_COND_SHARD_MESSAGE', 'KAZANAN', messageText, 1)
		Wait(1000) DoScreenFadeIn(500)
		scaleform:renderFullscreenTimed(6000)
		Wait(1500)
		DoScreenFadeOut(500) Wait(1300)
		while not IsScreenFadedOut() do Citizen.Wait(100) end
		Wait(100)
		RenderScriptCams(false, false, 0, true, false)
		DestroyCam(f2f_cam, false)
		f2f_cam = nil
		Wait(100)
        TriggerEvent('ta-base:client:joingame')
		Wait(1300) DoScreenFadeIn(500)
	end
end)

RegisterNetEvent('ta-base:facetoface:client:finish-winner')
AddEventHandler('ta-base:facetoface:client:finish-winner', function()
    DeleteVehicle(GetVehiclePedIsUsing(PlayerPedId()))
	DoScreenFadeOut(300) Wait(600)
	while not IsScreenFadedOut() do Citizen.Wait(100) end
    SetEntityHeading(PlayerPedId(), 354.98)
    SetEntityCoords(PlayerPedId(), 103.667, -1959.2, 19.8095, false, false, false, false)
	FreezeEntityPosition(PlayerPedId(), true) 
	TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_PARTYING", 0, true)
	Wait(1000) DoScreenFadeIn(500)
end)
