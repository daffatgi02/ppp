local disableHudComponents = {1, 2, 3, 4, 7, 9, 13, 14, 20, 21, 22}
combatmode = false
combatmodeproc = false
takla = false
buelemandusuyo = false

SatNav = {
    ["NONE"] = {icon = 0},
    ["UP"] = {icon = 1},
    ["DOWN"] = {icon = 2},
    ["LEFT"] = {icon = 3},
    ["RIGHT"] = {icon = 4},
    ["EXIT_LEFT"] = {icon = 5},
    ["EXIT_RIGHT"] = {icon = 6},
    ["UP_LEFT"] = {icon = 7},
    ["UP_RIGHT"] = {icon = 8},
    ["MERGE_RIGHT"] = {icon = 9},
    ["MERGE_LEFT"] = {icon = 10},
    ["UTURN"] = {icon = 11},
}

MinimapScaleform = {scaleform = nil}

Citizen.CreateThread(function()
    local minimap = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)
    SetDiscordAppId(1132758330604015647)
    SetDiscordRichPresenceAsset('logo')
    SetDiscordRichPresenceAction(0, "Discord", "https://discord.gg/turkishacademy")
    while true do
        Wait(0)
        local ply_ped = PlayerPedId()
        local currentWeapon = GetCurrentPedWeapon(ply_ped)
        if currentWeapon then
            SetPlayerLockon(PlayerId(), false)
        else
            SetPlayerLockon(PlayerId(), true)
        end
        SetEntityProofs(ply_ped, false, true, true, true, false, true, false, true)
        ---------------------------------------------
        if GetPedStealthMovement(ply_ped) then
            combatmode = true
          end
        if combatmode then
          DisablePlayerFiring(ply_ped, true)
          TriggerEvent('ta-base:client:disablecombatmode')
        end
        ---------------------------------------------
        BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
        ScaleformMovieMethodAddParamInt(3)
        EndScaleformMovieMethod()
        ---------------------------------------------
        if not GetPedConfigFlag(ply_ped,78,1) then
          SetPedUsingActionMode(ply_ped, false, -1, 0)
        end
        ---------------------------------------------
        SetCreateRandomCops(false)
        SetRadarBigmapEnabled(false, false)
        SetCreateRandomCopsNotOnScenarios(false)
        SetCreateRandomCopsOnScenarios(false)
        SetGarbageTrucks(false)
        SetRandomBoats(false)
        SetVehicleDensityMultiplierThisFrame(0.0)
        SetPedDensityMultiplierThisFrame(0.0)
        SetRandomVehicleDensityMultiplierThisFrame(0.0)
        SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
        SetParkedVehicleDensityMultiplierThisFrame(0.0)
        local x,y,z = table.unpack(GetEntityCoords(ply_ped))
        ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
        RemoveVehiclesFromGeneratorsInArea(x - 500.0, y - 500.0, z - 500.0, x + 500.0, y + 500.0, z + 500.0);
        ---------------------------------------------   
        for i = 1, 12 do
          EnableDispatchService(i, false)
        end
        SetPlayerWantedLevel(PlayerId(), 0, false)
        SetPlayerWantedLevelNow(PlayerId(), false)
        SetPlayerWantedLevelNoDrop(PlayerId(), 0, false)
        SetPauseMenuActive(false)
        ---------------------------------------------
        SetPlayerCanUseCover(PlayerId(), false)
        ---------------------------------------------
        StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE");
        SetAudioFlag("PoliceScannerDisabled",true);
        ---------------------------------------------
        MumbleSetActive(false)
        RestorePlayerStamina(PlayerId(), 1.0)
        SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0) 
        ---------------------------------------------
         RemoveAllPickupsOfType(0x6E4E65C2) RemoveAllPickupsOfType(0x741C684A) RemoveAllPickupsOfType(0x68605A36) RemoveAllPickupsOfType(0x6C5B941A) RemoveAllPickupsOfType(0xD3A39366)
         RemoveAllPickupsOfType(0x550447A9) RemoveAllPickupsOfType(0xF99E15D0) RemoveAllPickupsOfType(0xA421A532) RemoveAllPickupsOfType(0xF33C83B0) RemoveAllPickupsOfType(0xDF711959)
         RemoveAllPickupsOfType(0xB2B5325E) RemoveAllPickupsOfType(0x85CAA9B1) RemoveAllPickupsOfType(0xB2930A14) RemoveAllPickupsOfType(0xFE2A352C) RemoveAllPickupsOfType(0x693583AD)
         RemoveAllPickupsOfType(0x1D9588D3) RemoveAllPickupsOfType(0x3A4C2AD2) RemoveAllPickupsOfType(0x4BFB42D1) RemoveAllPickupsOfType(0x4D36C349) RemoveAllPickupsOfType(0x2F36B434)
         RemoveAllPickupsOfType(0x8F707C18) RemoveAllPickupsOfType(0xA9355DCD) RemoveAllPickupsOfType(0x96B412A3) RemoveAllPickupsOfType(0x9299C95B) RemoveAllPickupsOfType(0x5E0683A1)
         RemoveAllPickupsOfType(0x2DD30479) RemoveAllPickupsOfType(0x1CD604C7) RemoveAllPickupsOfType(0x7C119D58) RemoveAllPickupsOfType(0xF9AFB48F) RemoveAllPickupsOfType(0x8967B4F3)
         RemoveAllPickupsOfType(0x3B662889) RemoveAllPickupsOfType(0x2E764125) RemoveAllPickupsOfType(0xFE18F3AF) RemoveAllPickupsOfType(0xFD16169E) RemoveAllPickupsOfType(0xCB13D282)
         RemoveAllPickupsOfType(0xC69DE3FF) RemoveAllPickupsOfType(0x278D8734) RemoveAllPickupsOfType(0x5EA16D74) RemoveAllPickupsOfType(0x295691A9) RemoveAllPickupsOfType(0x81EE601E)
         RemoveAllPickupsOfType(0x88EAACA7) RemoveAllPickupsOfType(0x872DC888) RemoveAllPickupsOfType(0x094AA1CF) RemoveAllPickupsOfType(0x2C014CA6) RemoveAllPickupsOfType(0xE33D8630)
         RemoveAllPickupsOfType(0x80AB931C) RemoveAllPickupsOfType(0x6E717A95) RemoveAllPickupsOfType(0x4B5259BE) RemoveAllPickupsOfType(0xCE6FDD6B) RemoveAllPickupsOfType(0x5DE0AD3E)
         RemoveAllPickupsOfType(0x1E9A99F8) RemoveAllPickupsOfType(0x20893292) RemoveAllPickupsOfType(0x14568F28) RemoveAllPickupsOfType(0x711D02A4) RemoveAllPickupsOfType(0xDE78F17E)
         RemoveAllPickupsOfType(0xD0AACEF7) RemoveAllPickupsOfType(0xCC8B3905) RemoveAllPickupsOfType(0xA54AE7B7) RemoveAllPickupsOfType(0xA717F898) RemoveAllPickupsOfType(0x079284A9)
         RemoveAllPickupsOfType(0xE175C698) RemoveAllPickupsOfType(0x624F7213) RemoveAllPickupsOfType(0xC01EB678) RemoveAllPickupsOfType(0x5C517D97) RemoveAllPickupsOfType(0xBD4DE242)
         RemoveAllPickupsOfType(0xE013E01C) RemoveAllPickupsOfType(0x789576E2) RemoveAllPickupsOfType(0xFD9CAEDE) RemoveAllPickupsOfType(0x8ADDEC75)
         ---------------------------------------------
         if GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_PISTOL') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_PISTOL"), 0xED265A1C)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_PISTOL"), 0x359B7AAE)
         elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_COMBATPISTOL') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_COMBATPISTOL"), 0xD67B4F2D)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_COMBATPISTOL"), 0x359B7AAE)
         elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_PISTOL_MK2') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_PISTOL_MK2"), 0x5ED6C128)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_PISTOL_MK2"), 0x8ED4BB70)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_PISTOL_MK2"), 0x43FD595B)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_VINTAGEPISTOL') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_VINTAGEPISTOL"), 0x33BA12E8)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_HEAVYPISTOL') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_HEAVYPISTOL"), 0x64F9C62B)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_HEAVYPISTOL"), 0x359B7AAE)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_PISTOL50') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_PISTOL50"), 0xD9D3AC92)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_PISTOL50"), 0x359B7AAE)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_APPISTOL') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_APPISTOL"), 0x249A17D5)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_APPISTOL"), 0x359B7AAE)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_MACHINEPISTOL') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_MACHINEPISTOL"), 0xA9E9CAF4)
          ---------------------------------------------
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_MICROSMG') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_MICROSMG"), 0x10E6BA2B)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_MICROSMG"), 0x359B7AAE)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_MICROSMG"), 0x9D2FBF29)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_SMG') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_SMG"), 0x350966FB)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_SMG"), 0x7BC4CDDC)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_SMG"), 0x3CC6BA57)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_SMG_MK2') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_SMG_MK2"), 0xB9835B2E)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_SMG_MK2"), 0x9FDB5652)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_SMG_MK2"), 0x4DB62ABE)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_COMBATPDW') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_COMBATPDW"), 0x334A5203)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_COMBATPDW"), 0x7BC4CDDC)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_COMBATPDW"), 0xAA2C45B4)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_GUSENBERG') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_GUSENBERG"), 0xEAC8C270)
          ---------------------------------------------
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_ASSAULTRIFLE') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_ASSAULTRIFLE"), 0xB1214F9B)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_ASSAULTRIFLE"), 0x7BC4CDDC)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_ASSAULTRIFLE"), 0x9D2FBF29)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_ASSAULTRIFLE_MK2') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_ASSAULTRIFLE_MK2"), 0xD12ACA6F)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_ASSAULTRIFLE_MK2"), 0x7BC4CDDC)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_ASSAULTRIFLE_MK2"), 0x420FD713)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_CARBINERIFLE') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CARBINERIFLE"), 0x91109691)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CARBINERIFLE"), 0x7BC4CDDC)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CARBINERIFLE"), 0xA0D89C42)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_CARBINERIFLE_MK2') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CARBINERIFLE_MK2"), 0x5DD5DBD5)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CARBINERIFLE_MK2"), 0x7BC4CDDC)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CARBINERIFLE_MK2"), 0x420FD713)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_COMPACTRIFLE') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_GUSENBERG"), 0xC607740E)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_SPECIALCARBINE') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_SPECIALCARBINE"), 0x7C8BD10E)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_SPECIALCARBINE"), 0x7BC4CDDC)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_SPECIALCARBINE"), 0xA0D89C42)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_BULLPUPRIFLE') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_BULLPUPRIFLE"), 0xB3688B0F)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_BULLPUPRIFLE"), 0x7BC4CDDC)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_BULLPUPRIFLE"), 0xAA2C45B4)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_ADVANCEDRIFLE') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_ADVANCEDRIFLE"), 0x8EC1C979)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_ADVANCEDRIFLE"), 0x7BC4CDDC)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_ADVANCEDRIFLE"), 0xAA2C45B4)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_MILITARYRIFLE') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_BULLPUPRIFLE"), 0x684ACE42)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_BULLPUPRIFLE"), 0xAA2C45B4)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_BULLPUPRIFLE"), 0x7BC4CDDC)
          ---------------------------------------------
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_MG') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_MG"), 0x3C00AFED)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_MG"), 0x82158B47)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_COMBATMG') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_COMBATMG"), 0xA0D89C42)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_COMBATMG"), 0xD6C59CD6)
          ---------------------------------------------
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_CUSTOMPISTOL') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMPISTOL"), 0xED265A1C)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMPISTOL"), 0x359B7AAE)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_CUSTOMCOMBATPISTOL') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMCOMBATPISTOL"), 0xD67B4F2D)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMCOMBATPISTOL"), 0x359B7AAE)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_CUSTOMPISTOL_MK2') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMPISTOL_MK2"), 0x5ED6C128)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMPISTOL_MK2"), 0x8ED4BB70)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMPISTOL_MK2"), 0x43FD595B)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_CUSTOMVINTAGEPISTOL') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMVINTAGEPISTOL"), 0x33BA12E8)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_CUSTOMHEAVYPISTOL') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMHEAVYPISTOL"), 0x64F9C62B)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMHEAVYPISTOL"), 0x359B7AAE)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_CUSTOMPISTOL50') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMPISTOL50"), 0xD9D3AC92)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMPISTOL50"), 0x359B7AAE)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_CUSTOMMACHINEPISTOL') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMMACHINEPISTOL"), 0xA9E9CAF4)
          ---------------------------------------------
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_CUSTOMMICROSMG') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMMICROSMG"), 0x10E6BA2B)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMMICROSMG"), 0x359B7AAE)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMMICROSMG"), 0x9D2FBF29)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_CUSTOMSMG') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMSMG"), 0x350966FB)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMSMG"), 0x7BC4CDDC)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMSMG"), 0x3CC6BA57)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_CUSTOMSMG_MK2') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMSMG_MK2"), 0xB9835B2E)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMSMG_MK2"), 0x9FDB5652)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMSMG_MK2"), 0x4DB62ABE)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_CUSTOMCOMBATPDW') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMCOMBATPDW"), 0x334A5203)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMCOMBATPDW"), 0x7BC4CDDC)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMCOMBATPDW"), 0xAA2C45B4)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_CUSTOMGUSENBERG') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMGUSENBERG"), 0xEAC8C270)
          ---------------------------------------------
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_CUSTOMASSAULTRIFLE') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMASSAULTRIFLE"), 0xB1214F9B)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMASSAULTRIFLE"), 0x7BC4CDDC)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMASSAULTRIFLE"), 0x9D2FBF29)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_CUSTOMASSAULTRIFLE_MK2') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMASSAULTRIFLE_MK2"), 0xD12ACA6F)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMASSAULTRIFLE_MK2"), 0x7BC4CDDC)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMASSAULTRIFLE_MK2"), 0x420FD713)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_CUSTOMCARBINERIFLE') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMCARBINERIFLE"), 0x91109691)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMCARBINERIFLE"), 0x7BC4CDDC)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMCARBINERIFLE"), 0xA0D89C42)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_CUSTOMCARBINERIFLE_MK2') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMCARBINERIFLE_MK2"), 0x5DD5DBD5)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMCARBINERIFLE_MK2"), 0x7BC4CDDC)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMCARBINERIFLE_MK2"), 0x420FD713)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_CUSTOMCOMPACTRIFLE') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMCOMPACTRIFLE"), 0xC607740E)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_CUSTOMSPECIALCARBINE') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMSPECIALCARBINE"), 0x7C8BD10E)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMSPECIALCARBINE"), 0x7BC4CDDC)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMSPECIALCARBINE"), 0xA0D89C42)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_CUSTOMBULLPUPRIFLE') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMBULLPUPRIFLE"), 0xB3688B0F)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMBULLPUPRIFLE"), 0x7BC4CDDC)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMBULLPUPRIFLE"), 0xAA2C45B4)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_CUSTOMADVANCEDRIFLE') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMADVANCEDRIFLE"), 0x8EC1C979)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMADVANCEDRIFLE"), 0x7BC4CDDC)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMADVANCEDRIFLE"), 0xAA2C45B4)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_CUSTOMMILITARYRIFLE') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMMILITARYRIFLE"), 0x684ACE42)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMMILITARYRIFLE"), 0xAA2C45B4)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMMILITARYRIFLE"), 0x7BC4CDDC)
          ---------------------------------------------
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_CUSTOMMG') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMMG"), 0x3C00AFED)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMMG"), 0x82158B47)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_CUSTOMCOMBATMG') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMCOMBATMG"), 0xA0D89C42)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_CUSTOMCOMBATMG"), 0xD6C59CD6)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_SNIPERRIFLE') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_SNIPERRIFLE"), 0xA73D4664)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_SNIPERRIFLE"), 0xBC54DA77)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_HEAVYSNIPER') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_HEAVYSNIPER"), 0xBC54DA77)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_HEAVYSNIPER_MK2') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_HEAVYSNIPER_MK2"), 0xAC42DF71)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_HEAVYSNIPER_MK2"), 0x2CD8FF9D)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_HEAVYSNIPER_MK2"), 0x2E43DA41)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_MARKSMANRIFLE') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_MARKSMANRIFLE"), 0xC164F53)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_MARKSMANRIFLE"), 0xCCFD2AC5)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_MARKSMANRIFLE"), 0x837445AA)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_MARKSMANRIFLE_MK2') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_MARKSMANRIFLE_MK2"), 0xE6CFD1AA)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_MARKSMANRIFLE_MK2"), 0x9D65907A)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_MARKSMANRIFLE_MK2"), 0xEC9068CC)
        elseif GetSelectedPedWeapon(ply_ped) == GetHashKey('WEAPON_COMBATMG_MK2') then
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_COMBATMG_MK2"), 0x17DF42E9)
          GiveWeaponComponentToPed(ply_ped, GetHashKey("WEAPON_COMBATMG_MK2"), 0xC66B6542)
         end
    end
