RegisterServerEvent("ta-hud:server:addStreak", function(killerId, victimColor)
    TriggerClientEvent("ta-hud:client:addStreak", killerId, victimColor)
    TriggerClientEvent("ta-base:client:regen", killerId)
end)

RegisterServerEvent("ta-hud:server:getStreak", function(victimId, attackerId, gunHash, distance, victimColor)
    local plyCrew = exports["ta-crew"]:checkPlayerIsInAnyCrew(GetPlayerIdentifiers(attackerId)[1])
    local plyCrewColor = nil
    local tgtCrewColor = nil
    local tgtCrew = exports["ta-crew"]:checkPlayerIsInAnyCrew(GetPlayerIdentifiers(victimId)[1])
    if plyCrew then
        plyCrewColor = plyCrew.color
        plyCrew = plyCrew.altname
    end
    if tgtCrew then
        tgtCrewColor = tgtCrew.color
        tgtCrew = tgtCrew.altname
    end
    TriggerClientEvent("ta-hud:client:getStreak", attackerId, {killerCrewColor = plyCrewColor, victimCrewColor = tgtCrewColor, killerCrewName = plyCrew, victimCrewName = tgtCrew, victimColor = victimColor, victimId = victimId, attackerId = attackerId, victimName = GetPlayerName(victimId), killerName = GetPlayerName(attackerId), weapon = gunHash, dist = distance})
end)

RegisterServerEvent("ta-hud:server:addFeed", function(streak, data)
    local players = GetPlayers()
    data.streak = streak

    local bucket = GetPlayerRoutingBucket(data.attackerId)

    for _, player in pairs(players) do
        if bucket == GetPlayerRoutingBucket(player) then
            TriggerClientEvent("ta-hud:client:addFeed", player, data)
        end
    end
end)

RegisterServerEvent("ta-hud:kill_message:server:sync" , function(klrPly, tgtPlyr)
    if tgtPlyr ~= nil and klrPly ~= nil then
        TriggerClientEvent("ta-hud:kill_message:client:sync", klrPly, GetPlayerName(tgtPlyr))
    end
end)

RegisterServerEvent('ta-marker:CreateMarker', function(_, coords, entity, markerType)
	TriggerClientEvent('marker:CreateMarker', -1, _, coords, entity, source, markerType)
end)

function TriggerInSquadMembers(members, _, coords, entity, markerType)
	for _, member in pairs(members) do
		TriggerClientEvent('marker:CreateMarker', member, _, coords, entity, source, markerType)
	end
end