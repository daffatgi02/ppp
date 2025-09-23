local gungame_cam
gungameboard = false
gungame_currentLevel = 1
gungame_currentKill = 0
gungame_level = 1
gungame_finish = false

WeaponList = {
    {level = "WEAPON_CUSTOMADVANCEDRIFLE", value = 5, name="ADVANCED RIFLE"},
	{level = "WEAPON_CUSTOMASSAULTRIFLE", value = 7, name="ASSAULT RIFLE"},
	{level = "WEAPON_CUSTOMCOMPACTRIFLE", value = 4, name="COMPACT RIFLE"},
    {level = "WEAPON_CUSTOMCOMBATPDW", value = 5, name="COMBAT PDW"},
    {level = "WEAPON_CUSTOMSMG_MK2", value = 4, name="SMG MK II"},
    {level = "WEAPON_CUSTOMSMG", value = 4, name="SMG"},
	{level = "WEAPON_CUSTOMMICROSMG", value = 6, name="MICRO SMG"},
	{level = "WEAPON_CUSTOMMACHINEPISTOL", value = 4, name="MACHINE PISTOL"},
	{level = "WEAPON_CUSTOMCOMBATPISTOL", value = 3, name="COMBAT PISTOL"},
	{level = "WEAPON_CUSTOMPISTOL_MK2", value = 2, name="PISTOL MK II"},
    {level = "WEAPON_CUSTOMPISTOL", value = 2, name="PISTOL"},
}

cl_gungame_map_1 = true
cl_gungame_map_2 = false
cl_gungame_map_3 = false
cl_gungame_map_4 = false
cl_gungame_map_5 = false
cl_gungame_map_6 = false

advanced_gungame_coords = {x = 199.5169, y = -927.662, z = 30.691}
advanced_gungame_spawns = {
    [1] = {coords = vector3(205.5469, -1017.38, 29.306)}, 
    [2] = {coords = vector3(136.5843, -985.352, 29.292)}, 
    [3] = {coords = vector3(203.1771, -994.897, 30.091)}, 
    [4] = {coords = vector3(161.3564, -969.919, 30.091)}, 
    [5] = {coords = vector3(159.3720, -934.068, 30.061)}, 
    [6] = {coords = vector3(180.5584, -936.157, 30.091)}, 
    [7] = {coords = vector3(202.9470, -965.041, 30.091)}, 
    [8] = {coords = vector3(227.9775, -967.833, 29.318)}, 
    [9] = {coords = vector3(213.0338, -920.597, 30.688)}, 
    [10] = {coords = vector3(168.7265, -915.906, 30.690)}, 
    [11] = {coords = vector3(199.9959, -901.141, 31.149)}, 
    [12] = {coords = vector3(186.6105, -873.923, 31.497)}, 
    [13] = {coords = vector3(206.6087, -851.644, 30.570)}, 
    [14] = {coords = vector3(218.6649, -876.246, 30.492)}, 
    [15] = {coords = vector3(241.9447, -903.382, 29.141)}, 
    [16] = {coords = vector3(212.2100, -956.329, 24.339)},
}

advanced_gungame_coords_2 = {x = 1542.615, y = -2126.35, z = 81.816}
advanced_gungame_spawns_2 = {
    [1] = {coords = vector3(1562.658, -2215.28, 78.296)}, 
    [2] = {coords = vector3(1561.845, -2177.55, 77.325)}, 
    [3] = {coords = vector3(1554.035, -2161.60, 77.771)}, 
    [4] = {coords = vector3(1580.641, -2135.03, 77.314)}, 
    [5] = {coords = vector3(1550.251, -2094.55, 77.208)}, 
    [6] = {coords = vector3(1555.681, -2067.51, 77.109)}, 
    [7] = {coords = vector3(1515.020, -2048.23, 77.311)}, 
    [8] = {coords = vector3(1485.104, -2089.51, 76.910)}, 
    [9] = {coords = vector3(1497.464, -2093.76, 76.803)}, 
    [10] = {coords = vector3(1511.853, -2129.96, 76.384)}, 
    [11] = {coords = vector3(1514.136, -2138.78, 76.770)}, 
    [12] = {coords = vector3(1541.536, -2133.96, 77.172)}, 
    [13] = {coords = vector3(1513.158, -2158.82, 77.839)}, 
}