end)

RegisterNetEvent('ta-base:client:disablecombatmode')
AddEventHandler('ta-base:client:disablecombatmode', function()
  if not combatmodeproc then
    combatmodeproc = true
    Wait(500)
    combatmode = false
    combatmodeproc= false
    DisablePlayerFiring(PlayerPedId(), false)
  end
end)

Citizen.CreateThread(function()
  local detected = false
  local animDict = "move_strafe@roll"
  RequestAnimDict(animDict)
  while true do
      local playerPed = PlayerPedId()
      local ground = GetEntityHeightAboveGround(playerPed)
      if ground > 10 and not detected then
          detected = true
      end
      if detected and IsPedFalling(playerPed) and ground < 2 then
          ClearPedTasksImmediately(playerPed)
          TaskPlayAnim(playerPed, animDict, 'combatroll_fwd_p1_00', 8.0, 8.0, -1, 0, 0, 0, 0, 0)
          detected = false
      end
      Citizen.Wait(1)
  end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local ply_ped = PlayerPedId()
        ---------------------------------------------
        for i = 1, #disableHudComponents do
            HideHudComponentThisFrame(disableHudComponents[i])
        end
        ---------------------------------------------
    end
end)
  
local function getMinimap()
    return MinimapScaleform.scaleform
end

