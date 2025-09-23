allahgamemode = nil

function RandomSpawn(gamemode, first)
    allahgamemode = gamemode

    if first then
        TriggerServerEvent("ta-base:server:joingame", allahgamemode)
    end

    local ped = PlayerPedId()
    local ply = PlayerId()
    --------------------------------
    SetEntityInvincible(ped, false)
	SetPlayerInvincible(ply, false)
    --------------------------------
    if default_damaged_only_pistol then
        local random = math.random(1,20)
        SetEntityCoords(ped, default_damaged_only_pistol_spawns[random].coords.x, default_damaged_only_pistol_spawns[random].coords.y, default_damaged_only_pistol_spawns[random].coords.z - 1.0)
        if first then
            TriggerServerEvent('ta-base:server:set-bucket', 2001)
            TriggerServerEvent('ta-base:server:weapons', "default_damaged_only_pistol", "add", false)
        else
            TriggerServerEvent('ta-base:server:weapons', "default_damaged_only_pistol", "remove")
            TriggerServerEvent('ta-base:server:weapons', "default_damaged_only_pistol", "add", false)
        end
    elseif default_damaged_only_pistol_2 then
        local random = math.random(1,14)
        SetEntityCoords(ped, default_damaged_only_pistol_2_spawns[random].coords.x, default_damaged_only_pistol_2_spawns[random].coords.y, default_damaged_only_pistol_2_spawns[random].coords.z - 1.0)
        if first then
            TriggerServerEvent('ta-base:server:set-bucket', 2002)
            TriggerServerEvent('ta-base:server:weapons', "default_damaged_only_pistol_2", "add", false)
        else
            TriggerServerEvent('ta-base:server:weapons', "default_damaged_only_pistol_2", "remove")
            TriggerServerEvent('ta-base:server:weapons', "default_damaged_only_pistol_2", "add", false)
        end
    elseif default_damaged_only_ap_pistol then
        local random = math.random(1,7)
        SetEntityCoords(ped, default_damaged_only_ap_pistol_spawns[random].coords.x, default_damaged_only_ap_pistol_spawns[random].coords.y, default_damaged_only_ap_pistol_spawns[random].coords.z - 1.0)
        if first then
            TriggerServerEvent('ta-base:server:set-bucket', 2003)
            TriggerServerEvent('ta-base:server:weapons', "default_damaged_only_ap_pistol", "add", false)
        else
            TriggerServerEvent('ta-base:server:weapons', "default_damaged_only_ap_pistol", "remove")
            TriggerServerEvent('ta-base:server:weapons', "default_damaged_only_ap_pistol", "add", false)
        end
    elseif default_damaged_only_ap_pistol_2 then
        local random = math.random(1,15)
        SetEntityCoords(ped, default_damaged_only_ap_pistol_2_spawns[random].coords.x, default_damaged_only_ap_pistol_2_spawns[random].coords.y, default_damaged_only_ap_pistol_2_spawns[random].coords.z - 1.0)
        if first then
            TriggerServerEvent('ta-base:server:set-bucket', 2004)
            TriggerServerEvent('ta-base:server:weapons', "default_damaged_only_ap_pistol_2", "add", false)
        else
            TriggerServerEvent('ta-base:server:weapons', "default_damaged_only_ap_pistol_2", "remove")
            TriggerServerEvent('ta-base:server:weapons', "default_damaged_only_ap_pistol_2", "add", false)
        end
    elseif default_damaged_only_smg then
        local random = math.random(1,17)
        SetEntityCoords(ped, default_damaged_only_smg_spawns[random].coords.x, default_damaged_only_smg_spawns[random].coords.y, default_damaged_only_smg_spawns[random].coords.z - 1.0)
        if first then
            TriggerServerEvent('ta-base:server:set-bucket', 2005)
            TriggerServerEvent('ta-base:server:weapons', "default_damaged_only_smg", "add", true)
        else
            TriggerServerEvent('ta-base:server:weapons', "default_damaged_only_smg", "remove")
            TriggerServerEvent('ta-base:server:weapons', "default_damaged_only_smg", "add", true)
        end
    elseif default_damaged_only_smg_2 then
        local random = math.random(1,28)
        SetEntityCoords(ped, default_damaged_only_smg_2_spawns[random].coords.x, default_damaged_only_smg_2_spawns[random].coords.y, default_damaged_only_smg_2_spawns[random].coords.z - 1.0)
        if first then
            TriggerServerEvent('ta-base:server:set-bucket', 2006)
            TriggerServerEvent('ta-base:server:weapons', "default_damaged_only_smg_2", "add", true)
        else
            TriggerServerEvent('ta-base:server:weapons', "default_damaged_only_smg_2", "remove")
            TriggerServerEvent('ta-base:server:weapons', "default_damaged_only_smg_2", "add", true)
        end
    elseif default_damaged_only_rifle then
        local random = math.random(1,16)
        SetEntityCoords(ped, default_damaged_only_rifle_spawns[random].coords.x, default_damaged_only_rifle_spawns[random].coords.y, default_damaged_only_rifle_spawns[random].coords.z - 1.0)
        if first then
            TriggerServerEvent('ta-base:server:set-bucket', 2007)
            TriggerServerEvent('ta-base:server:weapons', "default_damaged_only_rifle", "add", true)
        else
            TriggerServerEvent('ta-base:server:weapons', "default_damaged_only_rifle", "remove")
            TriggerServerEvent('ta-base:server:weapons', "default_damaged_only_rifle", "add", true)
        end
    elseif default_damaged_only_rifle_2 then
        local random = math.random(1,13)
        SetEntityCoords(ped, default_damaged_only_rifle_2_spawns[random].coords.x, default_damaged_only_rifle_2_spawns[random].coords.y, default_damaged_only_rifle_2_spawns[random].coords.z - 1.0)
        if first then
            TriggerServerEvent('ta-base:server:set-bucket', 2008)
            TriggerServerEvent('ta-base:server:weapons', "default_damaged_only_rifle_2", "add", true)
        else
            TriggerServerEvent('ta-base:server:weapons', "default_damaged_only_rifle_2", "remove")
            TriggerServerEvent('ta-base:server:weapons', "default_damaged_only_rifle_2", "add", true)
        end
    elseif custom_damaged_only_pistol then
        local random = math.random(1,13)
        SetEntityCoords(ped, custom_damaged_only_pistol_spawns[random].coords.x, custom_damaged_only_pistol_spawns[random].coords.y, custom_damaged_only_pistol_spawns[random].coords.z - 1.0)
        if first then
            TriggerServerEvent('ta-base:server:set-bucket', 2009)
            TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_pistol", "add", true)
        else
            TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_pistol", "remove")
            TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_pistol", "add", true)
        end
    elseif custom_damaged_only_pistol_2 then
        local random = math.random(1,16)
        SetEntityCoords(ped, custom_damaged_only_pistol_2_spawns[random].coords.x, custom_damaged_only_pistol_2_spawns[random].coords.y, custom_damaged_only_pistol_2_spawns[random].coords.z - 1.0)
        if first then
            TriggerServerEvent('ta-base:server:set-bucket', 2010)
            TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_pistol_2", "add", true)
        else
            TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_pistol_2", "remove")
            TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_pistol_2", "add", true)
        end
    elseif custom_damaged_only_smg then
        local random = math.random(1,14)
        SetEntityCoords(ped, custom_damaged_only_smg_spawns[random].coords.x, custom_damaged_only_smg_spawns[random].coords.y, custom_damaged_only_smg_spawns[random].coords.z - 1.0)
        if first then
            TriggerServerEvent('ta-base:server:set-bucket', 2011)
            TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_smg", "add", true)
        else
            TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_smg", "remove")
            TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_smg", "add", true)
        end
    elseif custom_damaged_only_rifle then
        local random = math.random(1,15)
        SetEntityCoords(ped, custom_damaged_only_rifle_spawns[random].coords.x, custom_damaged_only_rifle_spawns[random].coords.y, custom_damaged_only_rifle_spawns[random].coords.z - 1.0)
        if first then
            TriggerServerEvent('ta-base:server:set-bucket', 2012)
            TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_rifle", "add", true)
        else
            TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_rifle", "remove")
            TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_rifle", "add", true)
        end
    elseif custom_damaged_only_shotgun then
        local random = math.random(1,12)
        SetEntityCoords(ped, custom_damaged_only_shotgun_spawns[random].coords.x, custom_damaged_only_shotgun_spawns[random].coords.y, custom_damaged_only_shotgun_spawns[random].coords.z - 1.0)
        if first then
            TriggerServerEvent('ta-base:server:set-bucket', 2013)
            TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_shotgun", "add", true)
        else
            TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_shotgun", "remove")
            TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_shotgun", "add", true)
        end
    elseif custom_damaged_only_revolver then
        local random = math.random(1,13)
        SetEntityCoords(ped, custom_damaged_only_revolver_spawns[random].coords.x, custom_damaged_only_revolver_spawns[random].coords.y, custom_damaged_only_revolver_spawns[random].coords.z - 1.0)
        if first then
            TriggerServerEvent('ta-base:server:set-bucket', 2014)
            TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_revolver", "add", true)
        else
            TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_revolver", "remove")
            TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_revolver", "add", true)
        end
    elseif custom_damaged_only_m60 then
        local random = math.random(1,13)
        SetEntityCoords(ped, custom_damaged_only_m60_spawns[random].coords.x, custom_damaged_only_m60_spawns[random].coords.y, custom_damaged_only_m60_spawns[random].coords.z - 1.0)
        if first then
            TriggerServerEvent('ta-base:server:set-bucket', 2015)
            TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_m60", "add", true)
        else
            TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_m60", "remove")
            TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_m60", "add", true)
        end
    elseif custom_damaged_only_m60_2 then
        local random = math.random(1,7)
        SetEntityCoords(ped, custom_damaged_only_m60_2_spawns[random].coords.x, custom_damaged_only_m60_2_spawns[random].coords.y, custom_damaged_only_m60_2_spawns[random].coords.z - 1.0)
        if first then
            TriggerServerEvent('ta-base:server:set-bucket', 2016)
            TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_m60_2", "add", true)
        else
            TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_m60_2", "remove")
            TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_m60_2", "add", true)
        end
    elseif custom_damaged_only_labirent then
        local random = math.random(1,9)
        SetEntityCoords(ped, custom_damaged_only_labirent_spawns[random].coords.x, custom_damaged_only_labirent_spawns[random].coords.y, custom_damaged_only_labirent_spawns[random].coords.z - 1.0)
        if first then
            TriggerServerEvent('ta-base:server:set-bucket', 2018)
            TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_labirent", "add", false)
        else
            TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_labirent", "remove")
            TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_labirent", "add", false)
        end
    elseif advanced_gungame then
        if cl_gungame_map_1 then
            local random = math.random(1,16)
            SetEntityCoords(ped, advanced_gungame_spawns[random].coords.x, advanced_gungame_spawns[random].coords.y, advanced_gungame_spawns[random].coords.z - 1.0)
            if first then
                TriggerServerEvent('ta-base:server:set-bucket', 2019)
                TriggerEvent('ta-base:gamemodes:client:gungame:spawn')
            else
                TriggerEvent('ta-base:gamemodes:client:gungame:spawn')
            end
        elseif cl_gungame_map_2 then
            local random = math.random(1,13)
            SetEntityCoords(ped, advanced_gungame_spawns_2[random].coords.x, advanced_gungame_spawns_2[random].coords.y, advanced_gungame_spawns_2[random].coords.z - 1.0)
            if first then
                TriggerServerEvent('ta-base:server:set-bucket', 2019)
                TriggerEvent('ta-base:gamemodes:client:gungame:spawn')
            else
                TriggerEvent('ta-base:gamemodes:client:gungame:spawn')
            end
        elseif cl_gungame_map_3 then
            local random = math.random(1,25)
            SetEntityCoords(ped, advanced_gungame_spawns_3[random].coords.x, advanced_gungame_spawns_3[random].coords.y, advanced_gungame_spawns_3[random].coords.z - 1.0)
            if first then
                TriggerServerEvent('ta-base:server:set-bucket', 2019)
                TriggerEvent('ta-base:gamemodes:client:gungame:spawn')
            else
                TriggerEvent('ta-base:gamemodes:client:gungame:spawn')
            end
        elseif cl_gungame_map_4 then
            local random = math.random(1,15)
            SetEntityCoords(ped, advanced_gungame_spawns_4[random].coords.x, advanced_gungame_spawns_4[random].coords.y, advanced_gungame_spawns_4[random].coords.z - 1.0)
            if first then
                TriggerServerEvent('ta-base:server:set-bucket', 2019)
                TriggerEvent('ta-base:gamemodes:client:gungame:spawn')
            else
                TriggerEvent('ta-base:gamemodes:client:gungame:spawn')
            end
        elseif cl_gungame_map_5 then
            local random = math.random(1,15)
            SetEntityCoords(ped, advanced_gungame_spawns_5[random].coords.x, advanced_gungame_spawns_5[random].coords.y, advanced_gungame_spawns_5[random].coords.z - 1.0)
            if first then
                TriggerServerEvent('ta-base:server:set-bucket', 2019)
                TriggerEvent('ta-base:gamemodes:client:gungame:spawn')
            else
                TriggerEvent('ta-base:gamemodes:client:gungame:spawn')
            end
        elseif cl_gungame_map_6 then
            local random = math.random(1,16)
            SetEntityCoords(ped, advanced_gungame_spawns_6[random].coords.x, advanced_gungame_spawns_6[random].coords.y, advanced_gungame_spawns_6[random].coords.z - 1.0)
            if first then
                TriggerServerEvent('ta-base:server:set-bucket', 2019)
                TriggerEvent('ta-base:gamemodes:client:gungame:spawn')
            else
                TriggerEvent('ta-base:gamemodes:client:gungame:spawn')
            end
        end
    elseif advanced_gungame_2 then
        local random = math.random(1,13)
        SetEntityCoords(ped, advanced_gungame_2_spawns[random].coords.x, advanced_gungame_2_spawns[random].coords.y, advanced_gungame_2_spawns[random].coords.z - 1.0)
        if first then
            TriggerServerEvent('ta-base:server:set-bucket', 2020)
            TriggerServerEvent('ta-base:server:weapons', "advanced_gungame_2", "add", true)
            TriggerEvent('ta-base:driveby:spawncar')
        else
            TriggerEvent('ta-base:driveby:spawncar')
            TriggerServerEvent('ta-base:server:weapons', "advanced_gungame_2", "remove")
            TriggerServerEvent('ta-base:server:weapons', "advanced_gungame_2", "add", true)
        end
    elseif advanced_gungame_3 then
        local random = math.random(1,15)
        SetEntityCoords(ped, advanced_gungame_3_spawns[random].coords.x, advanced_gungame_3_spawns[random].coords.y, advanced_gungame_3_spawns[random].coords.z - 1.0)
        if first then
            TriggerServerEvent('ta-base:server:set-bucket', 2021)
            TriggerServerEvent('ta-base:server:weapons', "advanced_gungame_3", "add", true)
        else
            TriggerServerEvent('ta-base:server:weapons', "advanced_gungame_3", "remove")
            TriggerServerEvent('ta-base:server:weapons', "advanced_gungame_3", "add", true)
        end
    elseif advanced_gangwar then
        local random = math.random(1,15)
        SetEntityCoords(ped, advanced_gangwar_spawns[random].coords.x, advanced_gangwar_spawns[random].coords.y, advanced_gangwar_spawns[random].coords.z - 1.0)
        if first then
            TriggerServerEvent('ta-base:server:set-bucket', 2022)
            TriggerServerEvent('ta-base:server:weapons', "advanced_gangwar", "add", true)
        else
            TriggerServerEvent('ta-base:server:weapons', "advanced_gangwar", "remove")
            TriggerServerEvent('ta-base:server:weapons', "advanced_gangwar", "add", true)
        end
    elseif advanced_farm_fight then
        local random = math.random(1,15)
        SetEntityCoords(ped, advanced_farm_fight_spawns[random].coords.x, advanced_farm_fight_spawns[random].coords.y, advanced_farm_fight_spawns[random].coords.z - 1.0)
        if first then
            TriggerServerEvent('ta-base:server:set-bucket', 2023)
            TriggerServerEvent('ta-base:server:weapons', "advanced_farm_fight", "add", true)
        else
            TriggerServerEvent('ta-base:server:weapons', "advanced_farm_fight", "remove")
            TriggerServerEvent('ta-base:server:weapons', "advanced_farm_fight", "add", true)
        end
    elseif advanced_zombie then
        local random = math.random(1,15)
        SetEntityCoords(ped, advanced_zombie_spawns[random].coords.x, advanced_zombie_spawns[random].coords.y, advanced_zombie_spawns[random].coords.z - 1.0)
        if first then
            TriggerServerEvent('ta-base:server:set-bucket', 2024)
            TriggerServerEvent('ta-base:server:weapons', "advanced_zombie", "add", true)
        else
            TriggerServerEvent('ta-base:server:weapons', "advanced_zombie", "remove")
            TriggerServerEvent('ta-base:server:weapons', "advanced_zombie", "add", true)
        end
    elseif advanced_sumo then
        local random = math.random(1,8)
        SetEntityCoords(ped, advanced_sumo_spawns[random].coords.x, advanced_sumo_spawns[random].coords.y, advanced_sumo_spawns[random].coords.z - 1.0)
        if first then
            TriggerServerEvent('ta-base:server:set-bucket', 2025)
            TriggerEvent('ta-base:sumo:spawncar')
        else
            TriggerEvent('ta-base:sumo:spawncar')
        end
    elseif advanced_parkour then
        local random = math.random(1,4)
        SetEntityCoords(ped, advanced_parkour_spawns[random].coords.x, advanced_parkour_spawns[random].coords.y, advanced_parkour_spawns[random].coords.z - 2.0)
        SetEntityHeading(ped, advanced_parkour_spawns[random].heading)
        if first then
            TriggerServerEvent('ta-base:server:set-bucket', 2026)
            TriggerEvent('ta-base:facetoface:spawncar')
        else
            TriggerEvent('ta-base:facetoface:spawncar')
        end
    elseif advanced_snowball then
        local random = math.random(1,5)
        SetEntityCoords(ped, advanced_snowball_spawns[random].coords.x, advanced_snowball_spawns[random].coords.y, advanced_snowball_spawns[random].coords.z - 1.0)
        if first then
            TriggerServerEvent('ta-base:server:set-bucket', 2027)
            TriggerServerEvent('ta-base:server:weapons', "advanced_snowball", "add", false)
        else
            TriggerServerEvent('ta-base:server:weapons', "advanced_snowball", "remove")
            TriggerServerEvent('ta-base:server:weapons', "advanced_snowball", "add", false)
        end
    elseif advanced_knife then
        local random = math.random(1,6)
        SetEntityCoords(ped, advanced_knife_spawns[random].coords.x, advanced_knife_spawns[random].coords.y, advanced_knife_spawns[random].coords.z - 1.0)
        if first then
            TriggerServerEvent('ta-base:server:set-bucket', 2028)
            TriggerServerEvent('ta-base:server:weapons', "advanced_knife", "add", false)
        else
            TriggerServerEvent('ta-base:server:weapons', "advanced_knife", "remove")
            TriggerServerEvent('ta-base:server:weapons', "advanced_knife", "add", false)
        end
    end
    if first then
        FreezeEntityPosition(PlayerPedId(), true) 
        Wait(250)
        FreezeEntityPosition(PlayerPedId(), false)
        if not default_damaged_only_pistol and not default_damaged_only_pistol_2 and not default_damaged_only_ap_pistol and not default_damaged_only_ap_pistol_2 and not advanced_knife and not custom_damaged_only_labirent then
            SetPedArmour(PlayerPedId(), 200)
        end
        SetEntityHealth(PlayerPedId(), 200)
        while not IsScreenFadedOut() do Citizen.Wait(100) end
        Wait(300) DoScreenFadeIn(500)
    end
    Wait(1000)
    SendNUIMessage({action = "babalartikladifalse"})
    Wait(2000)
    main_pasifmod = false
