farm_and_fight = false

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
advanced_gangwar = false
advanced_farm_fight = false
advanced_zombie = false
advanced_sumo = false
advanced_parkour = false
advanced_snowball = false
advanced_knife = false

priv_lobbys = false
priv_lobby_freeroam = false

priv_lobby_lspd = false
priv_lobby_taco = false
priv_lobby_fadil = false
priv_lobby_maddex = false
priv_lobby_kelly = false

priv_lobby_pistol = false
priv_lobby_smg = false
priv_lobby_rifle = false

priv_lobby_default_damage = false
priv_lobby_custom_damage = false


function JoinGameMode(gamemode)
    -- TriggerServerEvent('ta-base:server:clear-inv')
    -- TriggerEvent('ta-inv:client:inv_default', "join")
    if gamemode == "farm_and_fight" then
        farm_and_fight = true
        TriggerEvent('ta-basics:general-hud', "show", "FREE LOBBY")
        TriggerEvent('ta-leaderboard:gamemode-changed', "farm_and_fight", true)
    elseif gamemode == "default_damaged_only_pistol" then
        default_damaged_only_pistol = true
        TriggerEvent('ta-basics:general-hud', "show", "DEFAULT DAMAGED ONLY PISTOL")
    elseif gamemode == "default_damaged_only_pistol_2" then
        default_damaged_only_pistol_2 = true
        TriggerEvent('ta-basics:general-hud', "show", "DEFAULT DAMAGED ONLY PISTOL #2")
    elseif gamemode == "default_damaged_only_ap_pistol" then
        default_damaged_only_ap_pistol = true
        TriggerEvent('ta-basics:general-hud', "show", "DEFAULT DAMAGED AP PISTOL")
    elseif gamemode == "default_damaged_only_ap_pistol_2" then
        default_damaged_only_ap_pistol_2 = true
        TriggerEvent('ta-basics:general-hud', "show", "DEFAULT DAMAGED AP PISTOL #2")
    elseif gamemode == "default_damaged_only_smg" then
        default_damaged_only_smg = true
        TriggerEvent('ta-basics:general-hud', "show", "DEFAULT DAMAGED ONLY SMG")
    elseif gamemode == "default_damaged_only_smg_2" then
        default_damaged_only_smg_2 = true
        TriggerEvent('ta-basics:general-hud', "show", "DEFAULT DAMAGED ONLY SMG #2")
    elseif gamemode == "default_damaged_only_rifle" then
        default_damaged_only_rifle = true
        TriggerEvent('ta-basics:general-hud', "show", "DEFAULT DAMAGED ONLY RIFLE")
    elseif gamemode == "default_damaged_only_rifle_2" then
        default_damaged_only_rifle_2 = true
        TriggerEvent('ta-basics:general-hud', "show", "DEFAULT DAMAGED ONLY RIFLE #2")
    elseif gamemode == "custom_damaged_only_pistol" then
        custom_damaged_only_pistol = true
        TriggerEvent('ta-basics:general-hud', "show", "CUSTOM DAMAGED ONLY PISTOL")
    elseif gamemode == "custom_damaged_only_pistol_2" then
        custom_damaged_only_pistol_2 = true
        TriggerEvent('ta-basics:general-hud', "show", "CUSTOM DAMAGED ONLY PISTOL #2")
    elseif gamemode == "custom_damaged_only_smg" then
        custom_damaged_only_smg = true
        TriggerEvent('ta-basics:general-hud', "show", "CUSTOM DAMAGED ONLY SMG")
    elseif gamemode == "custom_damaged_only_rifle" then
        custom_damaged_only_rifle = true
        TriggerEvent('ta-basics:general-hud', "show", "CUSTOM DAMAGED ONLY RIFLE")
    elseif gamemode == "custom_damaged_only_shotgun" then
        custom_damaged_only_shotgun = true
        TriggerEvent('ta-basics:general-hud', "show", "CUSTOM DAMAGED ONLY SHOTGUN")
    elseif gamemode == "custom_damaged_only_revolver" then
        custom_damaged_only_revolver = true
        TriggerEvent('ta-basics:general-hud', "show", "CUSTOM DAMAGED ONLY REVOLVER")
    elseif gamemode == "custom_damaged_only_m60" then
        custom_damaged_only_m60 = true
        TriggerEvent('ta-basics:general-hud', "show", "CUSTOM DAMAGED M60 MAYHEM")
    elseif gamemode == "custom_damaged_only_m60_2" then
        custom_damaged_only_m60_2 = true
        TriggerEvent('ta-basics:general-hud', "show", "CUSTOM DAMAGED M60 MAYHEM #2")
    elseif gamemode == "custom_damaged_only_deluxo" then
        custom_damaged_only_deluxo = true
        TriggerEvent('ta-basics:general-hud', "show", "CUSTOM DAMAGED DELUXO TRICK")
    elseif gamemode == "custom_damaged_only_labirent" then
        custom_damaged_only_labirent = true
        TriggerEvent('ta-basics:general-hud', "show", "CUSTOM DAMAGED LABIRENT FIGHT")
    elseif gamemode == "advanced_gungame" then
        advanced_gungame = true
        TriggerEvent('ta-basics:general-hud', "show", "ADVANCED MODS - GUNGAME")
    elseif gamemode == "advanced_gungame_2" then
        advanced_gungame_2 = true
        TriggerEvent('ta-basics:general-hud', "show", "ADVANCED MODS - DRIVE-BY FIGHT")
    elseif gamemode == "advanced_gungame_3" then
        advanced_gungame_3 = true
        TriggerEvent('ta-basics:general-hud', "show", "ADVANCED MODS - GUNGAME #3")
    elseif gamemode == "advanced_gangwar" then
        advanced_gangwar = true
        TriggerEvent('ta-basics:general-hud', "show", "ADVANCED MODS - GANGWAR")
    elseif gamemode == "advanced_farm_fight" then
        advanced_farm_fight = true
    elseif gamemode == "advanced_zombie" then
        advanced_zombie = true
    elseif gamemode == "advanced_sumo" then
        TriggerEvent("ta-hud:main-hud", false)
        advanced_sumo = true
        TriggerEvent('ta-basics:general-hud', "show", "ADVANCED MODS - SUMO")
    elseif gamemode == "advanced_parkour" then
        TriggerEvent("ta-hud:main-hud", false)
        advanced_parkour = true
        TriggerEvent('ta-basics:general-hud', "show", "ADVANCED MODS - FACE TO FACE")
    elseif gamemode == "advanced_snowball" then
        advanced_snowball = true
        TriggerEvent('ta-basics:general-hud', "show", "ADVANCED MODS - SNOWBALL")
    elseif gamemode == "advanced_knife" then
        advanced_knife = true
        TriggerEvent('ta-basics:general-hud', "show", "ADVANCED MODS - KNIFE")
    end
