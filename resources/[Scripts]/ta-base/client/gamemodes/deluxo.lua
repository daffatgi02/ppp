local pasifmod_deluxo_deluxo = false
local cikti_deluxo_deluxo = false
local indi = false
local bindi = true

deluxo_safe = {x = 423.378, y = -633.29, z = 28.5000}

deluxo_safe_zone = CircleZone:Create(vector3(deluxo_safe.x, deluxo_safe.y, deluxo_safe.z), 120.0, {
	name="deluxo_safe_zone",
	debugPoly=false,
})

function Deluxo_Spawn(first)
    local ped = PlayerPedId()
    local ply = PlayerId()
    --------------------------------
    SetEntityInvincible(ped, false)
	SetPlayerInvincible(ply, false)
    --------------------------------
    SetEntityCoords(ped, deluxo_safe.x, deluxo_safe.y, deluxo_safe.z- 1.0)
    FreezeEntityPosition(PlayerPedId(), true) 
    Wait(250)
    FreezeEntityPosition(PlayerPedId(), false)
    if first then
        SetEntityAlpha(ped, 155, false)
        TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_deluxo", "add", true)
        TriggerServerEvent('ta-base:server:set-bucket', 2017)
        SetEntityHealth(PlayerPedId(), 200)
        while not IsScreenFadedOut() do Citizen.Wait(100) end
        Wait(300) DoScreenFadeIn(500)
        Wait(1000)
        SendNUIMessage({action = "babalartikladifalse"})
    else
    end
end

function Deluxo_CreateBlip()
    deluxo_safe_blip = AddBlipForRadius(deluxo_safe.x, deluxo_safe.y, deluxo_safe.z, 120.0)
    SetBlipHighDetail(deluxo_safe_blip, true)
    SetBlipColour(deluxo_safe_blip, 2)
    SetBlipAlpha(deluxo_safe_blip, 90)
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
        if custom_damaged_only_deluxo then
            wait = 0
            local plyPed = PlayerPedId()
            local coords = GetEntityCoords(plyPed)
            DeluxoSafeZoneInside = deluxo_safe_zone:isPointInside(coords)
            if DeluxoSafeZoneInside then
                if not pasifmod_deluxo then
                    pasifmod_deluxo = true
                    cikti_deluxo = false
                end
                DrawMarker(9, 917.382, -295.97, 65.6340 + 0.8, 0.0, 0.0, 0.0, 100.0, 1.0, 0, 1.0, 1.0, 1.0, 255,255,255, 255, false, false, false, true, "marker", "trans", false) 
            else
                if pasifmod_deluxo then
                    pasifmod_deluxo = false
                    if not cikti_deluxo then
                        cikti_deluxo = true
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
        if custom_damaged_only_deluxo then
            wait = 1
            if pasifmod_deluxo then
                local vehicles = GetGamePool("CVehicle")
                for _, vehicle in pairs(vehicles) do
                    local deluxo_safe_dist = GetDistanceBetweenCoords(GetEntityCoords(vehicle), deluxo_safe.x, deluxo_safe.y, deluxo_safe.z, false)

                    if (deluxo_safe_dist <= 118) then
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
                if cikti_deluxo then
                    SetEntityInvincible(PlayerPedId(), false) SetPlayerInvincible(PlayerPedId(), false) SetPedCanRagdoll(PlayerPedId(), true)
                    SetEntityAlpha(PlayerPedId(), 255, false) SetLocalPlayerAsGhost(false) EnableControlAction(0, 24,true)
                    EnableControlAction(0, 69,true) EnableControlAction(0, 92,true) EnableControlAction(0, 106,true)
                    EnableControlAction(0, 122,true) EnableControlAction(0, 135,true) EnableControlAction(0, 142,true)
                    EnableControlAction(0, 144,true) EnableControlAction(0, 257,true) EnableControlAction(0, 329,true)
                    EnableControlAction(0, 346,true)
                    cikti_deluxo = false
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

RegisterCommand("-arack", function()
    if custom_damaged_only_deluxo then
        if IsPedInAnyVehicle(PlayerPedId()) then
            if GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId()))) == "DELUXO" then
                DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
            end
            if GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId()))) == "OPPRESSOR" then
                DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
            end
        end
    end
    if farm_and_fight or priv_lobby_freeroam then
        if IsPedInAnyVehicle(PlayerPedId()) then
            TriggerEvent('ta-inv:client:free-lobby-car-delete')
            DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
        end
    end
end)

RegisterCommand("-deluxoust", function()
    if custom_damaged_only_deluxo then
        if IsPedInAnyVehicle(PlayerPedId()) then
            if GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId()))) == "DELUXO" then
                if pasifmod_deluxo == false then
                    if GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId())) < 4.0 then
                        if bindi == true then
                            local kordinat = GetEntityCoords(PlayerPedId())
                            SetEntityCoords(PlayerPedId(), kordinat.x, kordinat.y, kordinat.z+0.7, false, false, false, false)
                            indi = true
                            bindi = false
                        else
                            TriggerEvent("ta-notification:show", '	fas fa-exclamation-circle text-info', "EC2222", "System", "", "You can get on top of a Deluxo in just 5 seconds!", 10000)
                        end
                    else
                        TriggerEvent("ta-notification:show", '	fas fa-exclamation-circle text-info', "EC2222", "System", "", "You can't get on top of the Deluxo when it's going this fast!", 10000)
                    end
                end
            end
        end
    end
end)

RegisterKeyMapping('-arack', 'Vehicle Delete', 'keyboard', 'K')
RegisterKeyMapping('-deluxoust', 'Deluxo Trick', 'keyboard', 'B')

function BindiCooldown()
    Wait(5000)
    bindi = true
end

Citizen.CreateThread(function()
	while true do 
		wait = 1000
        if custom_damaged_only_deluxo then
            wait = 1
            if indi then
                if IsPedInAnyVehicle(PlayerPedId()) then
                    if GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId()))) == "DELUXO" then
                        indi = false
                        BindiCooldown()
                    end
                end
            end
        end
        Wait(wait)
    end
end)