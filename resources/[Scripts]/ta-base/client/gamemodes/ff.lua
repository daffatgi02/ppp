local pasifmod = false
local cikti = false

farm_and_fight_safe_1 = {x = 913.0875, y = -294.071, z = 65.861}
farm_and_fight_safe_2 = {x = 106.7020, y = -1941.88, z = 20.943}
farm_and_fight_safe_3 = {x = -824.608, y = -926.436, z = 16.779}
farm_and_fight_safe_4 = {x = 1257.064, y = 1827.356, z = 81.935}
farm_and_fight_safe_5 = {x = 2099.277, y = 2328.874, z = 94.503}
farm_and_fight_safe_6 = {x = 1971.349, y = 3704.855, z = 32.438}
farm_and_fight_safe_7 = {x = -58.9580, y = 6280.847, z = 31.563}

farm_and_fight_safe_zone_1 = CircleZone:Create(vector3(farm_and_fight_safe_1.x, farm_and_fight_safe_1.y, farm_and_fight_safe_1.z), 8.0, {
	name="farm_and_fight_safe_zone_1",
	debugPoly=true,
})

farm_and_fight_safe_zone_2 = CircleZone:Create(vector3(farm_and_fight_safe_2.x, farm_and_fight_safe_2.y, farm_and_fight_safe_2.z), 8.0, {
	name="farm_and_fight_safe_zone_1",
	debugPoly=true,
})

farm_and_fight_safe_zone_3 = CircleZone:Create(vector3(farm_and_fight_safe_3.x, farm_and_fight_safe_3.y, farm_and_fight_safe_3.z), 8.0, {
	name="farm_and_fight_safe_zone_3",
	debugPoly=true,
})

farm_and_fight_safe_zone_4 = CircleZone:Create(vector3(farm_and_fight_safe_4.x, farm_and_fight_safe_4.y, farm_and_fight_safe_4.z), 8.0, {
	name="farm_and_fight_safe_zone_4",
	debugPoly=true,
})

farm_and_fight_safe_zone_5 = CircleZone:Create(vector3(farm_and_fight_safe_5.x, farm_and_fight_safe_5.y, farm_and_fight_safe_5.z), 8.0, {
	name="farm_and_fight_safe_zone_5",
	debugPoly=true,
})

farm_and_fight_safe_zone_6 = CircleZone:Create(vector3(farm_and_fight_safe_6.x, farm_and_fight_safe_6.y, farm_and_fight_safe_6.z), 8.0, {
	name="farm_and_fight_safe_zone_6",
	debugPoly=true,
})

farm_and_fight_safe_zone_7 = CircleZone:Create(vector3(farm_and_fight_safe_7.x, farm_and_fight_safe_7.y, farm_and_fight_safe_7.z), 8.0, {
	name="farm_and_fight_safe_zone_7",
	debugPoly=true,
})

function FF_Spawn(first)
    inFF = true
    local ped = PlayerPedId()
    local ply = PlayerId()
    --------------------------------
    SetEntityInvincible(ped, false)
	SetPlayerInvincible(ply, false)
    --------------------------------
    SetEntityCoords(ped, farm_and_fight_safe_1.x, farm_and_fight_safe_1.y, farm_and_fight_safe_1.z- 1.0)
    if first then
        SetEntityAlpha(ped, 155, false)
        TriggerServerEvent('ta-base:server:set-bucket', 2000)
        TriggerEvent("ta-base:farm_fight:npc", "spawn")
        TriggerEvent("ta-squad:client:free-lobby", "active")
        while not IsScreenFadedOut() do Citizen.Wait(100) end
        Wait(300) DoScreenFadeIn(500)
        TriggerServerEvent('ta-base:server:weapons', "farm_and_fight", "remove")
        Wait(100)
        TriggerServerEvent('ta-base:server:weapons', "farm_and_fight", "add", true)
        Wait(1000)
        SendNUIMessage({action = "babalartikladifalse"})
    else
        TriggerServerEvent('ta-base:server:weapons', "farm_and_fight", "remove")
        Wait(100)
        TriggerServerEvent('ta-base:server:weapons', "farm_and_fight", "add", true)
    end
