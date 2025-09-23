ESX = nil
message = nil
matchmaking = false

RegisterNetEvent("ta-death:client:matchmaking", function(action)
    if action == "join" then
        matchmaking = true
    elseif action == "left" then
        matchmaking = false
    end
end)

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("ta-vip:dsMessage", function(dsMessage) 
	TriggerServerEvent("ta-vip:set:dsMessage", dsMessage)
end)

alreadydeath = false
deathcam = true

AddEventHandler('gameEventTriggered', function(event, data)
	if event ~= 'CEventNetworkEntityDamage' then return end
	local victim, victimDied = data[1], data[4]
	if not IsPedAPlayer(victim) then return end
	local player = PlayerId()
	local playerPed = PlayerPedId()
	if victimDied and NetworkGetPlayerIndexFromPed(victim) == player and (IsPedDeadOrDying(victim, true) or IsPedFatallyInjured(victim))  then
		local killerEntity, deathCause = GetPedSourceOfDeath(playerPed), GetPedCauseOfDeath(playerPed)
		local killerClientId = NetworkGetPlayerIndexFromPed(killerEntity)
		local boneFound, boneId = GetPedLastDamageBone(playerPed)
		if killerEntity ~= playerPed and killerClientId and NetworkIsPlayerActive(killerClientId) then
			PlayerKilledByPlayer(GetPlayerServerId(killerClientId), GetPlayerServerId(PlayerId()), killerClientId, deathCause, boneFound, boneId)
		end
	end
end)

-- AddEventHandler('gameEventTriggered', function(event, data)
--     if event == "CEventNetworkEntityDamage" then
--         local victim, attacker, victimDied, weapon = data[1], data[2], data[4], data[7]
--         if not IsEntityAPed(victim) then return end
--         if victimDied and NetworkGetPlayerIndexFromPed(victim) == PlayerId() and IsEntityDead(PlayerPedId()) then
--             if not isDead then
--                 if attacker == -1 then
-- 					DoScreenFadeOut(300)
-- 					Citizen.Wait(1500)
-- 					SetEntityVisible(PlayerPedId(victimServerId), false, 0)
-- 					SetLocalPlayerAsGhost(true)
-- 					Wait(500)
-- 					NetworkSetInSpectatorMode(0, PlayerPedId())
-- 					Wait(0)
-- 					TriggerEvent('ta-death:afterdeathscreen')
-- 					Wait(100)
-- 					while not IsScreenFadedOut() do Citizen.Wait(100) end
-- 					Wait(100)
-- 					DoScreenFadeIn(500)
-- 					SetEntityVisible(PlayerPedId(victimServerId), true, 0)
-- 					SetLocalPlayerAsGhost(false)
-- 					FreezeEntityPosition(PlayerPedId(), false)
--                 end
--             end
--         end
--     end
-- end)

CreateThread(function() while true do ExecuteThread() Wait(0) end end)

function ExecuteThread()
	local myPed = PlayerPedId() 
	if IsEntityDead(myPed) then
		local killerPed = GetPedSourceOfDeath(myPed)
		if IsEntityAPed(killerPed) and IsPedAPlayer(killerPed) and not alreadydeath then
			alreadydeath = true
			cancek = GetEntityHealth(killerPed) / 2
			armorcek = GetPedArmour(killerPed) 
			local player = NetworkGetPlayerIndexFromPed(killerPed)
			local sourceKiller = GetPlayerServerId(player)
			if deathcam and matchmaking == false then
				ESX.TriggerServerCallback('ta-death:server:getKillerIInfo', function(name, avatar, msg)
					SendNUIMessage({type = "death", plyName = name, plyAvatar = avatar, health = cancek, armor = armorcek, screentime = Config.ScreenTime, message = msg})
				end, sourceKiller)
			end
		end
	end

	if not IsEntityDead(myPed) then
		alreadydeath = false
	end
end

function PlayerKilledByPlayer(killerServerId, victimServerId, killerClientId, deathCause, boneFound, boneId)
	local victimCoords = GetEntityCoords(PlayerPedId())
	local killerCoords = GetEntityCoords(GetPlayerPed(killerClientId))
	local distance = #(victimCoords - killerCoords)
	local data = {
		victimCoords = {x = Round(victimCoords.x, 1), y = Round(victimCoords.y, 1), z = Round(victimCoords.z, 1)},
		killerCoords = {x = Round(killerCoords.x, 1), y = Round(killerCoords.y, 1), z = Round(killerCoords.z, 1)},

		message = message,

		killedByPlayer = true,
		deathCause = deathCause,
		distance = Round(distance, 1),

		killerServerId = killerServerId,
		killerClientId = killerClientId,

		killerPed = PlayerPedId(killerServerId),
		victimPed = GetPlayerPed(killerClientId),


		victimServer = tonumber(victimServerId)
	}

	if killerServerId ~= nil then
		if deathcam then
			if matchmaking == false then
				Citizen.Wait(900)
				DoScreenFadeOut(300)
				SetEntityVisible(PlayerPedId(victimServerId), false, 0)
				SetLocalPlayerAsGhost(true)
				ESX.TriggerServerCallback('ta-death:server:getKillerCoords', function(coord)
					if coord ~= nil then
						Citizen.Wait(500)
						DoScreenFadeIn(300)
						NetworkSetInSpectatorMode(1, GetPlayerPed(GetPlayerFromServerId(killerServerId)))
					end
				end, killerServerId)
				Wait(Config.ScreenTime)
				DoScreenFadeOut(300)
				Wait(500)
				NetworkSetInSpectatorMode(0, PlayerPedId())
				DoScreenFadeIn(300)
				Wait(0)
				TriggerEvent('ta-death:afterdeathscreen')
				TriggerEvent('hopbala123')
				SetEntityInvincible(PlayerPedId(), false)
				SetPlayerInvincible(PlayerPedId(), false)
				DoScreenFadeOut(500)
				Wait(500)
				while not IsScreenFadedOut() do Citizen.Wait(100) end
				Wait(500)
				DoScreenFadeIn(500)
				SetEntityVisible(PlayerPedId(victimServerId), true, 0)
				SetLocalPlayerAsGhost(false)
				FreezeEntityPosition(PlayerPedId(), false)
			elseif matchmaking == true then
				SetLocalPlayerAsGhost(true)
			end
		else
			Citizen.Wait(500)
			SetEntityVisible(PlayerPedId(victimServerId), false, 0)
			SetLocalPlayerAsGhost(true)
			Wait(500)
			NetworkSetInSpectatorMode(0, PlayerPedId())
			Wait(0)
			TriggerEvent('ta-death:afterdeathscreen')
			TriggerEvent('hopbala123')
			SetEntityInvincible(PlayerPedId(), false)
			SetPlayerInvincible(PlayerPedId(), false)
			DoScreenFadeOut(500)
			Wait(100)
			while not IsScreenFadedOut() do Citizen.Wait(100) end
			Wait(100)
			DoScreenFadeIn(500)
			SetEntityVisible(PlayerPedId(victimServerId), true, 0)
			SetLocalPlayerAsGhost(false)
			FreezeEntityPosition(PlayerPedId(), false)
		end
	end
end

RegisterNetEvent("ta-death:status", function(status)
    deathcam = true
end)