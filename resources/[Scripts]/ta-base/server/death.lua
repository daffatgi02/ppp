RegisterServerEvent("ta-base:server:addKill", function(killerId)
        exports["oxmysql"]:query_async("UPDATE users SET kills = kills + 1 WHERE identifier = ?", {
            PlayerIdentifier('steam', killerId)
        })
        local identifier = GetPlayerIdentifier(killerId, 0)
        MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
            ["@identifier"] = identifier
        }, function(result)
        killagaa = tonumber(result[1].kills)
        if killagaa < 500 then
            rank = "Bronze I"
        end
        if killagaa >= 500 then
            rank = "Bronze II"
        end
        if killagaa >= 1000 then
            rank = "Bronze III"
        end
        if killagaa >= 2000 then
            rank = "Silver I"
        end
        if killagaa >= 3500 then
            rank = "Silver II"
        end
        if killagaa >= 5000 then
            rank = "Silver III"
        end
        if killagaa >= 7000 then
            rank = "Gold I"
        end
        if killagaa >= 10000 then
            rank = "Gold II"
        end
        if killagaa >= 13000 then
            rank = "Gold III"
        end
        if killagaa >= 15000 then
            rank = "Platinum I"
        end
        if killagaa >= 20000 then
            rank = "Platinum II"
        end
        if killagaa >= 25000 then
            rank = "Platinum III"
        end
        if killagaa >= 35000 then
            rank = "Diamond I"
        end
        if killagaa >= 40000 then
            rank = "Diamond II"
        end
        if killagaa >= 55000 then
            rank = "Diamond III"
        end
        if killagaa >= 70000 then
            rank = "Master"
        end
        if result[1].rank ~= rank then MySQL.Async.execute('UPDATE users SET rank = @rank WHERE identifier = @identifier',{['@identifier'] = identifier, ['@rank'] = rank}) end
        end)

        -- Trigger leaderboard update for farm_and_fight
        TriggerEvent('ta-leaderboard:updateKill', killerId, source)
end)

RegisterServerEvent("ta-base:server:playerDied", function()
    local src = source
        exports["oxmysql"]:query_async("UPDATE users SET death = death + 1 WHERE identifier = ?", {
            PlayerIdentifier('steam', src)
    })
end)

RegisterCommand('resetkda', function(source, args, raw)
    local src = source
    exports["oxmysql"]:query_async("UPDATE users SET death = 0, kills = 0 WHERE identifier = ?", {
        PlayerIdentifier('steam', src)
    })
end)