end

Citizen.CreateThread(function()
    while true do
      Wait(1000) 
        local playerPed = PlayerPedId()
      if playerPed then
              local currentPos = GetEntityCoords(playerPed, true)
        if not main and not aimlab and not clothing_menu_aga then
          if prevPos and currentPos == prevPos then
            if timeLeft > 0 then
              timeLeft = timeLeft - 1 
            else 
              DoScreenFadeOut(500)
              Wait(1000)
              while not IsScreenFadedOut() do Citizen.Wait(100) end
              TriggerEvent('ta-base:client:joingame')
              Wait(1000)
              DoScreenFadeIn(1500)
            end
          else
            timeLeft = 180
          end
          prevPos = currentPos
        end 
      end
    end 
  end)
   
  Citizen.CreateThread(function()
    while true do
        Wait(0)
        local ply_ped = PlayerPedId()
        SetPedCanRagdoll(ply_ped, false)
        PedInfiniteAmmo()
        DisableControlAction(1, 140, true)
        DisableControlAction(1, 141, true)
        DisableControlAction(1, 142, true)
        DisableControlAction(0, 57, true)
         ---------------------------------------------
         if default_damaged_only_pistol then
            SetPedSuffersCriticalHits(ply_ped, true)
         elseif farm_and_fight then
          SetPedSuffersCriticalHits(ply_ped, false)
          SetPlayerCanDoDriveBy(PlayerId(), false)
         elseif default_damaged_only_pistol_2 then
            SetPedSuffersCriticalHits(ply_ped, true)
         elseif default_damaged_only_ap_pistol then
            SetPedSuffersCriticalHits(ply_ped, true)
         elseif default_damaged_only_smg then
            SetPedSuffersCriticalHits(ply_ped, true)
         elseif default_damaged_only_smg_2 then
            SetPedSuffersCriticalHits(ply_ped, true)
         elseif default_damaged_only_rifle then
            SetPedSuffersCriticalHits(ply_ped, true)
         elseif default_damaged_only_rifle_2 then
            SetPedSuffersCriticalHits(ply_ped, true)
         elseif custom_damaged_only_m60 then
            SetPedMoveRateOverride(ply_ped,1.2)
            SetPedSuffersCriticalHits(ply_ped, false)
         elseif custom_damaged_only_pistol then
            SetPedSuffersCriticalHits(ply_ped, false)
         elseif custom_damaged_only_pistol_2 then
            SetPedSuffersCriticalHits(ply_ped, false)
         elseif custom_damaged_only_smg then
            SetPedSuffersCriticalHits(ply_ped, false)
         elseif custom_damaged_only_rifle then
            SetPedSuffersCriticalHits(ply_ped, false)
         elseif custom_damaged_only_shotgun then
            SetPedSuffersCriticalHits(ply_ped, false)
         elseif custom_damaged_only_revolver then
            SetPedSuffersCriticalHits(ply_ped, false)
         elseif custom_damaged_only_labirent then
            SetPedSuffersCriticalHits(ply_ped, true)
         elseif custom_damaged_only_revolver then
            SetPedSuffersCriticalHits(ply_ped, true)
         elseif priv_lobby_default_damage then
          SetPedSuffersCriticalHits(ply_ped, true)
         elseif priv_lobby_custom_damage or priv_lobby_freeroam then
          SetPedSuffersCriticalHits(ply_ped, false)
         elseif custom_damaged_only_labirent or advanced_knife then
          SetPedSuffersCriticalHits(ply_ped, true)
        elseif advanced_gungame then
          SetPedSuffersCriticalHits(ply_ped, false)
        elseif matchmaking then
          SetPedSuffersCriticalHits(ply_ped, false)
         elseif advanced_gungame_2 then
          DisableControlAction(0, 75, true)
          SetPedSuffersCriticalHits(ply_ped, true)
          SetEntityCanBeDamaged(driveby_car, false)
          SetVehicleExplodesOnHighExplosionDamage(driveby_car, false)
        end
        ---------------------------------------------
        if IsPedFalling(ply_ped) and not isDead then
            SetEntityInvincible(PlayerPedId(), true)
            SetPlayerInvincible(PlayerId(), true)
        elseif not IsPedFalling(ply_ped) and not isDead and not main then
            SetEntityInvincible(PlayerPedId(), false)
            SetPlayerInvincible(PlayerId(), false)
        end
        ---------------------------------------------
    end
end)

