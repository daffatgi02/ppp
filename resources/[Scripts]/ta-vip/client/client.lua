ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent("ta-vip:openUi", function()
    ESX.TriggerServerCallback("ta-vip:getPlayerIsVip", function(cb)
        SetNuiFocus(1, 1)
        SendNUIMessage({
            action = "open",
            vip = cb
        }) 
    end)
end)

RegisterNuiCallback("close", function()
    SetNuiFocus(0, 0)
    TriggerEvent('ta-base:client:joingame')
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    TriggerServerEvent("ta-vip:setPlayerSettings")
end)

RegisterNuiCallback("setNickColor", function(data) 
    TriggerServerEvent("ta-vip:setNickColor", data)
end)

RegisterNuiCallback("setDeathMessage", function(data) 
    TriggerServerEvent("ta-vip:setDeathMessage", data)
end)

RegisterNuiCallback("setMainScreen", function(data) 
    TriggerServerEvent("ta-vip:setMainScreen", data)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    TriggerServerEvent("ta-vip:setPlayerSettings")
end)