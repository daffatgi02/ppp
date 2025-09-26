ESX = nil
main = false
ilkgiris = false
inFF = false
wasFocused = false
aimlab = false
clothing_menu_aga = false
matchmaking = false
matchmaking_otoban = false

local cam

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(10)
	end
	while ESX.GetPlayerData().name == nil do
		Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

CreateThread(function()
    while true do
        local wait = 2000
        if main then
            wait = 0
            local ped = PlayerPedId()
            local pedHead = GetPedBoneCoords(ped, 0x62AC)
            local pedShoulderL = GetPedBoneCoords(ped, 0x58B7)
            local pedShoulderR = GetPedBoneCoords(ped, 0xBB0)
            local onScreen1, headX, headY = GetScreenCoordFromWorldCoord(table.unpack(pedHead))
            local onScreen2, shoulderLX, shoulderLY = GetScreenCoordFromWorldCoord(table.unpack(pedShoulderL))
            local onScreen3, shoulderRX, shoulderRY = GetScreenCoordFromWorldCoord(table.unpack(pedShoulderR))
    
            SendNUIMessage({
                action = "setNuiCoords",
                headX = headX,
                headY = headY,
                shoulderLX = shoulderLX,
                shoulderLY = shoulderLY,
                shoulderRX = shoulderRX,
                shoulderRY = shoulderRY,
            })
        end
        Wait(wait)
    end
end)

RegisterNetEvent('ta-base:client:joingame')
AddEventHandler('ta-base:client:joingame', function()
    main = true
    TriggerServerEvent('ta-base:server:openCharacter')
end)

