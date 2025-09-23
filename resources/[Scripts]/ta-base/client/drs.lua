isDead = false
streak = 0

function respawnbabusrespawn()
	isDead = false
	TriggerEvent('ta-inv:client:dead', "notdead")
	local PlayerPed = PlayerPedId()
	ClearPedTasks(PlayerPed)
	ClearPedBloodDamage(PlayerPed)
	ClearPedSecondaryTask(PlayerPed)
	ClearPedTasksImmediately(PlayerPed)
	SetEntityInvincible(PlayerPedId(), false)
	SetPlayerInvincible(PlayerPedId(), false)
	Wait(150)
	if not default_damaged_only_pistol and not default_damaged_only_pistol_2 and not default_damaged_only_ap_pistol and not default_damaged_only_ap_pistol_2 and not advanced_knife and not farm_and_fight and not custom_damaged_only_labirent then
        if not priv_lobby_default_damage and not priv_lobby_pistol then
            SetPedArmour(PlayerPedId(), 200)
        end
	end
	SetEntityHealth(PlayerPed, 200)
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if isDead then
			DisableControlAction(0, 140, true)
			DisableControlAction(0, 141, true)
			DisableControlAction(0, 142, true)
			DisableControlAction(0, 200, true)
			DisableControlAction(0, 245, true)
			DisableControlAction(0, 288, true)
			DisableControlAction(0, 289, true)
			DisableControlAction(0, 170, true)
			DisableControlAction(0, 166, true)
			DisableControlAction(0, 318, true)
			DisableControlAction(0, 167, true)
			DisableControlAction(0, 168, true)
			DisableControlAction(0, 56, true)
			DisableControlAction(0, 57, true)
			DisableControlAction(0, 344, true)
			DisableControlAction(0, 45, true)
			DisableControlAction(0, 80, true)
			DisableControlAction(0, 263, true)
		else
			Wait(1000)
		end
	end
end)

function OlumsuzlukVre()
	Wait(100)
	SetEntityInvincible(PlayerPedId(), true)
	SetPlayerInvincible(PlayerPedId(), true)
end

function OnPlayerDeath()
	isDead = true
	TriggerEvent('ta-inv:client:dead', "isdead")
	TriggerEvent('ta-inv:client:dead-envkapa')
	if IsPedInAnyVehicle(PlayerPedId()) then 
		ClearPedTasks(PlayerPedId())
		ClearPedBloodDamage(PlayerPedId())
		ClearPedSecondaryTask(PlayerPedId())
		ClearPedTasksImmediately(PlayerPedId())
	end
	while not HasAnimDictLoaded("dead") do RequestAnimDict("dead") Wait(10) end

	local ped = PlayerPedId() local coords = GetEntityCoords(ped)
	Wait(10) 
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z +0.1, 0.0, true, false)
	Wait(50)
	OlumsuzlukVre()
	Wait(100)
	if not IsEntityPlayingAnim(PlayerPedId(), 'dead', 'dead_a', 1) then
		TaskPlayAnim(PlayerPedId(), "dead", 'dead_a', 1.0, 1.0, -1, 1, 0, 0, 0, 0 )
	end
	FreezeEntityPosition(PlayerPedId(), true)
end

AddEventHandler('esx:onPlayerDeath', function(data) Wait(300) OnPlayerDeath() end)

RegisterNetEvent('hopbala123')
AddEventHandler('hopbala123', function()
	respawnbabusrespawn()
	if matchmaking then
		matchmakingolusu = false
	end
end)