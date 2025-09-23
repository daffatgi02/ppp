local isCameraActive = false
local cam = nil
local headingToCam = nil
local camOffset = 1.0
local customCamLocation = nil

mainmenuclose, pass, pausemenu, ayarlar, map, mapc, ayarlarc = false, false, false, false, false, 0, 0

RegisterNetEvent('ta-pause:pass')
AddEventHandler('ta-pause:pass', function(action)
    if action == "enable" then
        pass = true
    elseif action == "disable" then
        pass = false
    elseif action == "mainmenuclose" then
        mainmenuclose = true
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        SetPauseMenuActive(false)
        if not isCameraActive and IsControlJustPressed(0, Config.Key) then
            if not pausemenu and ayarlar == false and pass == true and map == false then
                if GetPauseMenuState() ~= 15 and not IsPedFalling(PlayerPedId()) then
                isCameraActive = true
                pausemenu = true
                TriggerEvent('camera')
                SetNuiFocus(true, true)
                SendNUIMessage({open = true})
                end
            end
        elseif ayarlar == true then
            ayarlar = false
        elseif map == true then
            map = false
        end
        if mainmenuclose then
            mainmenuclose = false
            isCameraActive = false
            pausemenu = false
            SendNUIMessage({open = false})
            SetNuiFocus(false, false)
            DestroyCam(cam, false)
            cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', false)
            SetCamActive(cam, false)
            ClearPedTasks(playerPed)
            RenderScriptCams(false, false, 0, false, false)
        end
    end
end)

RegisterNetEvent('camera', function()
        local playerPed = PlayerPedId()
        local coords = GetOffsetFromEntityInWorldCoords(playerPed, 0, camOffset, 0)
        if not IsPedInAnyVehicle(playerPed, false) then 
            FreezeEntityPosition(playerPed, true)
            RenderScriptCams(false, false, 0, 1, 0)
            DestroyCam(cam, false)
            FreezePedCameraRotation(playerPed)

            if not DoesCamExist(cam) then
                DisplayRadar(false)
                TriggerEvent("ta-hud:main-hud", false)
                TriggerEvent('ta-basics:general-hud', "fake-hide")
                TriggerEvent('ta-crosshairs:action', "fake-hide")
                TriggerEvent('ta-base:gungame-hud', "hide")
                cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
                SetCamActive(cam, true)
                RenderScriptCams(true, false, 0, true, true)
                SetCamUseShallowDofMode(cam, true)
                SetCamNearDof(cam, 0.4)
                SetCamFarDof(cam, 1.3)
                SetCamDofStrength(cam, 0.95)
                SetPedCanPlayAmbientAnims(playerPed, true)
                TaskStartScenarioInPlace(playerPed, PlayAnimin, 0, true)
            end
        
            SetCamCoord(cam, coords.x, coords.y, coords.z + 0.6)
            SetCamRot(cam, 0.0, 0.0, GetEntityHeading(playerPed) + 180)
            
            if customCamLocation then
                SetCamCoord(cam, customCamLocation.x, customCamLocation.y, customCamLocation.z)
                SetCamRot(cam, 0.0, 0.0, customCamLocation.w)
            end

            while DoesCamExist(cam) do
                SetUseHiDof()
                Citizen.Wait(0)
            end
        end
end)

RegisterNetEvent('cameraquit', function()
    pausemenu = false
    local playerPed = PlayerPedId()
    SetNuiFocus(false, false)
    isCameraActive = false
    FreezeEntityPosition(playerPed, false)
    DestroyCam(cam, false)
    cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', false)
    SetCamActive(cam, false)
    ClearPedTasks(playerPed)
    DisplayRadar(true)
    TriggerEvent("ta-hud:main-hud", true)
    TriggerEvent('ta-basics:general-hud', "fake-show")
    TriggerEvent('ta-crosshairs:action', "fake-show")
    TriggerEvent('ta-base:gungame-hud', "show")
    RenderScriptCams(false, false, 0, false, false)
    if not IsPedInAnyVehicle(playerPed, false) then 
        ClearPedTasks(playerPed)
    end
    DestroyCam(cam, false)
end)

RegisterNUICallback('Close', function(data)
    TriggerEvent('cameraquit')
end)

RegisterNUICallback('settings', function(data)
    if pausemenu then
        ayarlar = true
        TriggerEvent('cameraquit')
        ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_LANDING_MENU'),0,-1) 
    end
end)

RegisterNUICallback('map', function(data)
    if pausemenu then
        map = true
        TriggerEvent('cameraquit')
        ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_MP_PAUSE'),0,-1) 
    end
end)

RegisterNUICallback('mainmenu', function(data)
    if pausemenu then
        local playerPed = PlayerPedId()
        pausemenu = false
        SendNUIMessage({open = false})
        SetNuiFocus(false, false)
        isCameraActive = false
        FreezeEntityPosition(playerPed, false)
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', false)
        SetCamActive(cam, false)
        ClearPedTasks(playerPed)
        DisplayRadar(true)
        RenderScriptCams(false, false, 0, false, false)
        DoScreenFadeOut(500) Wait(600)
        DeleteVehicle(GetVehiclePedIsUsing(PlayerPedId()))
        TriggerEvent('ta-base:client:joingame')
        DestroyCam(cam, false)
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', false)
        SetCamActive(cam, false)
        RenderScriptCams(false, false, 0, false, false)
        while not IsScreenFadedOut() do Citizen.Wait(100) end
        Wait(800) DoScreenFadeIn(1500)
        DestroyCam(cam, false)
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', false)
        SetCamActive(cam, false)
        RenderScriptCams(false, false, 0, false, false)
    end
end)
