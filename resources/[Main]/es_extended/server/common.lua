ESX = {}
ESX.Players = {}
ESX.ServerCallbacks = {}
ESX.TimeoutCount = -1
ESX.CancelledTimeouts = {}
ESX.RegisteredCommands = {}

AddEventHandler('esx:getSharedObject', function(cb)
	cb(ESX)
end)

function getSharedObject()
	return ESX
end

exports("getSharedObject", getSharedObject)

RegisterServerEvent('esx:triggerServerCallback')
AddEventHandler('esx:triggerServerCallback', function(name, requestId, ...)
    local playerId = source
    if Config.CallbackDebug then
        local identifier = GetPlayerIdentifiers(playerId)[1]
        print('[^2es_extended^0] Callback Log: ^1'..name..'^0 Request ID: ^1'..requestId..'^0 Player ID: ^1'..tonumber(playerId)..'^0 Identifier: ^1'..identifier..'^0')
    end

    ESX.TriggerServerCallback(name, requestID, playerId, function(...)
        TriggerClientEvent('esx:serverCallback', playerId, requestId, ...)
    end, ...)
end)
