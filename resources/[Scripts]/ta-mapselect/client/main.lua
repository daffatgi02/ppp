bucketId = nil

-- START --
RegisterNetEvent("map_selector:client:startSelecting", function(bucketIdd)
    bucketId = bucketIdd
    StartSelection()
    SetNuiFocus(1, 1)
end)

function StartSelection()
    SendNUIMessage({
        action = "startSelection",
        bucket = bucketId
    })
end

RegisterNuiCallback('loaded', function(_, cb)
    cb(Config)
end)

-- UPDATE --
RegisterNuiCallback("mapSelected", function(mapName)
    TriggerServerEvent("map_selector:server:updateMap", bucketId, mapName)
end)

RegisterNetEvent("map_selector:client:updateMap", function(mapName, mapCount)
    SendNUIMessage({
        action = "updateMap",
        mapName = mapName,
        mapCount = mapCount
    })
end)

-- SEND PLAYERS --
RegisterNetEvent("map_selector:client:sendPlayers", function(map)
    SetNuiFocus(false, false)
    TriggerServerEvent('ta-base:gungame:server:new-game', map.name)
end)

RegisterCommand("startSelection", function(src, args)
    TriggerServerEvent("map_selector:server:startSelecting", 2019)
end)