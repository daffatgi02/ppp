ESX = nil

if Config.NewEsx then
	ESX = exports['es_extended']:getSharedObject()
else
	Citizen.CreateThread(function()
		while ESX == nil do
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
			Citizen.Wait(0)
		end
	end)
end

local insquad = false
local mysquad = {}
local playerstats = {}
local blips = {}
local playertags = {}
local nuiload = false
local nuidataload = false
local update = false
local free_lobby = false

RegisterNetEvent('ta-squad:client:free-lobby')
AddEventHandler('ta-squad:client:free-lobby', function(action)
	if action == "active" then
		free_lobby = true
	elseif action == "deactive" then
		free_lobby = false
	end
end)

-----------------------------------------------------------------------------------------
-- EVENT'S --
-----------------------------------------------------------------------------------------

RegisterNetEvent('esx:playerLoaded', function()
	TriggerServerEvent('wais:playerloaded:squad')
	Timer()
end)

RegisterNetEvent('wais:try:loadp', function()
	TriggerServerEvent('wais:playerloaded:squad')
end)

AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() == resourceName) then
		TriggerServerEvent('wais:playerloaded:squad')
		Timer()
	end
end)

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() == resourceName) then
		RemoveTagAndBlips(true, true)
	end
end)

RegisterNetEvent('wais:send:hex', function(identifier)
	CreateThread(function()
		while true do
			if nuiload then
				SendNUIMessage({
					type = "LOAD_HEX",
					hex  = identifier
				})
				break
			end
			Wait(1)
		end
	end)
end)

RegisterNetEvent('wais:firstload:rooms', function(object)
	CreateThread(function()
		while true do
			if nuiload then
				SendNUIMessage({
					type = "FIRST_LOAD_ROOMS",
					object = object
				})
				break
			end
			Wait(1)
		end
	end)
end)

RegisterNetEvent('wais:load:rooms', function(object)
	SendNUIMessage({
		type = "LOAD_ROOMS",
		object = object
	})
end)

RegisterNetEvent('wais:addNewSquad', function(object)
	SendNUIMessage({
		type  = "ADDLIST_NEWSQUAD",
		object = object
	})
end)

RegisterNetEvent('wais:build:squad', function(squad)
	update  = true
	mysquad = squad
	insquad = true
	SendNUIMessage({
		type   = "BUILD_SQUAD",
		object = squad
	})
	noDamage()
	updateBlips(true)
	updateTags(true)
end)

RegisterNetEvent('wais:chanceCountSquad', function(squadprop)
	SendNUIMessage({
		type = "LIST_UPDATE_COUNT",
		object = squadprop
	})
end)

RegisterNetEvent('wais:leave:squad', function()
	mysquad = {}
	playerstats = {}
	insquad = false
	activeDamage()
	RemoveTagAndBlips(true, true)
end)

RegisterNetEvent('wais:deleted:squad', function(id)
	SendNUIMessage({
		type  = "DELETE_SQUAD",
		squad = id
	})
end)

RegisterNetEvent('wais:squad:kicked', function()
	mysquad = {}
	playerstats = {}
	insquad = false
	SendNUIMessage({
		type = "KICKED_SQUAD"
	})
	activeDamage()
	RemoveTagAndBlips(true, true)
end)

RegisterNetEvent('wais:come:invite', function(invitedsquad)
	if exports["ta-base"]:isInFF() then
		SendNUIMessage({
			type    = "COME_INVITE",
			invited = invitedsquad
		})
	end
end)

-----------------------------------------------------------------------------------------
-- NUI CALLBACK'S --
-----------------------------------------------------------------------------------------

RegisterNUICallback('nuiloaded', function()
	nuiload = true
end)

RegisterNUICallback('nuidataloaded', function()
	nuidataload = true
end)

RegisterNUICallback('close', function()
	SetNuiFocus(false, false)
	SendNUIMessage({
		type = "CLOSE_MENU"
	})
end)

RegisterNUICallback('createsquad', function(data, cbj)
	ESX.TriggerServerCallback('wais:createsquad', function(cbs)
		cbj(cbs)
	end, tostring(data.name), data.isprivate)
end)

RegisterNUICallback('leavesquad', function(data, cbj)
	ESX.TriggerServerCallback('wais:leave:squad', function(cbs)
		cbj(cbs)
	end, tostring(data.name))
end)

RegisterNetEvent("ta-base:squad:leave", function()
	if insquad then
		SendNUIMessage({
			type = "LEAVE_SQUAD"
		})
	end
end)

RegisterNUICallback('joinsquad', function(data, cbj)
	ESX.TriggerServerCallback('wais:join:squad', function(cbs)
		cbj(cbs)
	end, tostring(data.name))
end)

RegisterNUICallback('kickplayer', function(data, cbj)
	ESX.TriggerServerCallback('wais:squad:kickp', function(cbs)
		cbj(cbs)
	end, tostring(data.name), tonumber(data.target))
end)

RegisterNUICallback('invite-accept', function(data, cbj)
	ESX.TriggerServerCallback('wais:invite:accept', function(cbs)
		if not cbs then
			ESX.ShowNotification('The operation failed. Squad closed or full.')
		end
		cbj(cbs)
	end, tostring(data.name))
end)

-----------------------------------------------------------------------------------------
-- FUNCTION'S --
-----------------------------------------------------------------------------------------