function SetSatNavDirection(direction)
    local dir = SatNav[direction]
    if type(direction) == 'number' then
        dir = direction
    end
    if dir then
        BeginScaleformMovieMethod(getMinimap(), "SET_SATNAV_DIRECTION")
        ScaleformMovieMethodAddParamInt(dir.icon)
        EndScaleformMovieMethod()
    end
end

function SetSatNavDistance(distance)
    BeginScaleformMovieMethod(getMinimap(), "SET_SATNAV_DISTANCE")
    ScaleformMovieMethodAddParamInt(distance)
    EndScaleformMovieMethod()
end

function SetSatNavState(show)
    BeginScaleformMovieMethod(getMinimap(), (show and "SHOW_SATNAV" or "HIDE_SATNAV"))
    EndScaleformMovieMethod()
end

function SetStallWarningState(show)
    BeginScaleformMovieMethod(getMinimap(), "SHOW_STALL_WARNING")
    ScaleformMovieMethodAddParamBool(show)
    EndScaleformMovieMethod()
end

function SetAbilityGlow(show)
    BeginScaleformMovieMethod(getMinimap(), "SET_ABILITY_BAR_GLOW")
    ScaleformMovieMethodAddParamBool(show)
    EndScaleformMovieMethod()
end

function SetAbilityVisible(show)
    BeginScaleformMovieMethod(getMinimap(), "SET_ABILITY_BAR_VISIBILITY_IN_MULTIPLAYER")
    ScaleformMovieMethodAddParamBool(show)
    EndScaleformMovieMethod()
