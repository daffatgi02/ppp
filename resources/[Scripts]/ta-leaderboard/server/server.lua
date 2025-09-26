ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Function to get player identifier
function PlayerIdentifier(type, id)
    local identifiers = {}
    local numIdentifiers = GetNumPlayerIdentifiers(id)

    for a = 0, numIdentifiers do
        table.insert(identifiers, GetPlayerIdentifier(id, a))
    end

    for b = 1, #identifiers do
        if string.find(identifiers[b], type, 1) then
            return identifiers[b]
        end
    end
    return false
end

-- Get leaderboard data from database (Full F6 menu)
ESX.RegisterServerCallback('ta-leaderboard:getLeaderboardData', function(source, cb)
    if Config.EnableDebug then
        print("^3[ta-leaderboard]^7 Getting full leaderboard data for player: " .. source)
    end

    local query = [[
        SELECT
            playername,
            kills,
            death,
            CASE
                WHEN death = 0 THEN kills
                ELSE ROUND(kills / death, 2)
            END as kda,
            rank
        FROM users
        WHERE kills > 0 OR death > 0
        ORDER BY kills DESC, kda DESC
        LIMIT ?
    ]]

    exports.oxmysql:query(query, {Config.TopPlayersLimit}, function(result)
        if Config.EnableDebug then
            print("^3[ta-leaderboard]^7 Full leaderboard query returned " .. (result and #result or 0) .. " results")
        end
        cb(result or {})
    end)
end)

-- Get TOP 3 leaderboard data (Always visible mini leaderboard)
ESX.RegisterServerCallback('ta-leaderboard:getTop3Data', function(source, cb)
    if Config.EnableDebug then
        print("^3[ta-leaderboard]^7 Getting TOP 3 data for player: " .. source)
    end

    local query = [[
        SELECT
            playername,
            kills,
            death,
            CASE
                WHEN death = 0 THEN kills
                ELSE ROUND(kills / death, 2)
            END as kda,
            rank
        FROM users
        WHERE kills > 0 OR death > 0
        ORDER BY kills DESC, kda DESC
        LIMIT ?
    ]]

    exports.oxmysql:query(query, {Config.Top3PlayersLimit}, function(result)
        if Config.EnableDebug then
            print("^3[ta-leaderboard]^7 TOP 3 query returned " .. (result and #result or 0) .. " results")
            if result then
                for i, player in ipairs(result) do
                    print("^3[ta-leaderboard]^7 [" .. i .. "] " .. (player.playername or "NULL") .. " - K:" .. (player.kills or 0) .. " D:" .. (player.death or 0) .. " KDA:" .. (player.kda or 0))
                end
            end
        end
        cb(result or {})
    end)
end)

-- Get current player stats
ESX.RegisterServerCallback('ta-leaderboard:getPlayerStats', function(source, cb)
    local identifier = PlayerIdentifier('steam', source)

    if Config.EnableDebug then
        print("^3[ta-leaderboard]^7 Getting player stats for: " .. tostring(identifier))
    end

    exports.oxmysql:query('SELECT playername, kills, death, rank FROM users WHERE identifier = ?', {identifier}, function(result)
        if result and result[1] then
            local data = result[1]
            data.kda = data.death == 0 and data.kills or math.floor((data.kills / data.death) * 100) / 100
            if Config.EnableDebug then
                print("^3[ta-leaderboard]^7 Player stats: " .. (data.playername or "NULL") .. " - K:" .. (data.kills or 0) .. " D:" .. (data.death or 0) .. " KDA:" .. data.kda)
            end
            cb(data)
        else
            if Config.EnableDebug then
                print("^3[ta-leaderboard]^7 No player stats found for identifier: " .. tostring(identifier))
            end
            cb(nil)
        end
    end)
end)

-- Real-time kill update for farm_and_fight
RegisterNetEvent('ta-leaderboard:updateKill')
AddEventHandler('ta-leaderboard:updateKill', function(killerId, victimId)
    if Config.EnableDebug then
        print("^3[ta-leaderboard]^7 Kill event: Killer=" .. killerId .. ", Victim=" .. victimId)
    end

    -- Broadcast update to all farm_and_fight players (both F6 and TOP3)
    TriggerClientEvent('ta-leaderboard:refreshData', -1)
    TriggerClientEvent('ta-leaderboard:refreshTop3', -1)
end)

-- Debug event for resource start
AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        if Config.EnableDebug then
            print("^2[ta-leaderboard]^7 Resource started successfully!")
            print("^3[ta-leaderboard]^7 Config loaded - Debug: " .. tostring(Config.EnableDebug))
            print("^3[ta-leaderboard]^7 Refresh interval: " .. Config.RefreshInterval .. "ms")
            print("^3[ta-leaderboard]^7 TOP3 limit: " .. Config.Top3PlayersLimit)
            print("^3[ta-leaderboard]^7 Full leaderboard limit: " .. Config.TopPlayersLimit)
        end
    end
end)