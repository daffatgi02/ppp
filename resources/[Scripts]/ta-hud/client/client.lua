local streak = 0
killfeed = true
killed_message = true
hud = true
hitsound = true
damage = true
color = "ffffff"

RegisterNetEvent("ta-vip:nickColor", function(nickColor) 
    color = nickColor
end)

RegisterNUICallback("uiLoaded", function()
    uiLoaded = true
end)

local function syncWKiller(killerId, victimId)
    TriggerServerEvent("ta-hud:kill_message:server:sync", killerId, victimId)
end

RegisterNetEvent("ta-hud:streak:resetStreak", function()
    streak = 0
    SendNUIMessage({action = "resetStreak"})
end)

CreateThread(function()
    while true do
        Wait(100)
        if hud then
        local ped = PlayerPedId()
        local health = GetEntityHealth(ped)
        local maxHealth = GetPedMaxHealth(ped)

        health = (health - 100) * 100 / (maxHealth - 100)
        local armor = GetPedArmour(ped)
        local isArmed = IsPedArmed(ped, 4)

        if isArmed then
            local weapon = GetSelectedPedWeapon(ped)
            gunHash = Weapons[weapon].name
            fullAmmo = GetAmmoInPedWeapon(ped, weapon)
            _, clipAmmo = GetAmmoInClip(ped, weapon)
            ammoLeft = fullAmmo - clipAmmo
        end

        if health > 100 then health = 100 end
        if health <= 0 then health = 0 end

        SendNUIMessage({
            action = "player",
            health = health,
            armor = armor,
            isArmed = isArmed,
            gunName = gunName,
            clipAmmo = clipAmmo,
            gunHash = gunHash,
            ammoLeft = ammoLeft,
        })
    end
    end
end)

AddEventHandler('gameEventTriggered', function(event, data)
    if event == "CEventNetworkEntityDamage" then
        local victim, attacker, victimDied, weapon = data[1], data[2], data[4], data[7]
        if not IsEntityAPed(victim) then return end
        if victimDied and NetworkGetPlayerIndexFromPed(victim) == PlayerId() and IsEntityDead(PlayerPedId()) then
            if not isDead then
                TriggerEvent("esx:onPlayerDeath", data)
                TriggerServerEvent("esx:onPlayerDeath", data)
                if attacker ~= -1 then 
                    streak = 0
                    SendNUIMessage({action = "resetStreak"})
                    if attacker == PlayerPedId() then return end
                    local killerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(attacker))
                    local victimId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(victim))

                    syncWKiller(killerId, victimId)

                    local weapon = GetSelectedPedWeapon(attacker)
                    gunHash = Weapons[weapon].name
    
                    local distance = #(GetEntityCoords(victim) - GetEntityCoords(attacker))
    
                    TriggerServerEvent("ta-hud:server:addStreak", killerId)
                    TriggerServerEvent("ta-hud:server:getStreak", victimId, killerId, gunHash, math.ceil(distance), color)
                end
            end
        end
    end
end)

RegisterNUICallback("startEditing", function(eType)
    SetNuiFocus(1, 1)
    SendNUIMessage({action = "editing", type = eType})
    DisplayRadar(1)
end)

RegisterNUICallback("saveHud", function()
    TriggerEvent("ta-base:stopEditing")
    SetNuiFocus(0, 0)
    DisplayRadar(0)
end)

RegisterNetEvent("ta-hud:client:addStreak", function()
    streak = streak + 1
    SendNUIMessage({action = "addStreak", streak = streak})
end)

RegisterNetEvent("ta-hud:client:getStreak", function(data)
    local killer = GetPlayerPed(GetPlayerFromServerId(data.attackerId))
    local killed = GetPlayerPed(GetPlayerFromServerId(data.victimId))
    local FoundLastDamagedBone, LastDamagedBone = GetPedLastDamageBone(killed)

    if FoundLastDamagedBone then
        data.bonehash = tonumber(LastDamagedBone)
    end

    data.killerColor = color
    
    if data.bonehash == 31086 then
        data.headshot = true
    else
        data.headshot = false
    end
    
    if IsPedInAnyVehicle(killer) then
        data.driveby = true
    else
        data.driveby = false
    end

    TriggerServerEvent("ta-hud:server:addFeed", streak, data)
end)

RegisterNetEvent("ta-hud:client:addFeed", function(data)
    if killfeed == true then
        SendNUIMessage({action = "addFeed", data = data})
    end 
end)

RegisterNetEvent("ta-hud:kill_message:client:sync", function(name)
    if killed_message == true then
        SendNUIMessage({action = "show_text", playername = name})
        Wait(1500)
        SendNUIMessage({action = "hide_text"})
    end
end)

RegisterNetEvent("ta-hud:main-hud", function(agaporno)
    if agaporno == true then
        if hud == true then
            SendNUIMessage({action = "sehidininami", durum = true})
        else
            SendNUIMessage({action = "sehidininami", durum = false})
        end
    else
        SendNUIMessage({action = "sehidininami", durum = false})
    end
end)

RegisterNetEvent("ta-hud:setting-status", function(settings)
    for setting, status in pairs(settings) do
        if setting == "killfeed" then 
            killfeed = status == "on" and true or false
        elseif setting == "killed_message" then 
            killed_message = status == "on" and true or false
        elseif setting == "hud" then 
            hud = status == "on" and true or false
        elseif setting == "hitsound" then 
            hitsound = status == "on" and true or false
        elseif setting == "damage" then 
            damage = status == "on" and true or false
        end
    end
end)


RegisterNetEvent("ta-hud:reset", function(settings)
    SendNUIMessage({
        action = "reset"
    })
end)

RegisterNetEvent('ta-notification:show')
AddEventHandler('ta-notification:show', function(icon , iconcolor, appname, title, message, time)
	SendNUIMessage({
		action = 'notify',
		icon = icon,
        iconcolor = iconcolor,
		title = title,
		message = message,
		time = time,
		appname = appname
	})
end)

RegisterNUICallback("notify", function(data)
    SendNUIMessage({
		action = 'notify',
		icon = data.icon,
        iconcolor = data.iconcolor,
		title = data.title,
		message = data.message,
		time = data.time,
		appname = data.appname
	})
end)