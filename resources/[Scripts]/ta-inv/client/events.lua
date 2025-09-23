ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(10)
	end
	while ESX.GetPlayerData().name == nil do
		Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

inv_default = false
dead = false
car_deluxo = nil
car_opp = nil
free_lobby_car = nil
arac_cooldown = false

RegisterNetEvent("ta-inv:OpenInventory", function(data)
    data.bool = true
    if not dead then
        if inv_default == true then
            Display(data)
            DisplayRadar(false)
            TriggerEvent("ta-hud:main-hud", false)
            TriggerEvent('ta-basics:general-hud', "fake-hide")
            TriggerEvent('ta-crosshairs:action', "fake-hide")
            TriggerEvent('ta-base:gungame-hud', "hide")
        else
            Wait(100)
        end
    end
end)

RegisterNetEvent("ta-inv:client:inv_default", function(action)
    if action == "join" then
        inv_default = true
    elseif action == "left" then
        inv_default = false
    end
end)

RegisterNetEvent("ta-inv:client:dead", function(action)
    if action == "isdead" then
        dead = true
    elseif action == "notdead" then
        dead = false
    end
end)

RegisterNetEvent("ta-inv:client:dead-envkapa", function()
    Display({
        bool = false
    })
    DisplayRadar(true)
    TriggerEvent("ta-hud:main-hud", true)
    TriggerEvent('ta-basics:general-hud', "fake-show")
    TriggerEvent('ta-crosshairs:action', "fake-show")
    TriggerEvent('ta-base:gungame-hud', "show")
end)

RegisterCommand('envanterfix', function()
    Display({
        bool = false
    })
    DisplayRadar(true)
    TriggerEvent("ta-hud:main-hud", true)
    TriggerEvent('ta-basics:general-hud', "fake-show")
    TriggerEvent('ta-crosshairs:action', "fake-show")
    TriggerEvent('ta-base:gungame-hud', "show")

end)

RegisterNetEvent("ta-inv:client:kapaaaaa", function()
    Display({
        bool = false
    })
end)

RegisterNUICallback("ItemDrag", function(data)
    TriggerServerEvent("ta-inv:ItemDrag", data)
end)

RegisterNUICallback("SetHotbar", function(data)
    TriggerServerEvent("ta-inv:UpdateHotbar", data, deluxoArena)
end)

RegisterNUICallback("Close", function(data)
    Display({
        bool = false
    })
    DisplayRadar(true)
    TriggerEvent("ta-hud:main-hud", true)
    TriggerEvent('ta-basics:general-hud', "fake-show")
    TriggerEvent('ta-crosshairs:action', "fake-show")
    TriggerEvent('ta-base:gungame-hud', "show")
end)

RegisterNUICallback("RemoveItem", function(data)
    TriggerServerEvent("ta-inv:RemoveItem", data)
end)

RegisterNetEvent("ta-inv:UpdateInventory", function(value, inventoryType, index, key, refresh)
    if inventoryType then
        if index then
            if key then
                PlayerItems[inventoryType][index][key] = value
            else
                if value == nil then
                    table.remove(PlayerItems[inventoryType], index)
                else
                    PlayerItems[inventoryType][index] = value
                end
            end
        else
            PlayerItems[inventoryType] = value
        end
    else
        PlayerItems = value
    end
    if isOpened and refresh then
        UpdateInventory(openedInventoryType)
    end
end)

RegisterNetEvent("ta-inv:SetHotbar", function(value, key, index)
    if key then
        if not index then
            HotbarData[key] = value
        else
            HotbarData[key][index] = value
        end
    else
        HotbarData = value
    end
    for k,v in pairs(HotbarData) do
        if v and v.name and v.hasItem then
            v.image = Items[v.name].image
            v.label = Items[v.name].label
            v.rarity = Items[v.name].rarity
        end
    end
    SetHotbar()
end)

RegisterNetEvent("ta-inv:client:OnItemUsed", function(itemName, info)
    if Items[itemName].type == "weapon" then
        UseWeapon(itemName, info)
    elseif Items[itemName].type == "vehicle" then
        TriggerEvent('t11_vehicle:Spawn', itemName)
    elseif Items[itemName].type == "armor" then
        UseArmor()
    elseif Items[itemName].type == "medkit" then
        UseMedkit()
    elseif Items[itemName].type == "deluxo" then
        if not IsPedInAnyVehicle(PlayerPedId()) then
            if car_deluxo ~= nil then
                DeleteVehicle(car_deluxo)
                car_deluxo = nil
                SpawnVehicle_Deluxo("deluxo")
            else
                SpawnVehicle_Deluxo("deluxo")
            end
        end
    elseif Items[itemName].type == "opp" then
        if not IsPedInAnyVehicle(PlayerPedId()) then
            if car_opp ~= nil then
                DeleteVehicle(car_opp)
                car_opp = nil
                SpawnVehicle_OPP("oppressor")
            else
                SpawnVehicle_OPP("oppressor")
            end
        end
    elseif Items[itemName].type == "ff_car" then
        if not IsPedInAnyVehicle(PlayerPedId()) then
            if free_lobby_car ~= nil then
                if arac_cooldown == false then
                    arac_cooldown = true
                    DeleteVehicle(free_lobby_car)
                    free_lobby_car = nil
                    SpawnVehicle_Freelobby(Items[itemName].rarity)
                    AracCooldown()
                end
            else
                if arac_cooldown == false then
                    arac_cooldown = true
                    SpawnVehicle_Freelobby(Items[itemName].rarity)
                    AracCooldown()
                end
            end
        end
    end
end)

function AracCooldown()
    Wait(1500)
    arac_cooldown = false
end