RegisterNetEvent('ta-base:privatelobby')
AddEventHandler('ta-base:privatelobby', function(map, silahtipbaba, damageType, lobiadi)
    ------------------
    main = false
    DoScreenFadeOut(200) Wait(400)
    -- Trigger Side --
    TriggerEvent("ta-hud:main-hud", true)
    TriggerEvent('ta-pause:pass', "enable")
    TriggerEvent("ta-crosshairs:showCrosshair", crossHair)
    ------------------
    DisplayRadar(true)
    SendNUIMessage({action = "close"})
    SetNuiFocus(false, false) RenderScriptCams(false, false, 0, true, false) DestroyCam(cam, false) cam = nil
    ClearPedTasks(PlayerPedId()) ClearPedSecondaryTask(PlayerPedId()) ClearPedTasksImmediately(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
    NetworkSetInSpectatorMode(0, PlayerPedId())
    SetEntityVisible(PlayerPedId(), true, 0)
    SetLocalPlayerAsGhost(false)
    ------------------
    main_pasifmod = true
    TriggerServerEvent('ta-base:server:clear-inv')
    TriggerEvent('ta-inv:client:inv_default', "join")
    if damageType == "Default Damages" then
        priv_lobby_default_damage = true
    elseif damageType == "Custom Damages" then
        priv_lobby_custom_damage = true
    end
    if silahtipbaba == "Only Pistol" then
        priv_lobby_pistol = true
    elseif silahtipbaba == "Only SMG" then
        priv_lobby_smg = true
    elseif silahtipbaba == "Only Rifle" then
        priv_lobby_rifle = true
    elseif silahtipbaba == "Freeroam (Yalnızca custom damaged)" then
        priv_lobby_freeroam = true
        priv_lobby_custom_damage = true
        FF_CreateBlip()
        Priv_Lobby_RandomSpawn(true, lobiadi)
    end
    if map == "Madde X" then
        priv_lobby_maddex = true
        CreateBlip("priv_lobby_madde_x")
        Priv_Lobby_RandomSpawn(true, lobiadi)
    elseif map == "Green Taco" then
        priv_lobby_taco = true
        CreateBlip("default_damaged_only_pistol")
        Priv_Lobby_RandomSpawn(true, lobiadi)
    elseif map == "Police Department" then
        priv_lobby_lspd = true
        CreateBlip("custom_damaged_only_smg")
        Priv_Lobby_RandomSpawn(true, lobiadi)
    elseif map == "Kelly Park" then
        priv_lobby_kelly = true
        CreateBlip("custom_damaged_only_pistol")
        Priv_Lobby_RandomSpawn(true, lobiadi)
    elseif map == "Jilet Fadıl House" then
        priv_lobby_fadil = true
        CreateBlip("custom_damaged_only_pistol_2")
        Priv_Lobby_RandomSpawn(true, lobiadi)
    end
    priv_lobbys = true
end)

RegisterNetEvent('ta-base:client:updatePlayers', function(gamemode, players)
    SendNUIMessage({
        action = "refreshPlayers",
        gamemode = gamemode,
        players = players
    })
end)

RegisterNetEvent('ta-base:client:firstJoin', function(gamemodes)
    SendNUIMessage({
        action = "firstJoin",
        gamemodes = gamemodes,
    })
end)

RegisterNetEvent('ta-base:client:main-menu', function(data, main_background)
    main = true

    TriggerEvent('ta-pause:pass', "mainmenuclose")
    SendNUIMessage({type = "gungame-board-close"})
    if isDead then respawnbabusrespawn() end
    if advanced_gungame_2 then TriggerEvent('ta-base:driveby:delcar') end
    if advanced_sumo then TriggerEvent('ta-base:sumo:deletecar') end
    if aimlab then TriggerEvent('ta-aimlab:aimlab-leave') end
    if advanced_parkour then TriggerServerEvent("ta-base:server:leftfacetoface") end
    if farm_and_fight then 
        TriggerEvent('ta-inv:client:free-lobby-car-delete:death') 
        TriggerEvent("ta-squad:client:free-lobby", "deactive")
        TriggerEvent('ta-inv:client:inv_default', "left")
    end
    if advanced_gungame then
        SendNUIMessage({
            type = "gungame-board-close"
        })
        TriggerServerEvent('ta-base:gamemodes:server:gungame:leave')
    end
    if matchmaking then
        if matchmaking_otoban then
            matchmaking_otoban = false
        end
        TriggerServerEvent("ta-matchmaking:leaveMatch")
        TriggerEvent('ta-death:client:matchmaking', "left")
        while not IsScreenFadedOut() do Citizen.Wait(100) end
        Wait(200) DoScreenFadeIn(400)
    end
    if not farm_and_fight then
        TriggerEvent('ta-inv:client:inv_default', "left")
        TriggerEvent("ta-privlobby:disturbGame")
        TriggerEvent('ta-pause:pass', "disable")
    end

    SendNUIMessage({action = "babalartikladifalse"})

    if ilkgiris then
        TriggerServerEvent("ta-base:server:gamemodeLeft")
    else
        TriggerEvent('ta-inv:client:kapaaaaa')
        TriggerServerEvent('ta-base:server:UpdatePlayerCounts')
        TriggerServerEvent('ta-base:server:clear-inv')
        ilkgiris = true
    end

    ------------------

    ESX.TriggerServerCallback("ta-base:getPlayerData", function(cb) SendNUIMessage({action = "setUiData", player = cb}) end)
    resetScripts()
    refreshMods()

    ------------------

    if main_background == 0 then
        SetEntityCoords(PlayerPedId(), 73.9920, -1724.7, 47.8401, false, false, false, false) SetEntityHeading(PlayerPedId(), 193.63)
        cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1) SetCamActive(cam, true) RenderScriptCams(true, false, 1, true, true) SetCamCoord(cam,75.2306, -1728.2, 49.3952)
        PointCamAtCoord(cam, 75.2306, -1728.2, 49.3952, 177.38) SetCamFov(cam, 18.0) SetCamRot(cam, 0.0, 0.0, 12.5, true) Wait(10)
    end

    ------------------

    FreezeEntityPosition(PlayerPedId(), true) 
    DisplayRadar(false)
    DeleteAllBlips()
    NetworkSetInSpectatorMode(0, PlayerPedId())
    SetEntityAlpha(PlayerPedId(), 255, false)
    SetEntityHealth(PlayerPedId(), 200)
    SetPedArmour(PlayerPedId(), 0)
	SetEntityVisible(PlayerPedId(), true, 0) SetLocalPlayerAsGhost(false)
    SetEntityInvincible(PlayerPedId(), false) SetPlayerInvincible(PlayerId(), false)
    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_AA_SMOKE", 0, true)
    SetPedMoveRateOverride(PlayerPedId(),1.0)

    ------------------

    SetNuiFocus(true, true)
    for k, v in pairs(data) do playerAvatar = v.avatar playerName = v.name playerId = v.playerid end
    local ped = PlayerPedId()
    local pedHead = GetPedBoneCoords(ped, 0x62AC)
    local pedShoulderL = GetPedBoneCoords(ped, 0x58B7)
    local pedShoulderR = GetPedBoneCoords(ped, 0xBB0)
    local onScreen1, headX, headY = GetScreenCoordFromWorldCoord(table.unpack(pedHead))
    local onScreen2, shoulderLX, shoulderLY = GetScreenCoordFromWorldCoord(table.unpack(pedShoulderL))
    local onScreen3, shoulderRX, shoulderRY = GetScreenCoordFromWorldCoord(table.unpack(pedShoulderR))
    SendNUIMessage({action = "setNuiCoords", headX = headX, headY = headY, shoulderLX = shoulderLX, shoulderLY = shoulderLY, shoulderRX = shoulderRX, shoulderRY = shoulderRY})
    SendNUIMessage({action = "update", playerAvatar = playerAvatar, playerId = playerId, playerName = playerName})
    SendNUIMessage({action = "enable" })
end)