advanced_gungame_coords_3 = {x = -1091.33, y = -1555.72, z = 4.3178}
advanced_gungame_spawns_3 = {
    [1] = {coords = vector3(-1170.24, -1521.73, 4.3484)}, 
    [2] = {coords = vector3(-1143.45, -1519.52, 7.5537)}, 
    [3] = {coords = vector3(-1161.35, -1550.77, 4.3639)}, 
    [4] = {coords = vector3(-1156.30, -1567.93, 4.4183)}, 
    [5] = {coords = vector3(-1131.88, -1551.78, 4.3102)}, 
    [6] = {coords = vector3(-1117.15, -1551.75, 4.3794)}, 
    [7] = {coords = vector3(-1120.81, -1496.00, 4.5805)}, 
    [8] = {coords = vector3(-1099.00, -1513.90, 4.6860)}, 
    [9] = {coords = vector3(-1079.20, -1491.49, 5.0748)}, 
    [10] = {coords = vector3(-1086.71, -1508.61, 4.9178)}, 
    [11] = {coords = vector3(-1060.34, -1538.58, 4.9933)}, 
    [12] = {coords = vector3(-1074.48, -1579.57, 4.2773)}, 
    [13] = {coords = vector3(-1068.22, -1563.68, 4.5614)}, 
    [14] = {coords = vector3(-1041.97, -1586.73, 5.0259)}, 
    [15] = {coords = vector3(-1044.37, -1552.70, 5.0734)}, 
    [16] = {coords = vector3(-1032.03, -1589.39, 5.0497)}, 
    [17] = {coords = vector3(-1037.42, -1608.25, 5.0195)}, 
    [18] = {coords = vector3(-1025.61, -1631.24, 4.6304)}, 
    [19] = {coords = vector3(-1059.40, -1656.81, 4.6031)}, 
    [20] = {coords = vector3(-1107.97, -1680.37, 4.2848)},
    [21] = {coords = vector3(-1082.82, -1671.50, 4.7049)}, 
    [22] = {coords = vector3(-1089.64, -1630.99, 4.7135)},
    [23] = {coords = vector3(-1117.45, -1625.33, 4.4335)},
    [24] = {coords = vector3(-1106.12, -1601.70, 4.6692)},
    [25] = {coords = vector3(-1143.84, -1595.31, 4.4065)},
}

advanced_gungame_coords_4 = {x = 3511.371, y = 3729.204, z = 37.206}
advanced_gungame_spawns_4 = {
    [1] = {coords = vector3(3453.333, 3764.244, 30.447)}, 
    [2] = {coords = vector3(3478.265, 3752.679, 32.679)}, 
    [3] = {coords = vector3(3556.880, 3815.531, 30.405)}, 
    [4] = {coords = vector3(3511.860, 3755.922, 29.793)}, 
    [5] = {coords = vector3(3624.511, 3762.557, 28.509)}, 
    [6] = {coords = vector3(3599.848, 3752.786, 30.072)}, 
    [7] = {coords = vector3(3541.354, 3751.270, 30.038)}, 
    [8] = {coords = vector3(3636.744, 3720.250, 34.730)}, 
    [9] = {coords = vector3(3605.949, 3703.230, 35.796)}, 
    [10] = {coords = vector3(3590.326, 3699.086, 36.642)}, 
    [11] = {coords = vector3(3576.799, 3732.265, 36.262)}, 
    [12] = {coords = vector3(3550.066, 3703.422, 36.642)}, 
    [13] = {coords = vector3(3523.633, 3698.561, 33.888)}, 
    [14] = {coords = vector3(3512.684, 3744.515, 36.253)}, 
    [15] = {coords = vector3(3467.604, 3723.263, 36.642)}, 
}