end

RegisterNetEvent('ta-base:function:randomspawn')
AddEventHandler('ta-base:function:randomspawn', function()
    if farm_and_fight or priv_lobby_freeroam then
        TriggerServerEvent('ta-base:server:clear-inv')
        TriggerServerEvent('ta-base:server:weapons', "farm_and_fight", "remove")
        Wait(100)
        TriggerServerEvent('ta-base:server:weapons', "farm_and_fight", "add", true)
        local dist_for_respawn_1 = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), farm_and_fight_safe_1.x, farm_and_fight_safe_1.y, farm_and_fight_safe_1.z, false)
        local dist_for_respawn_2 = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), farm_and_fight_safe_2.x, farm_and_fight_safe_2.y, farm_and_fight_safe_2.z, false)
        local dist_for_respawn_3 = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), farm_and_fight_safe_3.x, farm_and_fight_safe_3.y, farm_and_fight_safe_3.z, false)
        local dist_for_respawn_4 = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), farm_and_fight_safe_4.x, farm_and_fight_safe_4.y, farm_and_fight_safe_4.z, false)
        local dist_for_respawn_5 = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), farm_and_fight_safe_5.x, farm_and_fight_safe_5.y, farm_and_fight_safe_5.z, false)
        local dist_for_respawn_6 = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), farm_and_fight_safe_6.x, farm_and_fight_safe_6.y, farm_and_fight_safe_6.z, false)
        local dist_for_respawn_7 = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), farm_and_fight_safe_7.x, farm_and_fight_safe_7.y, farm_and_fight_safe_7.z, false)
        if dist_for_respawn_1 < dist_for_respawn_2 and dist_for_respawn_1 < dist_for_respawn_3 and dist_for_respawn_1 < dist_for_respawn_4 and dist_for_respawn_1 < dist_for_respawn_5 and dist_for_respawn_1 < dist_for_respawn_6 and dist_for_respawn_1 < dist_for_respawn_7 then
            SetEntityCoords(PlayerPedId(), farm_and_fight_safe_1.x, farm_and_fight_safe_1.y, farm_and_fight_safe_1.z - 1.0)
        elseif dist_for_respawn_2 < dist_for_respawn_1 and dist_for_respawn_2 < dist_for_respawn_3 and dist_for_respawn_2 < dist_for_respawn_4 and dist_for_respawn_2 < dist_for_respawn_5 and dist_for_respawn_2 < dist_for_respawn_6 and dist_for_respawn_2 < dist_for_respawn_7 then
            SetEntityCoords(PlayerPedId(), farm_and_fight_safe_2.x, farm_and_fight_safe_2.y, farm_and_fight_safe_2.z - 1.0)
        elseif dist_for_respawn_3 < dist_for_respawn_1 and dist_for_respawn_3 < dist_for_respawn_2 and dist_for_respawn_3 < dist_for_respawn_4 and dist_for_respawn_3 < dist_for_respawn_5 and dist_for_respawn_3 < dist_for_respawn_6 and dist_for_respawn_3 < dist_for_respawn_7 then
            SetEntityCoords(PlayerPedId(), farm_and_fight_safe_3.x, farm_and_fight_safe_3.y, farm_and_fight_safe_3.z - 1.0)
        elseif dist_for_respawn_4 < dist_for_respawn_1 and dist_for_respawn_4 < dist_for_respawn_3 and dist_for_respawn_4 < dist_for_respawn_2 and dist_for_respawn_4 < dist_for_respawn_5 and dist_for_respawn_4 < dist_for_respawn_6 and dist_for_respawn_4 < dist_for_respawn_7 then
            SetEntityCoords(PlayerPedId(), farm_and_fight_safe_4.x, farm_and_fight_safe_4.y, farm_and_fight_safe_4.z - 1.0)
        elseif dist_for_respawn_5 < dist_for_respawn_1 and dist_for_respawn_5 < dist_for_respawn_3 and dist_for_respawn_5 < dist_for_respawn_4 and dist_for_respawn_5 < dist_for_respawn_2 and dist_for_respawn_5 < dist_for_respawn_6 and dist_for_respawn_5 < dist_for_respawn_7 then
            SetEntityCoords(PlayerPedId(), farm_and_fight_safe_5.x, farm_and_fight_safe_5.y, farm_and_fight_safe_5.z - 1.0)
        elseif dist_for_respawn_6 < dist_for_respawn_1 and dist_for_respawn_6 < dist_for_respawn_3 and dist_for_respawn_6 < dist_for_respawn_4 and dist_for_respawn_6 < dist_for_respawn_5 and dist_for_respawn_6 < dist_for_respawn_2 and dist_for_respawn_6 < dist_for_respawn_7 then
            SetEntityCoords(PlayerPedId(), farm_and_fight_safe_6.x, farm_and_fight_safe_6.y, farm_and_fight_safe_6.z - 1.0)
        elseif dist_for_respawn_7 < dist_for_respawn_1 and dist_for_respawn_7 < dist_for_respawn_3 and dist_for_respawn_7 < dist_for_respawn_4 and dist_for_respawn_7 < dist_for_respawn_5 and dist_for_respawn_7 < dist_for_respawn_6 and dist_for_respawn_7 < dist_for_respawn_2 then
            SetEntityCoords(PlayerPedId(), farm_and_fight_safe_7.x, farm_and_fight_safe_7.y, farm_and_fight_safe_7.z - 1.0)
        end
    end
    main_pasifmod = true
    if default_damaged_only_pistol then
        RandomSpawn("default_damaged_only_pistol", false)
    elseif default_damaged_only_pistol_2 then
        RandomSpawn("default_damaged_only_pistol_2", false)
    elseif default_damaged_only_ap_pistol then
        RandomSpawn("default_damaged_only_ap_pistol", false)
    elseif default_damaged_only_ap_pistol_2 then
        RandomSpawn("default_damaged_only_ap_pistol_2", false)
    elseif default_damaged_only_smg then
        RandomSpawn("default_damaged_only_smg", false)
    elseif default_damaged_only_smg_2 then
        RandomSpawn("default_damaged_only_smg_2", false)
    elseif default_damaged_only_rifle then
        RandomSpawn("default_damaged_only_rifle", false)
    elseif default_damaged_only_rifle_2 then
        RandomSpawn("default_damaged_only_rifle_2", false)
    elseif custom_damaged_only_pistol then
        RandomSpawn("custom_damaged_only_pistol", false)
    elseif custom_damaged_only_pistol_2 then
        RandomSpawn("custom_damaged_only_pistol_2", false)
    elseif custom_damaged_only_smg then
        RandomSpawn("custom_damaged_only_smg", false)
    elseif custom_damaged_only_rifle then
        RandomSpawn("custom_damaged_only_rifle", false)
    elseif custom_damaged_only_shotgun then
        RandomSpawn("custom_damaged_only_shotgun", false)
    elseif custom_damaged_only_revolver then
        RandomSpawn("custom_damaged_only_revolver", false)
    elseif custom_damaged_only_m60 then
        RandomSpawn("custom_damaged_only_m60", false)
    elseif custom_damaged_only_m60_2 then
        RandomSpawn("custom_damaged_only_m60_2", false)
    elseif custom_damaged_only_deluxo then
        TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_deluxo", "remove")
        TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_deluxo", "add", true)
        SetEntityCoords(PlayerPedId(), 423.378, -633.29, 28.5000 - 1.0) 
        SetEntityHeading(PlayerPedId(), 180.01)
    elseif custom_damaged_only_labirent then
        RandomSpawn("custom_damaged_only_labirent", false)
    elseif advanced_gungame then
        RandomSpawn("advanced_gungame", false)
    elseif advanced_gungame_2 then
        RandomSpawn("advanced_gungame_2", false)
    elseif advanced_gungame_3 then
        RandomSpawn("advanced_gungame_3", false)
    elseif advanced_gangwar then
        RandomSpawn("advanced_gangwar", false)
    elseif advanced_farm_fight then
        RandomSpawn("advanced_farm_fight", false)
    elseif advanced_zombie then
        RandomSpawn("advanced_zombie", false)
    elseif advanced_sumo then
        RandomSpawn("advanced_sumo", false)
    elseif advanced_parkour then
        RandomSpawn("advanced_parkour", false)
    elseif advanced_snowball then
        RandomSpawn("advanced_snowball", false)
    elseif advanced_knife then
        RandomSpawn("advanced_knife", false)
    elseif priv_lobbys then
        Priv_Lobby_RandomSpawn(false)
    end