RegisterNetEvent('ta-inv:client:free-lobby-car-delete')
AddEventHandler('ta-inv:client:free-lobby-car-delete', function()
    free_lobby_car = nil
end)

RegisterNetEvent('ta-inv:client:free-lobby-car-delete:death')
AddEventHandler('ta-inv:client:free-lobby-car-delete:death', function()
    if free_lobby_car ~= nil then
        DeleteVehicle(free_lobby_car)
        free_lobby_car = nil
    end
end)

function UseArmor()
    local ped = PlayerPedId()
    TriggerEvent("mythic_progbar:client:progress", {
        name = "Armor",
        duration = 3500,
        label = "Armor...",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "missmic4",
            anim = "michael_tux_fidget",
            flags = 49,
        },
    }, function(status)
        if not status then
            ClearPedTasks(PlayerPedId())
            SetPedArmour(PlayerPedId(), 199)
        else
            ClearPedTasks(PlayerPedId())
        end
    end)
end

function SpawnVehicle_Freelobby(vehicle)
    model2 = vehicle
    ESX.Streaming.RequestModel(model2)
    local kordinat = GetEntityCoords(PlayerPedId())
    free_lobby_car = CreateVehicle(model2, kordinat.x, kordinat.y, kordinat.z, GetEntityHeading(PlayerPedId()), true, false)
    local networkId = NetworkGetNetworkIdFromEntity(free_lobby_car)
    SetVehicleNumberPlateText(free_lobby_car, 'TA')
    SetVehicleRadioEnabled(free_lobby_car, false)
    SetNetworkIdCanMigrate(networkId, true)
    SetVehicleHasBeenOwnedByPlayer(free_lobby_car, true)
    SetModelAsNoLongerNeeded(model2)
    SetVehicleFixed(free_lobby_car)
    SetVehicleEngineHealth(free_lobby_car, 1000.00)
    SetVehiclePetrolTankHealth(free_lobby_car, 1000.00)    
    SetPedIntoVehicle(PlayerPedId(), free_lobby_car, -1)
    RequestCollisionAtCoord(kordinat.x, kordinat.y, kordinat.z)
    Wait(200)
    TaskWarpPedIntoVehicle(PlayerPedId(), free_lobby_car, -1)
	SetVehicleEngineOn(free_lobby_car, true, true)
end

function SpawnVehicle_Deluxo(vehicle)
    model2 = vehicle
    ESX.Streaming.RequestModel(model2)
    local kordinat = GetEntityCoords(PlayerPedId())
    car_deluxo = CreateVehicle(model2, kordinat.x, kordinat.y, kordinat.z, GetEntityHeading(PlayerPedId()), true, false)
    local networkId = NetworkGetNetworkIdFromEntity(car_deluxo)
    SetVehicleNumberPlateText(car_deluxo, 'TA')
    SetVehicleRadioEnabled(car_deluxo, false)
    SetNetworkIdCanMigrate(networkId, true)
    SetVehicleHasBeenOwnedByPlayer(car_deluxo, true)
    SetModelAsNoLongerNeeded(model2)
    SetVehicleFixed(car_deluxo)
    SetVehicleEngineHealth(car_deluxo, 1000.00)
    SetVehiclePetrolTankHealth(car_deluxo, 1000.00)    
    SetPedIntoVehicle(PlayerPedId(), car_deluxo, -1)
    RequestCollisionAtCoord(kordinat.x, kordinat.y, kordinat.z)
    Wait(200)
    TaskWarpPedIntoVehicle(PlayerPedId(), car_deluxo, -1)
	SetVehicleEngineOn(car_deluxo, true, true)
end

function SpawnVehicle_OPP(vehicle)
    model2 = vehicle
    ESX.Streaming.RequestModel(model2)
    local kordinat = GetEntityCoords(PlayerPedId())
    car_opp = CreateVehicle(model2, kordinat.x, kordinat.y, kordinat.z, GetEntityHeading(PlayerPedId()), true, false)
    local networkId = NetworkGetNetworkIdFromEntity(car_opp)
    SetVehicleNumberPlateText(car_opp, 'TA')
    SetVehicleRadioEnabled(car_opp, false)
    SetNetworkIdCanMigrate(networkId, true)
    SetVehicleHasBeenOwnedByPlayer(car_opp, true)
    SetModelAsNoLongerNeeded(model2)
    SetVehicleFixed(car_opp)
    SetVehicleEngineHealth(car_opp, 1000.00)
    SetVehiclePetrolTankHealth(car_opp, 1000.00)    
    SetPedIntoVehicle(PlayerPedId(), car_opp, -1)
    RequestCollisionAtCoord(kordinat.x, kordinat.y, kordinat.z)
    Wait(200)
    TaskWarpPedIntoVehicle(PlayerPedId(), car_opp, -1)
	SetVehicleEngineOn(car_opp, true, true)
end

function UseMedkit()
    local ped = PlayerPedId()
    TriggerEvent("mythic_progbar:client:progress", {
        name = "Medkit",
        duration = 3500,
        label = "Medkit...",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "clothingshirt",
            anim = "try_shirt_neutral_d",
            flags = 49,
        },
    }, function(status)
        if not status then
            ClearPedTasks(PlayerPedId())
            SetEntityHealth(PlayerPedId(), 199)
        else
            ClearPedTasks(PlayerPedId())
        end
    end)
end

RegisterNetEvent("ta-inv:client:RemoveWeapon", function(itemName)
    local ped = PlayerPedId()
    local weaponHash = GetHashKey(itemName)
    RemoveAllPedWeapons(ped)
end)


RegisterNetEvent("ta-inv:SetPlayerInfos", function(data)
    PlayerInfos = data
    SendNUIMessage({
        type = "playerInfo",
        playerInfo = PlayerInfos
    })
end)