advanced_gungame_coords_5 = {x = 332.0458, y = -2039.40, z = 20.956}
advanced_gungame_spawns_5 = {
    [1] = {coords = vector3(271.7554, -2043.22, 18.074)}, 
    [2] = {coords = vector3(340.8916, -1961.42, 24.508)}, 
    [3] = {coords = vector3(299.1655, -2034.39, 19.848)}, 
    [4] = {coords = vector3(288.9877, -2053.54, 18.991)}, 
    [5] = {coords = vector3(289.8842, -2098.57, 16.960)}, 
    [6] = {coords = vector3(307.7344, -2101.89, 17.669)}, 
    [7] = {coords = vector3(342.9036, -2099.24, 18.190)}, 
    [8] = {coords = vector3(329.5203, -2069.81, 20.302)}, 
    [9] = {coords = vector3(320.9957, -2131.31, 14.587)}, 
    [10] = {coords = vector3(378.0648, -2071.82, 21.273)}, 
    [11] = {coords = vector3(379.8114, -2051.22, 21.794)}, 
    [12] = {coords = vector3(343.2232, -2033.15, 21.811)}, 
    [13] = {coords = vector3(388.7929, -2019.79, 23.301)}, 
    [14] = {coords = vector3(335.7278, -2009.48, 22.338)}, 
    [15] = {coords = vector3(381.5989, -1986.39, 24.108)}, 
}

advanced_gungame_coords_6 = {x = 1025.283, y = 2409.317, z = 54.504}
advanced_gungame_spawns_6 = {
    [1] = {coords = vector3(1097.614, 2380.704, 46.410)}, 
    [2] = {coords = vector3(1040.107, 2346.564, 47.169)}, 
    [3] = {coords = vector3(1105.616, 2403.598, 50.075)}, 
    [4] = {coords = vector3(1113.729, 2469.812, 51.001)}, 
    [5] = {coords = vector3(1048.789, 2496.287, 49.147)}, 
    [6] = {coords = vector3(1029.313, 2449.145, 45.526)}, 
    [7] = {coords = vector3(1001.317, 2431.449, 47.295)}, 
    [8] = {coords = vector3(1027.768, 2460.041, 49.565)}, 
    [9] = {coords = vector3(1000.994, 2424.202, 49.668)}, 
    [10] = {coords = vector3(983.8102, 2495.567, 53.958)}, 
    [11] = {coords = vector3(968.2098, 2412.428, 51.706)}, 
    [12] = {coords = vector3(1013.375, 2383.058, 51.780)}, 
    [13] = {coords = vector3(981.0325, 2357.221, 51.152)}, 
    [14] = {coords = vector3(937.5433, 2369.481, 48.308)}, 
    [15] = {coords = vector3(924.4868, 2451.748, 50.614)}, 
    [16] = {coords = vector3(1025.179, 2522.910, 45.537)},  
}

RegisterNetEvent('ta-base:client:gungame:set-coords')
AddEventHandler('ta-base:client:gungame:set-coords', function(map)
    if map == 1 then
        cl_gungame_map_1 = true
        cl_gungame_map_2 = false
        cl_gungame_map_3 = false
        cl_gungame_map_4 = false
        cl_gungame_map_5 = false
        cl_gungame_map_6 = false
    elseif map == 2 then
        cl_gungame_map_1 = false
        cl_gungame_map_2 = true
        cl_gungame_map_3 = false
        cl_gungame_map_4 = false
        cl_gungame_map_5 = false
        cl_gungame_map_6 = false
    elseif map == 3 then
        cl_gungame_map_1 = false
        cl_gungame_map_2 = false
        cl_gungame_map_3 = true
        cl_gungame_map_4 = false
        cl_gungame_map_5 = false
        cl_gungame_map_6 = false
    elseif map == 4 then
        cl_gungame_map_1 = false
        cl_gungame_map_2 = false
        cl_gungame_map_3 = false
        cl_gungame_map_4 = true
        cl_gungame_map_5 = false
        cl_gungame_map_6 = false
    elseif map == 5 then
        cl_gungame_map_1 = false
        cl_gungame_map_2 = false
        cl_gungame_map_3 = false
        cl_gungame_map_4 = false
        cl_gungame_map_5 = true
        cl_gungame_map_6 = false
    elseif map == 6 then
        cl_gungame_map_1 = false
        cl_gungame_map_2 = false
        cl_gungame_map_3 = false
        cl_gungame_map_4 = false
        cl_gungame_map_5 = false
        cl_gungame_map_6 = true
    end
end)