function sendstat()
	for i = 1, #mysquad.players do
		::try::
		if not mysquad.players then break end
		if mysquad.players[i] == nil then goto try return end
		local player = GetPlayerFromServerId(mysquad.players[i].id)
		local ped    = GetPlayerPed(player)
		if playerstats[mysquad.players[i].hexlast] == nil then
			playerstats[mysquad.players[i].hexlast] = { hp = 0, armour = 0 }
		else
			playerstats[mysquad.players[i].hexlast] = { hp = playerstats[mysquad.players[i].hexlast].hp, armour = playerstats[mysquad.players[i].hexlast].armour }
		end
		local _distance = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(ped))
		if (_distance < 300 and _distance > 1) or GetPlayerServerId(PlayerId()) == mysquad.players[i].id then
			local nowhp  = GetEntityHealth(ped)
			local nowarmour = GetPedArmour(ped)
			local hp = nowhp - 100
			local armour = nowarmour

			playerstats[mysquad.players[i].hexlast].hp = hp
			playerstats[mysquad.players[i].hexlast].armour = armour
		else
			playerstats[mysquad.players[i].hexlast].hp = playerstats[mysquad.players[i].hexlast].hp
			playerstats[mysquad.players[i].hexlast].armour = playerstats[mysquad.players[i].hexlast].armour
		end
	end
	SendNUIMessage({
		type   = "SQUAD_STATS",
		object = playerstats
	})
end

function updateBlips(remove)
	if remove then
		RemoveTagAndBlips(false, true)
	end
	if not mysquad.players then return end
	for i = 1, #mysquad.players do
		::try::
		if not mysquad.players then break end
		if mysquad.players[i] == nil then goto try return end
		local player = GetPlayerFromServerId(mysquad.players[i].id)
		local ped    = GetPlayerPed(player)
		local _distance = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(ped))
		if mysquad.players[i].name == GetPlayerName(PlayerId()) then

		else
			if _distance < 300 and _distance > 1 then
				local blip = AddBlipForEntity(ped)
				SetBlipNameToPlayerName(blip, player)
				SetBlipColour(blip, 2)
				SetBlipCategory(blip, 2)
				SetBlipScale(blip, 0.7)
				blips[mysquad.players[i].hexlast] = blip
			end
		end
	end
end

function updateTags(remove)
	if remove then
		RemoveTagAndBlips(true, false)
		Wait(1000)
	end
	if not mysquad.players then return end
	for i = 1, #mysquad.players do
		if not mysquad.players then break end
		if mysquad.players[i] == nil then return end
		local player = GetPlayerFromServerId(mysquad.players[i].id)
		local ped    = GetPlayerPed(player)
		if mysquad.players[i].name == GetPlayerName(PlayerId()) then
	
		else
			local _distance = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(ped))
			if _distance < 300 and _distance > 1 then
				if playertags[mysquad.players[i].hexlast] == nil then
					local tag = CreateFakeMpGamerTag(ped, mysquad.players[i].name, false, false, "", false)
					SetMpGamerTagVisibility(tag, 2, 1)
					SetMpGamerTagAlpha(tag, 2, 255)
					playertags[mysquad.players[i].hexlast] = tag
				end
			else
				if playertags[mysquad.players[i].hexlast] then
					RemoveMpGamerTag(playertags[mysquad.players[i].hexlast])
					playertags[mysquad.players[i].hexlast] = nil
				end
			end
			Wait(100)
		end
	end
	update = false
end

function RemoveTagAndBlips(dtag, dblips)
	if dtag then
		for k,v in pairs(playertags) do
			RemoveMpGamerTag(v)
		end
		playertags = {}
	end

	if dblips then
		for k, v in pairs(blips) do
			RemoveBlip(v)
		end
		blips = {}
	end
end

function noDamage()
	if insquad then
		local playerPed = PlayerPedId()
		local group = "squad"..mysquad.roomid
		local _, hash = AddRelationshipGroup(group)
		mysquad.roomid = hash
		SetPedRelationshipGroupHash(playerPed, mysquad.roomid)
		SetEntityCanBeDamagedByRelationshipGroup(playerPed, false, mysquad.roomid)
	end
end

function activeDamage()
	local playerPed = PlayerPedId()
	SetPedRelationshipGroupHash(playerPed, "PLAYER")
	SetEntityCanBeDamagedByRelationshipGroup(playerPed, true, "PLAYER")
end

function Timer()
	SetTimeout(1 * 60 * 1000, function()
		SendNUIMessage({
			type = "DELETE_INVITES"
		})
	end)
end

-----------------------------------------------------------------------------------------
-- COMMAND'S --
-----------------------------------------------------------------------------------------

RegisterKeyMapping('squad', 'Open Squad Menu', 'keyboard', Config.MenuOpenKey)
RegisterCommand('squad', function()
	if not IsPauseMenuActive() and exports["ta-base"]:isInFF() then
		if nuiload and nuidataload then
			SetNuiFocus(true, true)
			SendNUIMessage({
				type = "OPEN_MENU"
			})
		end
	end
end)

-----------------------------------------------------------------------------------------
-- THREAD'S --
-----------------------------------------------------------------------------------------

CreateThread(function()
	while true do
		local sleep = 2000
		if insquad then
			sleep = 500
			sendstat()
			if IsPauseMenuActive() then
				RemoveTagAndBlips(true, false)
			end
		end
		Wait(sleep)
	end
end)

CreateThread(function()
	while true do
		local sleep = 3 * 1000
		if insquad then
			updateBlips(true)
			if not update then
				updateTags(false)
			end
		end
		Wait(sleep)
	end
end)
