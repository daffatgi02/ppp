RegisterServerEvent('ta-base:server:weapons')
AddEventHandler('ta-base:server:weapons', function(gamemode, action, medkitarmor)
    local src = source
    if gamemode == "farm_and_fight" then
        if action == "add" then
            exports['ta-inv']:AddItem(src, "inventory", "weapon_custompistol", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_g17", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_g19", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_custompistol50", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_customheavypistol", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_customvintagepistol", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_browning", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_tolvector", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_customsmg", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_customsmg_mk2", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_custommicrosmg", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_custommachinepistol", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_customgusenberg", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_customassaultrifle", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_customassaultrifle_mk2", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_customcarbinerifle", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_customcarbinerifle_mk2", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_customcompactrifle", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_customspecialcarbine", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_custombullpuprifle", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_customadvancedrifle", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_custommilitaryrifle", 1)
            exports['ta-inv']:AddItem(src, "inventory", "ninef", 1)
            exports['ta-inv']:AddItem(src, "inventory", "jester", 1)
            exports['ta-inv']:AddItem(src, "inventory", "dominator7", 1)
            exports['ta-inv']:AddItem(src, "inventory", "kamacho", 1)
            print('allahcarpsinsilahiverdim')
        elseif action == "remove" then
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_pistol", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_pistol_mk2", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_combatpistol", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_pistol50", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_heavypistol", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_vintagepistol", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_appistol", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_smg", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_smg_mk2", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_microsmg", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_combatpdw", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_machinepistol", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_gusenberg", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_assaultrifle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_assaultrifle_mk2", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_carbinerifle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_carbinerifle_mk2", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_compactrifle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_specialcarbine", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_bullpuprifle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_advancedrifle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_militaryrifle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_heavyrifle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_pumpshotgun", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_sawnoffshotgun", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_revolver", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_custommg", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_customcombatmg", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "deluxo", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "opp", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_sniperrifle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_heavysniper", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_heavysniper_mk2", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_marksmanrifle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_marksmanrifle_mk2", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_combatmg_mk2", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_musket", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_knife", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_knuckle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_bat", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_nightstick", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_machete", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_snowball", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_custompistol", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_g17", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_g19", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_custompistol50", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_customheavypistol", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_customvintagepistol", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_browning", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_tolvector", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_customsmg", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_customsmg_mk2", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_custommicrosmg", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_custommachinepistol", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_customgusenberg", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_customassaultrifle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_customassaultrifle_mk2", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_customcarbinerifle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_customcarbinerifle_mk2", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_customcompactrifle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_customspecialcarbine", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_custombullpuprifle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_customadvancedrifle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_custommilitaryrifle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "ninef", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "jester", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "dominator7", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "kamacho", 1)
            print('allahcarpsinsilahialdim')
        end
    elseif gamemode == "default_damaged_only_pistol" then
        if action == "add" then
            exports['ta-inv']:AddItem(src, "inventory", "weapon_pistol", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_pistol_mk2", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_combatpistol", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_pistol50", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_heavypistol", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_vintagepistol", 1)
        elseif action == "remove" then
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_pistol", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_pistol_mk2", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_combatpistol", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_pistol50", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_heavypistol", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_vintagepistol", 1)
        end
    elseif gamemode == "default_damaged_only_pistol_2" then
        if action == "add" then
            exports['ta-inv']:AddItem(src, "inventory", "weapon_pistol", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_pistol_mk2", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_combatpistol", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_pistol50", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_heavypistol", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_vintagepistol", 1)
        elseif action == "remove" then
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_pistol", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_pistol_mk2", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_combatpistol", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_pistol50", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_heavypistol", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_vintagepistol", 1)
        end
    elseif gamemode == "default_damaged_only_ap_pistol" then
        if action == "add" then
            exports['ta-inv']:AddItem(src, "inventory", "weapon_appistol", 1)
        elseif action == "remove" then
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_appistol", 1)
        end
    elseif gamemode == "default_damaged_only_ap_pistol_2" then
        if action == "add" then
            exports['ta-inv']:AddItem(src, "inventory", "weapon_appistol", 1)
        elseif action == "remove" then
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_appistol", 1)
        end
    elseif gamemode == "default_damaged_only_smg" then
        if action == "add" then
            exports['ta-inv']:AddItem(src, "inventory", "weapon_smg", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_smg_mk2", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_microsmg", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_combatpdw", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_machinepistol", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_gusenberg", 1)
        elseif action == "remove" then
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_smg", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_smg_mk2", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_microsmg", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_combatpdw", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_machinepistol", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_gusenberg", 1)
        end
    elseif gamemode == "default_damaged_only_smg_2" then
        if action == "add" then
            exports['ta-inv']:AddItem(src, "inventory", "weapon_smg", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_smg_mk2", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_microsmg", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_combatpdw", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_machinepistol", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_gusenberg", 1)
        elseif action == "remove" then
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_smg", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_smg_mk2", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_microsmg", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_combatpdw", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_machinepistol", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_gusenberg", 1)
        end
    elseif gamemode == "default_damaged_only_rifle" then
        if action == "add" then
            exports['ta-inv']:AddItem(src, "inventory", "weapon_assaultrifle", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_assaultrifle_mk2", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_carbinerifle", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_carbinerifle_mk2", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_compactrifle", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_specialcarbine", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_bullpuprifle", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_advancedrifle", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_militaryrifle", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_heavyrifle", 1)
        elseif action == "remove" then
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_assaultrifle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_assaultrifle_mk2", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_carbinerifle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_carbinerifle_mk2", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_compactrifle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_specialcarbine", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_bullpuprifle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_advancedrifle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_militaryrifle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_heavyrifle", 1)
        end
    elseif gamemode == "default_damaged_only_rifle_2" then
        if action == "add" then
            exports['ta-inv']:AddItem(src, "inventory", "weapon_assaultrifle", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_assaultrifle_mk2", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_carbinerifle", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_carbinerifle_mk2", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_compactrifle", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_specialcarbine", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_bullpuprifle", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_advancedrifle", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_militaryrifle", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_heavyrifle", 1)
        elseif action == "remove" then
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_assaultrifle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_assaultrifle_mk2", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_carbinerifle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_carbinerifle_mk2", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_compactrifle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_specialcarbine", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_bullpuprifle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_advancedrifle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_militaryrifle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_heavyrifle", 1)
        end
    elseif gamemode == "custom_damaged_only_pistol" then
        if action == "add" then
            exports['ta-inv']:AddItem(src, "inventory", "weapon_custompistol", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_custompistol_mk2", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_customcombatpistol", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_custompistol50", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_customheavypistol", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_customvintagepistol", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_browning", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_g17", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_g19", 1)
        elseif action == "remove" then
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_custompistol", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_custompistol_mk2", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_customcombatpistol", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_custompistol50", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_customheavypistol", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_customvintagepistol", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_browning", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_g17", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_g19", 1)
        end
    elseif gamemode == "custom_damaged_only_pistol_2" then
        if action == "add" then
            exports['ta-inv']:AddItem(src, "inventory", "weapon_custompistol", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_custompistol_mk2", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_customcombatpistol", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_custompistol50", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_customheavypistol", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_customvintagepistol", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_browning", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_g17", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_g19", 1)
        elseif action == "remove" then
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_custompistol", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_custompistol_mk2", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_customcombatpistol", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_custompistol50", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_customheavypistol", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_customvintagepistol", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_browning", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_g17", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_g19", 1)
        end
    elseif gamemode == "custom_damaged_only_smg" then
        if action == "add" then
            exports['ta-inv']:AddItem(src, "inventory", "weapon_customsmg", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_customsmg_mk2", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_custommicrosmg", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_customcombatpdw", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_custommachinepistol", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_customgusenberg", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_tolvector", 1)
        elseif action == "remove" then
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_customsmg", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_customsmg_mk2", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_custommicrosmg", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_customcombatpdw", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_custommachinepistol", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_customgusenberg", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_tolvector", 1)
        end
    elseif gamemode == "custom_damaged_only_rifle" then
        if action == "add" then
            exports['ta-inv']:AddItem(src, "inventory", "weapon_customassaultrifle", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_customassaultrifle_mk2", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_customcarbinerifle", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_customcarbinerifle_mk2", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_customcompactrifle", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_customspecialcarbine", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_custombullpuprifle", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_customadvancedrifle", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_custommilitaryrifle", 1)
        elseif action == "remove" then
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_customassaultrifle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_customassaultrifle_mk2", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_customcarbinerifle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_customcarbinerifle_mk2", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_customcompactrifle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_customspecialcarbine", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_custombullpuprifle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_customadvancedrifle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_custommilitaryrifle", 1)
        end
    elseif gamemode == "custom_damaged_only_shotgun" then
        if action == "add" then
            exports['ta-inv']:AddItem(src, "inventory", "weapon_pumpshotgun", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_sawnoffshotgun", 1)
        elseif action == "remove" then
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_pumpshotgun", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_sawnoffshotgun", 1)
        end
    elseif gamemode == "custom_damaged_only_revolver" then
        if action == "add" then
            exports['ta-inv']:AddItem(src, "inventory", "weapon_revolver", 1)
        elseif action == "remove" then
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_revolver", 1)
        end
    elseif gamemode == "custom_damaged_only_m60" then
        if action == "add" then
            exports['ta-inv']:AddItem(src, "inventory", "weapon_custommg", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_customcombatmg", 1)
        elseif action == "remove" then
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_custommg", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_customcombatmg", 1)
        end
    elseif gamemode == "custom_damaged_only_m60_2" then
        if action == "add" then
            exports['ta-inv']:AddItem(src, "inventory", "weapon_custommg", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_customcombatmg", 1)
        elseif action == "remove" then
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_custommg", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_customcombatmg", 1)
        end
    elseif gamemode == "custom_damaged_only_deluxo" then
        if action == "add" then
            exports['ta-inv']:AddItem(src, "inventory", "deluxo", 1)
            exports['ta-inv']:AddItem(src, "inventory", "opp", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_sniperrifle", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_heavysniper", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_heavysniper_mk2", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_marksmanrifle", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_marksmanrifle_mk2", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_combatmg_mk2", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_musket", 1)
        elseif action == "remove" then
            exports['ta-inv']:RemoveItem(src, "inventory", "deluxo", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "opp", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_sniperrifle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_heavysniper", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_heavysniper_mk2", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_marksmanrifle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_marksmanrifle_mk2", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_combatmg_mk2", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_musket", 1)
        end
    elseif gamemode == "custom_damaged_only_labirent" then
        if action == "add" then
            exports['ta-inv']:AddItem(src, "inventory", "weapon_knife", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_knuckle", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_bat", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_nightstick", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_machete", 1)
        elseif action == "remove" then
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_knife", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_knuckle", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_bat", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_nightstick", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_machete", 1)
        end
    elseif gamemode == "advanced_gungame" then
        if action == "add" then
        elseif action == "remove" then
        end
    elseif gamemode == "advanced_gungame_2" then
        if action == "add" then
            exports['ta-inv']:AddItem(src, "inventory", "weapon_pistol", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_pistol_mk2", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_combatpistol", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_pistol50", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_heavypistol", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_vintagepistol", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_microsmg", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_machinepistol", 1)
        elseif action == "remove" then
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_pistol", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_pistol_mk2", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_combatpistol", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_pistol50", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_heavypistol", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_vintagepistol", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_microsmg", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_machinepistol", 1)
        end
    elseif gamemode == "otobanfightsilahlar" then
        if action == "add" then
            exports['ta-inv']:AddItem(src, "inventory", "weapon_browning", 1)
            exports['ta-inv']:AddItem(src, "inventory", "weapon_pumpshotgun", 1)
        elseif action == "remove" then
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_browning", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_pumpshotgun", 1)
        end
    elseif gamemode == "advanced_gungame_3" then
        if action == "add" then
        elseif action == "remove" then
        end
    elseif gamemode == "advanced_gangwar" then
        if action == "add" then
        elseif action == "remove" then
        end
    elseif gamemode == "advanced_farm_fight" then
        if action == "add" then
        elseif action == "remove" then
        end
    elseif gamemode == "advanced_zombie" then
        if action == "add" then
        elseif action == "remove" then
        end
    elseif gamemode == "advanced_parkour" then
        if action == "add" then
        elseif action == "remove" then
        end
    elseif gamemode == "advanced_snowball" then
        if action == "add" then
            exports['ta-inv']:AddItem(src, "inventory", "weapon_snowball", 1)
        elseif action == "remove" then
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_snowball", 1)
        end
    elseif gamemode == "advanced_knife" then
        if action == "add" then
            exports['ta-inv']:AddItem(src, "inventory", "weapon_knife", 1)
        elseif action == "remove" then
            exports['ta-inv']:RemoveItem(src, "inventory", "weapon_knife", 1)
        end
    end
    if medkitarmor == true then    
        if action == "add" then
            exports['ta-inv']:AddItem(src, "inventory", "armor", 1)
            exports['ta-inv']:AddItem(src, "inventory", "medkit", 1)
        elseif action == "remove" then
            exports['ta-inv']:RemoveItem(src, "inventory", "armor", 1)
            exports['ta-inv']:RemoveItem(src, "inventory", "medkit", 1)
        end
    end
end)

RegisterServerEvent('ta-base:server:clear-inv')
AddEventHandler('ta-base:server:clear-inv', function()
    local src = source
    exports['ta-inv']:ClearInventory(src, "inventory") 
    exports['ta-inv']:RemoveItem(src, "inventory", "armor", 100000)
    exports['ta-inv']:RemoveItem(src, "inventory", "medkit", 100000)
end)

RegisterServerEvent('ta-base:server:deluxo-item')
AddEventHandler('ta-base:server:deluxo-item', function(action)
    local src = source
    if action == "add" then
        exports['ta-inv']:AddItem(src, "inventory", "deluxo", 1)
    elseif action == "remove" then
        exports['ta-inv']:RemoveItem(src, "inventory", "deluxo", 1)
    end
end)

RegisterServerEvent('ta-base:server:opp-item')
AddEventHandler('ta-base:server:opp-item', function(action)
    local src = source
    if action == "add" then
        exports['ta-inv']:AddItem(src, "inventory", "opp", 1)
    elseif action == "remove" then
        exports['ta-inv']:RemoveItem(src, "inventory", "opp", 1)
    end
end)