RegisterNetEvent('ta-base:gungame-hud')
AddEventHandler('ta-base:gungame-hud', function(action)
    if advanced_gungame then
        if action == "show" then
            SendNUIMessage({type = "gungame-board-open", currentweapon = WeaponList[gungame_currentLevel].name, nextweapon = WeaponList[gungame_currentLevel+1].name, remaingkill = WeaponList[gungame_currentLevel].value, remaingweapon = 11 - gungame_level})
        elseif action == "hide" then
            SendNUIMessage({type = "gungame-board-close"})
        end
    end
end)

RegisterNetEvent('ta-base:gamemodes:client:gungame:spawn')
AddEventHandler('ta-base:gamemodes:client:gungame:spawn', function()
	local ped = PlayerPedId()
	if not gungameboard and not gungame_finish then
		gungameboard = true
		SendNUIMessage({type = "gungame-board-open", currentweapon = WeaponList[gungame_currentLevel].name, nextweapon = WeaponList[gungame_currentLevel+1].name, remaingkill = WeaponList[gungame_currentLevel].value, remaingweapon = 11 - gungame_level})
	end
    RemoveAllPedWeapons(ped, false)
    Wait(500)
	GiveWeaponToPed(ped, GetHashKey(WeaponList[gungame_currentLevel].level), 9999, true, false)
	SetCurrentPedWeapon(ped, GetHashKey(WeaponList[gungame_currentLevel].level), true)
end)

RegisterNetEvent('ta-base:gamemodes:client:gungame:update-level')
AddEventHandler('ta-base:gamemodes:client:gungame:update-level', function(level)
	gungame_level = level
end)

RegisterNetEvent('ta-base:gamemodes:client:gungame:levelup')
AddEventHandler('ta-base:gamemodes:client:gungame:levelup', function(newLevel, newKill)
	local ped = PlayerPedId()
	RemoveAllPedWeapons(ped, false) Wait(10)
	gungame_currentLevel = newLevel
	gungame_currentKill = 0
	GiveWeaponToPed(ped, GetHashKey(WeaponList[gungame_currentLevel].level), 9999, true, false)
	SetCurrentPedWeapon(ped, GetHashKey(WeaponList[gungame_currentLevel].level), true)
	TriggerServerEvent('ta-base:gamemodes:server:gungame:get-level')
	SendNUIMessage({type = "gungame-board-currentweapon-update", currentweapon = WeaponList[gungame_currentLevel].name})
	local messageText = 'Sıradaki silaha geçiş yapabilmek için ~h~'..WeaponList[newLevel].value..'~h~ öldürmeye ihtiyacın var!'
	local scaleform = Scaleform.NewAsync('MIDSIZED_MESSAGE')
	scaleform:call('SHOW_COND_SHARD_MESSAGE', 'LEVEL UP', messageText, 4)
	scaleform:renderFullscreenTimed(3000)
end)

RegisterNetEvent('ta-base:gamemodes:client:gungame:update-kill')
AddEventHandler('ta-base:gamemodes:client:gungame:update-kill', function(kill)
	gungame_currentKill = kill
	TriggerServerEvent('ta-base:gamemodes:server:gungame:get-level')
	SendNUIMessage({type = "gungame-board-remaingkill-update", remaingkill = WeaponList[gungame_currentLevel].value - gungame_currentKill})
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		if advanced_gungame then
			if gungame_currentLevel ~= 11 then
				SendNUIMessage({type = "gungame-board-nextweapon-update", nextweapon = WeaponList[gungame_currentLevel+1].name})
			else
				SendNUIMessage({type = "gungame-board-nextweapon-update", nextweapon = "YOK"})
			end
			SendNUIMessage({type = "gungame-board-remaingweapon-update", remaingweapon = 11 - gungame_level})
			SendNUIMessage({type = "gungame-board-remaingkill-update", remaingkill = WeaponList[gungame_currentLevel].value - gungame_currentKill})
		end
	end
end)

