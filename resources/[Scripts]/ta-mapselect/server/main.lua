local votes = {}

RegisterServerEvent("map_selector:server:startSelecting", function(bucketId)
    local src = source
    local players = GetPlayers()

    votes[bucketId] = {}

    for _, map in ipairs(Config.Maps) do
        votes[bucketId][map.name] = {}
    end

    for _, player in ipairs(players) do
        if GetPlayerRoutingBucket(player) == bucketId then
            TriggerClientEvent("map_selector:client:startSelecting", player, bucketId)
        end
    end

    local counter = Config.WaitTime

    while counter > 0 do
        Wait(1000)

        counter = counter - 1
    end

    local selectedMap = nil

    for _, map in ipairs(Config.Maps) do
        if map.bucket == bucketId then
            if not selectedMap then
                selectedMap = map
            elseif #votes[bucketId][map.name] > #votes[bucketId][selectedMap.name] then
                selectedMap = map
            end
        end
    end

    for _, player in ipairs(players) do
        if GetPlayerRoutingBucket(player) == bucketId then
            TriggerClientEvent("map_selector:client:sendPlayers", player, selectedMap)
        end
    end

    votes[bucketId] = nil
end)

RegisterServerEvent("map_selector:server:updateMap", function(bucketId, mapName)
    local src = source
    local players = GetPlayers()

    local vote = nil

    for k, v in pairs(votes[bucketId]) do
        for i, p in ipairs(v) do
            if p == src then
                vote = {
                    id = i,
                    mapName = k,
                }

                break
            end
        end
    end

    if vote then
        if vote.mapName == mapName then
            return
        else

            table.remove(votes[bucketId][vote.mapName], vote.id)

            for _, player in ipairs(players) do
                if GetPlayerRoutingBucket(player) == bucketId then
                    TriggerClientEvent("map_selector:client:updateMap", player, vote.mapName, #votes[bucketId][vote.mapName])
                end
            end
        end
    end

    table.insert(votes[bucketId][mapName], src)

    for _, player in ipairs(players) do
        if GetPlayerRoutingBucket(player) == bucketId then
            TriggerClientEvent("map_selector:client:updateMap", player, mapName, #votes[bucketId][mapName])
        end
    end
end)