end)

function Priv_Lobby_RandomSpawn(first, lobiadi)
    local ped = PlayerPedId()
    local ply = PlayerId()
    --------------------------------
    SetEntityInvincible(ped, false)
	SetPlayerInvincible(ply, false)
    --------------------------------
    if priv_lobby_freeroam then
        SetEntityAlpha(ped, 155, false)
        SetEntityCoords(ped, farm_and_fight_safe_1.x, farm_and_fight_safe_1.y, farm_and_fight_safe_1.z- 1.0)
    else
        if priv_lobby_maddex then
            local random = math.random(1,16)
            SetEntityCoords(ped, priv_lobby_madde_x_spawns[random].coords.x, priv_lobby_madde_x_spawns[random].coords.y, priv_lobby_madde_x_spawns[random].coords.z - 1.0)
        elseif priv_lobby_fadil then
            local random = math.random(1,16)
            SetEntityCoords(ped, custom_damaged_only_pistol_2_spawns[random].coords.x, custom_damaged_only_pistol_2_spawns[random].coords.y, custom_damaged_only_pistol_2_spawns[random].coords.z - 1.0)
        elseif priv_lobby_kelly then
            local random = math.random(1,13)
            SetEntityCoords(ped, custom_damaged_only_pistol_spawns[random].coords.x, custom_damaged_only_pistol_spawns[random].coords.y, custom_damaged_only_pistol_spawns[random].coords.z - 1.0)
        elseif priv_lobby_lspd then
            local random = math.random(1,14)
            SetEntityCoords(ped, custom_damaged_only_smg_spawns[random].coords.x, custom_damaged_only_smg_spawns[random].coords.y, custom_damaged_only_smg_spawns[random].coords.z - 1.0)
        elseif priv_lobby_taco then
            local random = math.random(1,20)
            SetEntityCoords(ped, default_damaged_only_pistol_spawns[random].coords.x, default_damaged_only_pistol_spawns[random].coords.y, default_damaged_only_pistol_spawns[random].coords.z - 1.0)
        end
    end
    if priv_lobby_pistol then
        if priv_lobby_default_damage then
            if first then
                TriggerServerEvent('ta-base:server:weapons', "default_damaged_only_pistol", "add", false)
            else
                TriggerServerEvent('ta-base:server:weapons', "default_damaged_only_pistol", "remove")
                TriggerServerEvent('ta-base:server:weapons', "default_damaged_only_pistol", "add", false)
            end
        elseif priv_lobby_custom_damage then
            if first then
                TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_pistol", "add", false)
            else
                TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_pistol", "remove")
                TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_pistol", "add", false)
            end
        end
    elseif priv_lobby_smg then 
        if priv_lobby_default_damage then
            if first then
                TriggerServerEvent('ta-base:server:weapons', "default_damaged_only_smg", "add", false)
            else
                TriggerServerEvent('ta-base:server:weapons', "default_damaged_only_smg", "remove")
                TriggerServerEvent('ta-base:server:weapons', "default_damaged_only_smg", "add", false)
            end
        elseif priv_lobby_custom_damage then
            if first then
                TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_smg", "add", false)
            else
                TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_smg", "remove")
                TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_smg", "add", false)
            end
        end
    elseif priv_lobby_rifle then
        if priv_lobby_default_damage then
            if first then
                TriggerServerEvent('ta-base:server:weapons', "default_damaged_only_rifle", "add", false)
            else
                TriggerServerEvent('ta-base:server:weapons', "default_damaged_only_rifle", "remove")
                TriggerServerEvent('ta-base:server:weapons', "default_damaged_only_rifle", "add", false)
            end
        elseif priv_lobby_custom_damage then
            if first then
                TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_rifle", "add", false)
            else
                TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_rifle", "remove")
                TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_rifle", "add", false)
            end
        end
    elseif priv_lobby_freeroam then
        if first then
            TriggerServerEvent('ta-base:server:weapons', "farm_and_fight", "add", true)
        else
            TriggerServerEvent('ta-base:server:weapons', "farm_and_fight", "remove")
            TriggerServerEvent('ta-base:server:weapons', "farm_and_fight", "add", true)
        end
    end
    if first then
        FreezeEntityPosition(PlayerPedId(), true) 
        Wait(250)
        FreezeEntityPosition(PlayerPedId(), false)
        if not priv_lobby_default_damage and not priv_lobby_pistol then
            SetPedArmour(PlayerPedId(), 200)
        end
        TriggerEvent('ta-basics:general-hud', "show", "PRIVATE LOBBY | "..lobiadi)
        SetEntityHealth(PlayerPedId(), 200)
        while not IsScreenFadedOut() do Citizen.Wait(100) end
        Wait(300) DoScreenFadeIn(500)
    end
    Wait(1000)
    SendNUIMessage({action = "babalartikladifalse"})
    Wait(2000)
    main_pasifmod = false
end