RegisterNetEvent('ta-base:gamemodes:client:gungame:finishgame')
AddEventHandler('ta-base:gamemodes:client:gungame:finishgame', function(winner, avatar)
	if advanced_gungame then
        gungame_finish = true
        if gungame_finish then
            if isDead then
                respawnbabusrespawn()
            end
            -----------------------------------------
            SendNUIMessage({type = "gungame-board-close"})
            gungameboard = false
            gungame_currentLevel = 1
            gungame_currentKill = 0
            gungame_level = 1
            DisplayRadar(false)
            TriggerEvent("ta-hud:main-hud", false)
            TriggerEvent('ta-basics:general-hud', "fake-hide")
            TriggerEvent('ta-crosshairs:action', "fake-hide")
            -----------------------------------------
            FreezeEntityPosition(PlayerPedId(), false)	
            SetEntityCoords(PlayerPedId(), 72.4780, -1970.4, 20.7928, false, false, false, false)
            if GetPlayerName(PlayerId()) == winner then
                SetEntityHeading(PlayerPedId(), 354.98)
                SetEntityCoords(PlayerPedId(), 103.667, -1959.2, 19.8095, false, false, false, false)
                FreezeEntityPosition(PlayerPedId(), true) 
                TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_PARTYING", 0, true)
            end
            SendNUIMessage({
                action = "showWinner",
                name = winner,
                avatar = avatar
            })
            FreezeEntityPosition(PlayerPedId(), true) 
            gungame_cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1) SetCamActive(gungame_cam, true) RenderScriptCams(true, false, 1, true, true) SetCamCoord(gungame_cam,104.070, -1955.9, 21.3)
            PointCamAtCoord(gungame_cam, 104.070, -1955.9, 21.3, 177.38) SetCamFov(gungame_cam, 17.0) SetCamRot(gungame_cam, 0.0, 0.0, 164.0, true) Wait(100)
            -----------------------------------------
            RemoveAllPedWeapons(PlayerPedId(), false)
            Wait(3000)
            TriggerServerEvent("map_selector:server:startSelecting", 2019)
        end
	end
end)

RegisterNetEvent('ta-base:gungame:client:new-game')
AddEventHandler('ta-base:gungame:client:new-game', function()
    SendNUIMessage({
        action = "hideWinner",
    })
    DeleteAllBlips()
    DestroyCam(gungame_cam, false)
    gungame_cam = nil
    RenderScriptCams(false, false, 0, true, false)
    gungameboard = false
    gungame_currentLevel = 1
    gungame_currentKill = 0
    gungame_level = 1
    FreezeEntityPosition(PlayerPedId(), false)	
    CreateBlip("advanced_gungame")
    RandomSpawn("advanced_gungame", false)
    gungame_finish = false
    RemoveAllPedWeapons(ped, false)
    Wait(500)
	GiveWeaponToPed(ped, GetHashKey(WeaponList[gungame_currentLevel].level), 9999, true, false)
	SetCurrentPedWeapon(ped, GetHashKey(WeaponList[gungame_currentLevel].level), true)
    SendNUIMessage({type = "gungame-board-open", currentweapon = WeaponList[gungame_currentLevel].name, nextweapon = WeaponList[gungame_currentLevel+1].name, remaingkill = WeaponList[gungame_currentLevel].value, remaingweapon = 11 - gungame_level})
    DisplayRadar(true)
    TriggerEvent("ta-hud:main-hud", true)
    TriggerEvent('ta-basics:general-hud', "fake-show")
    TriggerEvent('ta-crosshairs:action', "fake-show")
    while not IsScreenFadedOut() do Citizen.Wait(100) end
    Wait(200) DoScreenFadeIn(1500)
end)