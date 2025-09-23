local pInfo = {
    health = 0,
    armour = 0
}

CreateThread(function()
    while true do
        Citizen.Wait(0)
        local player = PlayerPedId()
        pInfo.health = GetEntityHealth(player)
        pInfo.armour = GetPedArmour(player)
    end
end)

AddEventHandler('gameEventTriggered', function(name, data)
    if name == "CEventNetworkEntityDamage" then
        victim = tonumber(data[1])
        attacker = tonumber(data[2])
        victimDied = tonumber(data[6]) == 1 and true or false 
        weaponHash = tonumber(data[7])
        isMeleeDamage = tonumber(data[10]) ~= 0 and true or false 
        vehicleDamageTypeFlag = tonumber(data[11]) 
        local FoundLastDamagedBone, LastDamagedBone = GetPedLastDamageBone(victim)
        local bonehash = -1 
        if FoundLastDamagedBone then
            bonehash = tonumber(LastDamagedBone)
        end
        local PPed = PlayerPedId()
        local distance = IsEntityAPed(attacker) and #(GetEntityCoords(attacker) - GetEntityCoords(victim)) or -1
        local isplayer = IsPedAPlayer(attacker)
        local attackerid = isplayer and GetPlayerServerId(NetworkGetPlayerIndexFromPed(attacker)) or tostring(attacker==-1 and " " or attacker)
        local deadid = isplayer and GetPlayerServerId(NetworkGetPlayerIndexFromPed(victim)) or tostring(victim==-1 and " " or victim)
        local victimName = GetPlayerName(PlayerId())

        if victim == attacker or victim ~= PPed or not IsPedAPlayer(victim) or not IsPedAPlayer(attacker) then return end

        local hit = {
            health = 0,
            armour = 0,
        }

        if pInfo.armour > GetPedArmour(PPed) then
            hit.armour = pInfo.armour - GetPedArmour(PPed)
        else
            hit["armour"] = nil
        end

        if pInfo.health > GetEntityHealth(PPed) then
            hit.health = pInfo.health - GetEntityHealth(PPed)
        else
            hit["health"] = nil
        end
        
        TriggerServerEvent('ssa-base:damage_message:server:hit', attackerid, victim, hit, victimDied, bonehash)
    end

end)

RegisterNetEvent('ssa-base:damage_message:client:hit', function(victim, victimInfo, victimDied, Bone)
    if hitsound then 
        TriggerServerEvent('InteractSound_SV:PlayOnSource', "hitmarker", 0.25)
    end
    if damage then
        if victimInfo.armour then
            OnEntityHealthChange(victim, victimInfo.armour, Bone, {r = 48, g = 152, b = 196}, victimDied)
        end
        if victimInfo.health then
            OnEntityHealthChange(victim, victimInfo.health, Bone,  {r = 212, g = 84, b = 84}, victimDied)
        end
    end
end)

local DrawText2D = function(text, scale, x, y, a, color)
	SetTextScale(0.45, 0.45)
	SetTextFont(2)
	SetTextColour(color.r, color.g, color.b, 255)
	SetTextCentre(true)
    SetTextDropShadow()
    SetTextOutline(1)
    SetTextProportional(1)
	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(x, y)
	ClearDrawOrigin()
end

local DrawText2DTweenUp = function(text, scale, x, y, moveheight, speed, color)
    Citizen.CreateThread(function()
        local height = y
        local total_ = height - (y - moveheight) 
        local total = height - (y - moveheight)
        while height > (y - moveheight) do 
            DrawText2D(text, scale, x, height, math.floor(255* (total/total_)), color)
            height = height - 0.003 * speed
            total = total - 0.003 * speed
            Citizen.Wait(1)
        end 
    end)
end 

OnEntityHealthChange = function(victim, value, bonehash, color, dead)
    local coords =  bonehash and GetPedBoneCoords(victim, bonehash, 0.0, 0.0, 0.0) or GetEntityCoords(victim)
    local camCoords = GetGameplayCamCoords()
    local distance = #(coords - camCoords)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    scale = scale * fov
    if scale < 0.2 then scale = 0.2 end 
    DrawText2DTweenUp(tostring(value), 11, 0.550, 0.453, 0.1, 0.35, color)
    Citizen.Wait(100)
end