RegisterCommand("menufix", function() 
    if main then
        DoScreenFadeOut(200) Wait(400)
        SendNUIMessage({action = "close"})
        SetNuiFocus(false, false) RenderScriptCams(false, false, 0, true, false) DestroyCam(cam, false) cam = nil
        ClearPedTasks(PlayerPedId()) ClearPedSecondaryTask(PlayerPedId()) ClearPedTasksImmediately(PlayerPedId())
        FreezeEntityPosition(PlayerPedId(), false)
        NetworkSetInSpectatorMode(0, PlayerPedId())
        SetEntityVisible(PlayerPedId(), true, 0)
        SetLocalPlayerAsGhost(false)
        Wait(1000)
        TriggerServerEvent('ta-base:server:openCharacter')
        Wait(500)
        while not IsScreenFadedOut() do Citizen.Wait(100) end
        Wait(200) DoScreenFadeIn(300)
    end
end)

RegisterCommand("acaga", function() 
    main = true
    TriggerServerEvent('ta-base:server:openCharacter')
end)

RegisterNetEvent('ta-base:client:close-main-menu')
AddEventHandler('ta-base:client:close-main-menu', function(gamemode)
    ------------------
    main = false
    DoScreenFadeOut(200) Wait(400)
    -- Trigger Side --
    TriggerEvent("ta-hud:main-hud", true)
    TriggerEvent('ta-pause:pass', "enable")
    TriggerEvent("ta-crosshairs:showCrosshair", crossHair)
    ------------------
    DisplayRadar(true)
    SendNUIMessage({action = "close"})
    SetNuiFocus(false, false) RenderScriptCams(false, false, 0, true, false) DestroyCam(cam, false) cam = nil
    ClearPedTasks(PlayerPedId()) ClearPedSecondaryTask(PlayerPedId()) ClearPedTasksImmediately(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
    NetworkSetInSpectatorMode(0, PlayerPedId())
    SetEntityVisible(PlayerPedId(), true, 0)
    SetLocalPlayerAsGhost(false)
    ------------------
    if gamemode == "farm_and_fight" then
        TriggerEvent('ta-inv:client:inv_default', "join")
        JoinGameMode(gamemode)
        FF_CreateBlip()
        FF_Spawn(true)
        inFF = true
        -- Trigger leaderboard after everything is set up
        TriggerEvent('ta-leaderboard:gamemode-changed', "farm_and_fight", true)
    elseif gamemode == "custom_damaged_only_deluxo" then
        TriggerServerEvent('ta-base:server:clear-inv')
        TriggerEvent('ta-inv:client:inv_default', "join")
        JoinGameMode(gamemode)
        Deluxo_CreateBlip()
        Deluxo_Spawn(true)
    elseif gamemode == "advanced_sumo" then
        TriggerServerEvent('ta-base:server:clear-inv')
        JoinGameMode(gamemode)
        CreateBlip(gamemode)
        RandomSpawn(gamemode, true)
    elseif gamemode == "advanced_parkour" then
        TriggerServerEvent('ta-base:server:clear-inv')
        JoinGameMode(gamemode)
        CreateBlip(gamemode)
        RandomSpawn(gamemode, true)
        TriggerEvent('ta-base:facetoface:first')
    elseif gamemode == "aimlab" then
        aimlab = true
        TriggerEvent('ta-inv:client:inv_default', "join")
        TriggerEvent('ta-basics:general-hud', "show", "AIMLAB")
        TriggerEvent('ta-aimlab:aimlab-join')
        FreezeEntityPosition(PlayerPedId(), true) 
        Wait(250)
        FreezeEntityPosition(PlayerPedId(), false)
        SetPedArmour(PlayerPedId(), 200)
        SetEntityHealth(PlayerPedId(), 200)
        while not IsScreenFadedOut() do Citizen.Wait(100) end
        Wait(200) DoScreenFadeIn(200)
    elseif gamemode == "advanced_gungame" then
        TriggerServerEvent('ta-base:server:clear-inv')
        TriggerServerEvent('ta-base:server:gungame:get-map')
        Wait(200)
        JoinGameMode(gamemode)
        CreateBlip(gamemode)
        RandomSpawn(gamemode, true)
    else
        main_pasifmod = true
        TriggerServerEvent('ta-base:server:clear-inv')
        TriggerEvent('ta-inv:client:inv_default', "join")
        JoinGameMode(gamemode)
        CreateBlip(gamemode)
        RandomSpawn(gamemode, true)
    end
    ------------------
end)

RegisterNUICallback('ta-base:join-gamemode', function(gamemode)
    if gamemode == "advanced_parkour" then
        TriggerServerEvent("ta-base:server:joinfacetoface")
    end
    TriggerEvent('ta-base:client:close-main-menu', gamemode)
end)

RegisterNUICallback('ta-base:join-aimlab', function()
    TriggerEvent('ta-base:client:close-main-menu', "aimlab")
end)

RegisterNUICallback("closeGame", function()
    TriggerServerEvent("ta-base:dropPlayer")
end)

RegisterNetEvent("ta-lobbys:joined", function(gamemode, coords)
    main = false
    -- Trigger Side --
    TriggerEvent("ta-hud:main-hud", true)
    TriggerEvent('ta-pause:pass', "enable")
    ------------------
    DisplayRadar(true)
    SendNUIMessage({action = "close"})
    SetNuiFocus(false, false) RenderScriptCams(false, false, 0, true, false) DestroyCam(cam, false) cam = nil
    ClearPedTasks(PlayerPedId()) ClearPedSecondaryTask(PlayerPedId()) ClearPedTasksImmediately(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
    NetworkSetInSpectatorMode(0, PlayerPedId())
    SetEntityVisible(PlayerPedId(), true, 0)
    SetLocalPlayerAsGhost(false)
    SetEntityCoords(PlayerPedId(), table.unpack(coords))
end)

function isInFF()
    return inFF
end

exports("isInFF", isInFF)

function isInMainMenu()
    return main
end

exports("isInMainMenu", isInMainMenu)


-- Settings

RegisterNUICallback("loadSettings", function(settings)
    TriggerEvent('ta-hud:setting-status', settings)
    print('deathcam', settings.deathscreen == "on" and true or false)
    TriggerEvent('ta-death:status', settings.deathscreen == "on" and true or false)
    crossHair = settings.crosshair == "on" and true or false
end)

RegisterNetEvent("ta-base:stopEditing", function()
    SendNUIMessage({action = "stopEditing"})
end)


-- Ot Bok

RegisterNUICallback("privlobby", function()
    DoScreenFadeOut(200) Wait(400)
    PointCamAtCoord(cam, 75.2306, -1728.2, 49.3952, 177.38) SetCamFov(cam, 37.0) SetCamRot(cam, 0.0, 0.0, 19.5, true) Wait(100)
    TriggerEvent('ta-lobbys:openMainLobby')
    while not IsScreenFadedOut() do Citizen.Wait(100) end
    Wait(200) DoScreenFadeIn(300)
end)

RegisterNUICallback("crewMenu", function()
    TriggerEvent('ta-crew:openUI')
end)

RegisterNUICallback("openMarket", function()
    TriggerEvent("ta-vip:openUi")
end)

RegisterNUICallback("ta-crew:menu-back", function()
    TriggerEvent('ta-base:client:joingame')
    SetNuiFocus(0, 0)
end)

RegisterNUICallback("crew", function()
    TriggerEvent('ta-crew:openMenu')
end)

RegisterNUICallback("getLeaderboardData", function(_, cbb)
    ESX.TriggerServerCallback("ta-base:getPlayers", function(cb)
        cbb(cb)
    end)
end)

RegisterNUICallback("getMatchmakingData", function(_, cbb)
    ESX.TriggerServerCallback("ta-base:getMatchmakingData", function(cb)
        cbb(cb)
    end)
end)

RegisterNUICallback("resetSettings", function()
    TriggerEvent("ta-hud:reset")
end)

RegisterNUICallback("showRekoPage", function()
    DoScreenFadeOut(200) Wait(400)
    SetNuiFocus(0,0)
    TriggerEvent("ta-matchmaking:show")
    while not IsScreenFadedOut() do Citizen.Wait(100) end
    Wait(200) DoScreenFadeIn(300)
end)

RegisterNUICallback("isFocused", function()
    if IsNuiFocused() then
        wasFocused = true
        SetNuiFocus(0, 0)
    end
end)

RegisterNetEvent("ta-base:revokeFocus", function()
    if wasFocused then
        wasFocused = false
        SetNuiFocus(1, 1)
    end
end)

RegisterNetEvent("ta-base:rekoAccept", function()
    SetNuiFocus(0, 0)
    SendNUIMessage({
        action = 'rekoAccept'
    })
end)

RegisterNUICallback("kiyafetallahsehit", function()
    ------------------
    main = false
    DoScreenFadeOut(200) Wait(400)
    clothing_menu_aga = true
    ------------------
    DisplayRadar(true)
    SendNUIMessage({action = "close"})
    SetNuiFocus(false, false) RenderScriptCams(false, false, 0, true, false) DestroyCam(cam, false) cam = nil
    ClearPedTasks(PlayerPedId()) ClearPedSecondaryTask(PlayerPedId()) ClearPedTasksImmediately(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
    NetworkSetInSpectatorMode(0, PlayerPedId())
    SetEntityVisible(PlayerPedId(), true, 0)
    SetLocalPlayerAsGhost(false)
    -- Trigger Side --
    TriggerEvent("esx_skin:ustaananisikm", function()
        -- Submit callback - appearance saved successfully
    end, function()
        -- Cancel callback - appearance customization cancelled
    end)
    while not IsScreenFadedOut() do Citizen.Wait(100) end
    Wait(200) DoScreenFadeIn(300)
    ------------------
end)

RegisterNetEvent('ta-base:client:close-main-menu:matchmaking')
AddEventHandler('ta-base:client:close-main-menu:matchmaking', function()
    ------------------
    main = false
    matchmaking = true
    -- Trigger Side --
    TriggerEvent("ta-hud:main-hud", true)
    TriggerEvent('ta-pause:pass', "enable")
    TriggerEvent("ta-crosshairs:showCrosshair", crossHair)
    ------------------
    DisplayRadar(true)
    SendNUIMessage({action = "close"})
    SetNuiFocus(false, false) RenderScriptCams(false, false, 0, true, false) DestroyCam(cam, false) cam = nil
    ClearPedTasks(PlayerPedId()) ClearPedSecondaryTask(PlayerPedId()) ClearPedTasksImmediately(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
    NetworkSetInSpectatorMode(0, PlayerPedId())
    SetEntityVisible(PlayerPedId(), true, 0)
    SetLocalPlayerAsGhost(false)
    SetPedArmour(PlayerPedId(), 200)
    SetEntityHealth(PlayerPedId(), 200)
    SetLocalPlayerAsGhost(false)
    SetEntityInvincible(PlayerPedId(), false)
    SetPlayerInvincible(PlayerPedId(), false)
end)

RegisterNetEvent("ta-base:client:matchmaking-otoban", function(action)
    if action == "join" then
        matchmaking_otoban = true
    elseif action == "left" then
        matchmaking_otoban = false
    end
end)

-- RegisterNetEvent("ta-base:showUi", function(show) 
--     if show then
--         SendNUIMessage({
--             action = "show"
--         })
--         SetNuiFocus(1,1)
--     else
--         SendNUIMessage({
--             action = "hide"
--         })
--         SetNuiFocus(0,0)
--     end
-- end)

function resetScripts()
    TriggerEvent('ta-pause:pass', "mainmenuclose")
    TriggerEvent("ta-crosshairs:showCrosshair", false)
    TriggerEvent('ta-basics:general-hud', "hide")
    TriggerEvent("ta-hud:streak:resetStreak")
    TriggerEvent("ta-base:squad:leave")
    TriggerServerEvent("ta-lobbys:playerLeft")
    TriggerServerEvent("ta-inv:Load")
    TriggerEvent("ta-hud:main-hud", false)
    TriggerEvent("ta-base:farm_fight:npc", "delete")
end

function refreshMods()
    inFF = false
    driveby_car = nil
    farm_and_fight = false
    TriggerEvent('ta-leaderboard:gamemode-changed', "farm_and_fight", false)
    default_damaged_only_pistol = false
    default_damaged_only_pistol_2 = false
    default_damaged_only_ap_pistol = false
    default_damaged_only_ap_pistol_2 = false
    default_damaged_only_smg = false
    default_damaged_only_smg_2 = false
    default_damaged_only_rifle = false
    default_damaged_only_rifle_2 = false
    custom_damaged_only_pistol = false
    custom_damaged_only_pistol_2 = false
    custom_damaged_only_smg = false
    custom_damaged_only_rifle = false
    custom_damaged_only_shotgun = false
    custom_damaged_only_revolver = false
    custom_damaged_only_m60 = false
    custom_damaged_only_m60_2 = false
    custom_damaged_only_deluxo = false
    custom_damaged_only_labirent = false
    advanced_gungame = false
    advanced_gungame_2 = false
    advanced_gungame_3 = false
    matchmakingolusu = false
    matchmaking = false
    advanced_gangwar = false
    advanced_farm_fight = false
    advanced_zombie = false
    advanced_sumo = false
    sumo_yokoldi = false
    sumo_pasifmod = false
    sumo_pasifmod_kapa = false
    advanced_parkour = false
    advanced_snowball = false
    advanced_knife = false
    priv_lobbys = false
    priv_lobby_lspd = false
    priv_lobby_taco = false
    priv_lobby_fadil = false
    clothing_menu_aga = false
    priv_lobby_maddex = false
    priv_lobby_kelly = false
    priv_lobby_pistol = false
    priv_lobby_smg = false
    priv_lobby_rifle = false
    priv_lobby_default_damage = false
    priv_lobby_custom_damage = false
    cl_gungame_map_1 = false
    cl_gungame_map_2 = false
    cl_gungame_map_3 = false
    cl_gungame_map_4 = false
    cl_gungame_map_5 = false
    cl_gungame_map_6 = false
    gungameboard = false
    aimlab = false
    gungame_currentLevel = 1
    gungame_currentKill = 0
    gungame_level = 1
    gungame_finish = false
    DestroyCam(gungame_cam, false)
    gungame_cam = nil
    matchmaking_otoban = false
end