end

function FF_CreateBlip()
    farm_and_fight_safe_1_blip = AddBlipForRadius(farm_and_fight_safe_1.x, farm_and_fight_safe_1.y, farm_and_fight_safe_1.z, 8.0)
    SetBlipHighDetail(farm_and_fight_safe_1_blip, true)
    SetBlipColour(farm_and_fight_safe_1_blip, 2)
    SetBlipAlpha(farm_and_fight_safe_1_blip, 90)
    farm_and_fight_safe_1_main_blip = MainBlip(farm_and_fight_safe_1.x, farm_and_fight_safe_1.y, farm_and_fight_safe_1.z, "Safe")
    farm_and_fight_safe_2_blip = AddBlipForRadius(farm_and_fight_safe_2.x, farm_and_fight_safe_2.y, farm_and_fight_safe_2.z, 8.0)
    SetBlipHighDetail(farm_and_fight_safe_2_blip, true)
    SetBlipColour(farm_and_fight_safe_2_blip, 2)
    SetBlipAlpha(farm_and_fight_safe_2_blip, 90)
    farm_and_fight_safe_2_main_blip = MainBlip(farm_and_fight_safe_2.x, farm_and_fight_safe_2.y, farm_and_fight_safe_2.z, "Safe 2")
    farm_and_fight_safe_3_blip = AddBlipForRadius(farm_and_fight_safe_3.x, farm_and_fight_safe_3.y, farm_and_fight_safe_3.z, 8.0)
    SetBlipHighDetail(farm_and_fight_safe_3_blip, true)
    SetBlipColour(farm_and_fight_safe_3_blip, 2)
    SetBlipAlpha(farm_and_fight_safe_3_blip, 90)
    farm_and_fight_safe_3_main_blip = MainBlip(farm_and_fight_safe_3.x, farm_and_fight_safe_3.y, farm_and_fight_safe_3.z, "Safe 3")
    farm_and_fight_safe_4_blip = AddBlipForRadius(farm_and_fight_safe_4.x, farm_and_fight_safe_4.y, farm_and_fight_safe_4.z, 8.0)
    SetBlipHighDetail(farm_and_fight_safe_4_blip, true)
    SetBlipColour(farm_and_fight_safe_4_blip, 2)
    SetBlipAlpha(farm_and_fight_safe_4_blip, 90)
    farm_and_fight_safe_4_main_blip = MainBlip(farm_and_fight_safe_4.x, farm_and_fight_safe_4.y, farm_and_fight_safe_4.z, "Safe 4")
    farm_and_fight_safe_5_blip = AddBlipForRadius(farm_and_fight_safe_5.x, farm_and_fight_safe_5.y, farm_and_fight_safe_5.z, 8.0)
    SetBlipHighDetail(farm_and_fight_safe_5_blip, true)
    SetBlipColour(farm_and_fight_safe_5_blip, 2)
    SetBlipAlpha(farm_and_fight_safe_5_blip, 90)
    farm_and_fight_safe_5_main_blip = MainBlip(farm_and_fight_safe_5.x, farm_and_fight_safe_5.y, farm_and_fight_safe_5.z, "Safe 5")
    farm_and_fight_safe_6_blip = AddBlipForRadius(farm_and_fight_safe_6.x, farm_and_fight_safe_6.y, farm_and_fight_safe_6.z, 8.0)
    SetBlipHighDetail(farm_and_fight_safe_6_blip, true)
    SetBlipColour(farm_and_fight_safe_6_blip, 2)
    SetBlipAlpha(farm_and_fight_safe_6_blip, 90)
    farm_and_fight_safe_6_main_blip = MainBlip(farm_and_fight_safe_6.x, farm_and_fight_safe_6.y, farm_and_fight_safe_6.z, "Safe 6")
    farm_and_fight_safe_7_blip = AddBlipForRadius(farm_and_fight_safe_7.x, farm_and_fight_safe_7.y, farm_and_fight_safe_7.z, 8.0)
    SetBlipHighDetail(farm_and_fight_safe_7_blip, true)
    SetBlipColour(farm_and_fight_safe_7_blip, 2)
    SetBlipAlpha(farm_and_fight_safe_7_blip, 90)
    farm_and_fight_safe_7_main_blip = MainBlip(farm_and_fight_safe_7.x, farm_and_fight_safe_7.y, farm_and_fight_safe_7.z, "Safe 7")