end

function ShowYoke(x, y, vis, alpha)
    BeginScaleformMovieMethod(getMinimap(), "SHOW_YOKE")
    ScaleformMovieMethodAddParamFloat(show)
    ScaleformMovieMethodAddParamFloat(show)
    ScaleformMovieMethodAddParamBool(show)
    ScaleformMovieMethodAddParamInt(alpha)
    EndScaleformMovieMethod()
end

function SetHealthArmorType(type)
    BeginScaleformMovieMethod(getMinimap(), "SETUP_HEALTH_ARMOUR")
    ScaleformMovieMethodAddParamInt(type)
    EndScaleformMovieMethod()
end

function SetHealthAmount(amount)
    BeginScaleformMovieMethod(getMinimap(), "SET_PLAYER_HEALTH")
    ScaleformMovieMethodAddParamInt(amount)
    ScaleformMovieMethodAddParamFloat(0)
    ScaleformMovieMethodAddParamFloat(2000)
    ScaleformMovieMethodAddParamBool(false)
    EndScaleformMovieMethod()
end

function SetArmorAmount(amount)
    BeginScaleformMovieMethod(getMinimap(), "SET_PLAYER_ARMOUR")
    ScaleformMovieMethodAddParamInt(amount)
    ScaleformMovieMethodAddParamFloat(0)
    ScaleformMovieMethodAddParamFloat(2000)
    EndScaleformMovieMethod()