CreateThread(function()
    while true do 
        if matchmaking then
            local vehicles = GetGamePool("CVehicle")
            for _, veh in pairs(vehicles) do
                if #(GetEntityCoords(veh) - vector3(2804.59, 3455.48, 55.4149)) < 1000 then
                    SetPedSuffersCriticalHits(veh, false)
                    SetEntityCanBeDamaged(veh, false)
                    SetVehicleExplodesOnHighExplosionDamage(veh, false)
                end
            end
        end
        Wait(1000)
    end
end)

function PedInfiniteAmmo()
    if default_damaged_only_pistol or default_damaged_only_pistol_2 or priv_lobby_pistol and priv_lobby_default_damage then
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_PISTOL"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_PISTOL_MK2"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_COMBATPISTOL"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_VINTAGEPISTOL"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_HEAVYPISTOL"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_PISTOL50"))
      elseif default_damaged_only_smg or default_damaged_only_smg_2 or priv_lobby_smg and priv_lobby_default_damage then
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_SMG"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_SMG_MK2"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_MICROSMG"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_COMBATPDW"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_MACHINEPISTOL"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_GUSENBERG"))
      elseif default_damaged_only_rifle or default_damaged_only_rifle_2 or priv_lobby_rifle and priv_lobby_default_damage then
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_ASSAULTRIFLE"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_ASSAULTRIFLE_MK2"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_CARBINERIFLE"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_CARBINERIFLE_MK2"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_COMPACTRIFLE"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_SPECIALCARBINE"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_BULLPUPRIFLE"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_ADVANCEDRIFLE"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_MILITARYRIFLE"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_HEAVYRIFLE"))
      elseif default_damaged_only_ap_pistol then
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_APPISTOL"))
      elseif custom_damaged_only_m60 then
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_CUSTOMMG"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_CUSTOMCOMBATMG"))
      elseif custom_damaged_only_pistol or custom_damaged_only_pistol_2 or priv_lobby_pistol and priv_lobby_custom_damage or matchmaki then
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_CUSTOMPISTOL"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_CUSTOMPISTOL_MK2"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_CUSTOMCOMBATPISTOL"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_CUSTOMVINTAGEPISTOL"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_CUSTOMHEAVYPISTOL"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_CUSTOMPISTOL50"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_BROWNING"))
      elseif custom_damaged_only_smg or priv_lobby_smg and priv_lobby_custom_damage then
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_CUSTOMSMG"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_CUSTOMSMG_MK2"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_CUSTOMMICROSMG"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_CUSTOMCOMBATPDW"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_CUSTOMMACHINEPISTOL"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_CUSTOMGUSENBERG"))
      elseif custom_damaged_only_rifle or priv_lobby_rifle and priv_lobby_custom_damage then
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_CUSTOMASSAULTRIFLE"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_CUSTOMASSAULTRIFLE_MK2"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_CUSTOMCARBINERIFLE"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_CUSTOMCARBINERIFLE_MK2"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_CUSTOMCOMPACTRIFLE"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_CUSTOMSPECIALCARBINE"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_CUSTOMBULLPUPRIFLE"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_CUSTOMADVANCEDRIFLE"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_CUSTOMMILITARYRIFLE"))
      elseif custom_damaged_only_shotgun then
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_PUMPSHOTGUN"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_SAWNOFFSHOTGUN"))
      elseif custom_damaged_only_revolver then
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_REVOLVER"))
      elseif custom_damaged_only_deluxo then
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_SNIPERRIFLE"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_HEAVYSNIPER"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_HEAVYSNIPER_MK2"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_MARKSMANRIFLE"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_MARKSMANRIFLE_MK2"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_COMBATMG_MK2"))
        SetPedInfiniteAmmo(PlayerPedId(), true, GetHashKey("WEAPON_MUSKET"))
    end