end

function MainBlip(x, y, z, text)
    local blip = AddBlipForCoord(x, y, z)
    SetBlipSprite(blip, 164)
    SetBlipDisplay(blip, 6)
    SetBlipScale(0.5, 0.5)
    SetBlipColour(blip, 2)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
    return blip
end

Citizen.CreateThread(function()
    RequestStreamedTextureDict("marker", true)
    if not HasStreamedTextureDictLoaded("marker") then
        RequestStreamedTextureDict("marker", true)
        while not HasStreamedTextureDictLoaded("marker") do
            Wait(1)
        end
    end
	while true do 
		wait = 1000
        if farm_and_fight or priv_lobby_freeroam then
            wait = 0
            local plyPed = PlayerPedId()
            local coords = GetEntityCoords(plyPed)
            SafeZoneInside_1 = farm_and_fight_safe_zone_1:isPointInside(coords)
            SafeZoneInside_2 = farm_and_fight_safe_zone_2:isPointInside(coords)
            SafeZoneInside_3 = farm_and_fight_safe_zone_3:isPointInside(coords)
            SafeZoneInside_4 = farm_and_fight_safe_zone_4:isPointInside(coords)
            SafeZoneInside_5 = farm_and_fight_safe_zone_5:isPointInside(coords)
            SafeZoneInside_6 = farm_and_fight_safe_zone_6:isPointInside(coords)
            SafeZoneInside_7 = farm_and_fight_safe_zone_7:isPointInside(coords)
            if SafeZoneInside_1 or SafeZoneInside_2 or SafeZoneInside_3 or SafeZoneInside_4 or SafeZoneInside_5 or SafeZoneInside_6 or SafeZoneInside_7 then
                if not pasifmod then
                    pasifmod = true
                    cikti = false
                end
                DrawMarker(9, 917.382, -295.97, 65.6340 + 0.8, 0.0, 0.0, 0.0, 100.0, 1.0, 0, 1.0, 1.0, 1.0, 255,255,255, 255, false, false, false, true, "marker", "trans", false) 
                DrawMarker(9, 102.713, -1938.2, 20.8037 + 0.8, 0.0, 0.0, 0.0, 100.0, 0.0, 0, 1.0, 1.0, 1.0, 255,255,255, 255, false, false, false, true, "marker", "trans", false) 
                DrawMarker(9, -828.46, -923.24, 16.5126 + 0.8, 0.0, 0.0, 0.0, 100.0, 0.0, 0, 1.0, 1.0, 1.0, 255,255,255, 255, false, false, false, true, "marker", "trans", false) 
                DrawMarker(9, 1253.65, 1831.49, 81.3045 + 0.8, 0.0, 0.0, 0.0, 100.0, 0.0, 0, 1.0, 1.0, 1.0, 255,255,255, 255, false, false, false, true, "marker", "trans", false) 
                DrawMarker(9, 2093.66, 2328.76, 94.2855 + 0.8, 0.0, 0.0, 0.0, 100.0, 0.0, 0, 1.0, 1.0, 1.0, 255,255,255, 255, false, false, false, true, "marker", "trans", false) 
                DrawMarker(9, 1968.77, 3709.76, 32.1506 + 0.8, 0.0, 0.0, 0.0, 100.0, 0.0, 0, 1.0, 1.0, 1.0, 255,255,255, 255, false, false, false, true, "marker", "trans", false) 
                DrawMarker(9, -59.082, 6286.05, 31.4434 + 0.8, 0.0, 0.0, 0.0, 100.0, 0.0, 0, 1.0, 1.0, 1.0, 255,255,255, 255, false, false, false, true, "marker", "trans", false) 
            else
                if pasifmod then
                    pasifmod = false
                    if not cikti then
                        cikti = true
                    end
                end
            end
        end
        Wait(wait)
    end
end)

