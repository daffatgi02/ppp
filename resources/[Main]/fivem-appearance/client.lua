local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local hasAlreadyEnteredMarker = false
local firstConnect = false
local allMyOutfits = {}

if not ESX then
	Citizen.CreateThread(function()
		while ESX == nil do
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
			Wait(0)
		end
	end)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerLoaded = true
end)

RegisterNetEvent('fivem-appearance:clothingMenu', function()
	local config = {
		ped = true,
		headBlend = false,
		faceFeatures = false,
		headOverlays = false,
		components = true,
		props = true
	}
	
	exports['fivem-appearance']:startPlayerCustomization(function (appearance)
		if (appearance) then
			TriggerServerEvent('fivem-appearance:save', appearance)
		end
	end, config)
end)

RegisterNetEvent('fivem-appearance:setOutfit')
AddEventHandler('fivem-appearance:setOutfit', function(pedModel, pedComponents, pedProps)
	local playerPed = PlayerPedId()
	local currentPedModel = exports['fivem-appearance']:getPedModel(playerPed)
	if currentPedModel ~= pedModel then
    	exports['fivem-appearance']:setPlayerModel(pedModel)
		Wait(500)
		playerPed = PlayerPedId()
		exports['fivem-appearance']:setPedComponents(playerPed, pedComponents)
		exports['fivem-appearance']:setPedProps(playerPed, pedProps)
		local appearance = exports['fivem-appearance']:getPedAppearance(playerPed)
		TriggerServerEvent('fivem-appearance:save', appearance)
	else
		exports['fivem-appearance']:setPedComponents(playerPed, pedComponents)
		exports['fivem-appearance']:setPedProps(playerPed, pedProps)
		local appearance = exports['fivem-appearance']:getPedAppearance(playerPed)
		TriggerServerEvent('fivem-appearance:save', appearance)
	end
end)

RegisterNetEvent('fivem-appearance:saveOutfit', function()
	local keyboard = exports["nh-keyboard"]:KeyboardInput({
		header = "Name Outfit", 
		rows = {
			{
				id = 0, 
				txt = ""
			}
		}
	})
	if keyboard ~= nil then
		local playerPed = PlayerPedId()
		local pedModel = exports['fivem-appearance']:getPedModel(playerPed)
		local pedComponents = exports['fivem-appearance']:getPedComponents(playerPed)
		local pedProps = exports['fivem-appearance']:getPedProps(playerPed)
		Wait(500)
		TriggerServerEvent('fivem-appearance:saveOutfit', keyboard[1].input, pedModel, pedComponents, pedProps)
	end
end)

RegisterNetEvent('fivem-appearance:deleteOutfit')
AddEventHandler('fivem-appearance:deleteOutfit', function(id)
	TriggerServerEvent('fivem-appearance:deleteOutfit', id)
end)

-- Add compatibility with skinchanger and esx_skin TriggerEvents
RegisterNetEvent('skinchanger:loadSkin')
AddEventHandler('skinchanger:loadSkin', function(skin, cb)
	if not skin.model then skin.model = 'mp_m_freemode_01' end
	exports['fivem-appearance']:setPlayerAppearance(skin)
	if cb ~= nil then
		cb()
	end
end)

RegisterNetEvent('esx_skin:openSaveableMenu')
AddEventHandler('esx_skin:openSaveableMenu', function(submitCb, cancelCb)
	local config = {ped = true, headBlend = true, faceFeatures = true, headOverlays = true, components = true, props = true}
    ClearPedTasksImmediately(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
	exports['fivem-appearance']:startPlayerCustomization(function (appearance)
		if (appearance) then
			TriggerServerEvent('fivem-appearance:save', appearance)
			SetPedArmour(PlayerPedId(), 200)
			SetEntityHealth(PlayerPedId(), 199)
			TriggerEvent('ta-base:client:joingame')
			if submitCb() ~= nil then submitCb() end
		elseif cancelCb ~= nil then
			cancelCb()
		else
			SetPedArmour(PlayerPedId(), 200)
			SetEntityHealth(PlayerPedId(), 199)
			TriggerEvent('ta-base:client:joingame')
		end
	end, config)
end)

RegisterNetEvent('esx_skin:ustaananisikm')
AddEventHandler('esx_skin:ustaananisikm', function(submitCb, cancelCb)
	firstConnect = true
	SetEntityCoords(PlayerPedId(), 105.138, -1940.3, 19.8036) 
	SetEntityHeading(PlayerPedId(), 50.23)
	local config = {ped = true, headBlend = true, faceFeatures = true, headOverlays = true, components = true, props = true}
    ClearPedTasksImmediately(PlayerPedId())  
    ClearPedTasks(PlayerPedId()) ClearPedSecondaryTask(PlayerPedId()) ClearPedTasksImmediately(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
	exports['fivem-appearance']:startPlayerCustomization(function (appearance)
		if (appearance) then
			FreezeEntityPosition(PlayerPedId(), true)
			DoScreenFadeOut(500) Wait(1000)
			TriggerServerEvent('fivem-appearance:save', appearance)
			SetPedArmour(PlayerPedId(), 200)
			SetEntityHealth(PlayerPedId(), 199)
			TriggerEvent('ta-base:client:joingame')
			Wait(500)
			while not IsScreenFadedOut() do Citizen.Wait(100) end
			Wait(500) DoScreenFadeIn(1500)
			if submitCb ~= nil then submitCb() end
		elseif cancelCb ~= nil then
			cancelCb()
		else
			FreezeEntityPosition(PlayerPedId(), true)
			DoScreenFadeOut(500) Wait(1000)
			SetPedArmour(PlayerPedId(), 200)
			SetEntityHealth(PlayerPedId(), 199)
			TriggerEvent('ta-base:client:joingame')
			Wait(500)
			while not IsScreenFadedOut() do Citizen.Wait(100) end
			Wait(500) DoScreenFadeIn(1500)
			if cancelCb ~= nil then cancelCb() end
		end
	end, config)
end)

function changeGender(model)
	local mhash = GetHashKey(model)
	while not HasModelLoaded(mhash) do
		RequestModel(mhash)
		Wait(1)
	end

	if HasModelLoaded(mhash) then
		SetPlayerModel(PlayerId(),mhash)
		SetEntityHealth(PlayerPedId(), 199)
		SetEntityHealth(PlayerPedId(), 199)
		SetPedDefaultComponentVariation(PlayerPedId())
		SetModelAsNoLongerNeeded(mhash)
	end
end

RegisterNetEvent('fivem-appearance:first:loadchar')
AddEventHandler('fivem-appearance:first:loadchar', function()
	local plyPed = PlayerPedId()
	local currentPedModel = exports['fivem-appearance']:getPedModel(plyPed)
	exports['fivem-appearance']:setPlayerModel(currentPedModel)

	ESX.TriggerServerCallback('fivem-appearance:getPlayerSkin', function(appearance)
		if appearance then
			exports['fivem-appearance']:setPlayerAppearance(appearance)
		end
	end)
end)