end

main_pasifmod = false

Citizen.CreateThread(function()
	while true do 
		wait = 1000
        if not main and ilkgiris == true and not custom_damaged_only_deluxo and not farm_and_fight then
            wait = 1
            if main_pasifmod then
                DisablePlayerFiring(PlayerPedId()) SetEntityInvincible(PlayerPedId(), true) SetPlayerInvincible(PlayerPedId(), true) SetEntityAlpha(PlayerPedId(), 155, false) SetLocalPlayerAsGhost(true)
                for _, player in ipairs(GetActivePlayers()) do
                    if player ~= PlayerId() and NetworkIsPlayerActive(player) then
                        SetEntityAlpha(GetPlayerPed(player), 155, false)
                    end
                end
            else
              SetEntityInvincible(PlayerPedId(), false) SetPlayerInvincible(PlayerPedId(), false) SetEntityAlpha(PlayerPedId(), 255, false) SetLocalPlayerAsGhost(false) 
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

RegisterNetEvent("ta-base:client:regen")
AddEventHandler("ta-base:client:regen", function()
    if not advanced_gungame then
        if default_damaged_only_pistol or default_damaged_only_pistol_2 or default_damaged_only_ap_pistol or custom_damaged_only_deluxo or custom_damaged_only_labirent and not advanced_knife then
            SetEntityHealth(PlayerPedId(), 200)
            RefillAmmoInstantly(PlayerPedId())
        else
            SetEntityHealth(PlayerPedId(), 200)
            if not priv_lobby_default_damage and not priv_lobby_pistol then
                SetPedArmour(PlayerPedId(), 200)
            end
        end
    end
end)

RegisterKeyMapping('+radiotalk', "Telsiz Animasyonu", 'keyboard', "CAPITAL")

RegisterCommand("+radiotalk", function()
  if default_damaged_only_pistol or default_damaged_only_pistol_2 or default_damaged_only_ap_pistol then
    DisablePlayerFiring(PlayerPedId(), true)
      RequestAnimDict('random@arrests')
      while not HasAnimDictLoaded('random@arrests') do
        Citizen.Wait(10)
      end
      TaskPlayAnim(PlayerPedId(), "random@arrests", "generic_radio_enter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0)
    end
end)

RegisterCommand("-radiotalk", function()
  DisablePlayerFiring(PlayerPedId(), false)
  StopAnimTask(PlayerPedId(), "random@arrests", "generic_radio_enter", -4.0)
end)

Citizen.CreateThread(function()
    local blips = {}
    local currentPlayer = PlayerId()

    while true do
        Wait(250)

        local players = GetActivePlayers()

        for _, player in ipairs(GetActivePlayers()) do
            if player ~= currentPlayer and NetworkIsPlayerActive(player) then
                local playerPed = GetPlayerPed(player)
                local playerName = GetPlayerName(player)
                RemoveBlip(blips[player])
                local new_blip = AddBlipForEntity(playerPed)
                SetBlipNameToPlayerName(new_blip, "Player")
                SetBlipColour(new_blip, 0)
                SetBlipCategory(new_blip, 0)
                SetBlipScale(new_blip, 0.6)
                blips[player] = new_blip
            end
        end
    end
end)