end

function SetAbilityAmount(amount)
    BeginScaleformMovieMethod(getMinimap(), "SET_ABILITY_BAR")
    ScaleformMovieMethodAddParamInt(amount)
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamFloat(100)
    EndScaleformMovieMethod()
end

function SetAirAmount(amount)
    BeginScaleformMovieMethod(getMinimap(), "SET_AIR_BAR")
    ScaleformMovieMethodAddParamFloat(amount)
    EndScaleformMovieMethod()
end

-- # Activity

Buttons = {
  {index = 0,name = 'Discord',url = 'https://discord.gg/turkishacademy'}
}

AddEventHandler('playerSpawned', function()
  if firstSpawn then
      for _, v in pairs(Buttons) do
          SetDiscordRichPresenceAction(v.index, v.name, v.url)
      end
      firstSpawn = false
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(10000)		
    SetRichPresence(GetPlayerName(PlayerId()).." | all my homies play TA")
  end
end)

Citizen.CreateThread(function()
  while true do
      Citizen.Wait(0)
      local ped = GetPlayerPed( -1 )
      local weapon = GetSelectedPedWeapon(ped)
    
      if weapon == GetHashKey("WEAPON_UNARMED") then     
          DisableControlAction(1, 140, true)
          DisableControlAction(1, 141, true)
          DisableControlAction(1, 142, true)
      end
    
    
      if weapon == GetHashKey("WEAPON_FIREEXTINGUISHER") then     
          if IsPedShooting(ped) then
              SetPedInfiniteAmmo(ped, true, GetHashKey("WEAPON_FIREEXTINGUISHER"))
          end
      end
  end
end)


RegisterNetEvent('ta-basics:general-hud')
AddEventHandler('ta-basics:general-hud', function(action, gamemodeaga)
  if action == "show" then
    SendNUIMessage({type = 'enable', gamemode = gamemodeaga})
  elseif action == "hide" then
    SendNUIMessage({type = 'disable'})
  elseif action == "fake-hide" then
    SendNUIMessage({type = 'fake-hide'})
  elseif action == "fake-show" then
    SendNUIMessage({type = 'fake-show'})
  end
end)