Citizen.CreateThread(function()
	while true do 
		wait = 1000
        if farm_and_fight or priv_lobby_freeroam then
            wait = 1
            if pasifmod then
                local vehicles = GetGamePool("CVehicle")
                for _, vehicle in pairs(vehicles) do
                    local safe_1_dist = GetDistanceBetweenCoords(GetEntityCoords(vehicle), farm_and_fight_safe_1.x, farm_and_fight_safe_1.y, farm_and_fight_safe_1.z, false)
                    local safe_2_dist = GetDistanceBetweenCoords(GetEntityCoords(vehicle), farm_and_fight_safe_2.x, farm_and_fight_safe_2.y, farm_and_fight_safe_2.z, false)
                    local safe_3_dist = GetDistanceBetweenCoords(GetEntityCoords(vehicle), farm_and_fight_safe_3.x, farm_and_fight_safe_3.y, farm_and_fight_safe_3.z, false)
                    local safe_4_dist = GetDistanceBetweenCoords(GetEntityCoords(vehicle), farm_and_fight_safe_4.x, farm_and_fight_safe_4.y, farm_and_fight_safe_4.z, false)
                    local safe_5_dist = GetDistanceBetweenCoords(GetEntityCoords(vehicle), farm_and_fight_safe_5.x, farm_and_fight_safe_5.y, farm_and_fight_safe_5.z, false)
                    local safe_6_dist = GetDistanceBetweenCoords(GetEntityCoords(vehicle), farm_and_fight_safe_6.x, farm_and_fight_safe_6.y, farm_and_fight_safe_6.z, false)
                    local safe_7_dist = GetDistanceBetweenCoords(GetEntityCoords(vehicle), farm_and_fight_safe_7.x, farm_and_fight_safe_7.y, farm_and_fight_safe_7.z, false)

                    if (safe_1_dist <= 118 or 
                    safe_2_dist <= 118 or 
                    safe_3_dist <= 118 or 
                    safe_4_dist <= 118 or 
                    safe_5_dist <= 118 or 
                    safe_6_dist <= 118 or 
                    safe_7_dist <= 118) then
                        SetEntityAlpha(vehicle, 155, false)
                        SetEntityNoCollisionEntity(vehicle, PlayerPedId(), true)
                    else
                        SetEntityAlpha(vehicle, 255, false)
                    end
                end
                DisablePlayerFiring(PlayerPedId()) SetEntityInvincible(PlayerPedId(), true) SetPlayerInvincible(PlayerPedId(), true)
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
                if cikti then
                    SetEntityInvincible(PlayerPedId(), false) SetPlayerInvincible(PlayerPedId(), false) SetPedCanRagdoll(PlayerPedId(), true)
                    SetEntityAlpha(PlayerPedId(), 255, false) SetLocalPlayerAsGhost(false) EnableControlAction(0, 24,true)
                    EnableControlAction(0, 69,true) EnableControlAction(0, 92,true) EnableControlAction(0, 106,true)
                    EnableControlAction(0, 122,true) EnableControlAction(0, 135,true) EnableControlAction(0, 142,true)
                    EnableControlAction(0, 144,true) EnableControlAction(0, 257,true) EnableControlAction(0, 329,true)
                    EnableControlAction(0, 346,true)
                    cikti = false
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