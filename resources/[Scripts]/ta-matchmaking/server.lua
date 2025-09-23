local Teams = {
    ["TeamDB"] = {},
    ["PlayerDB"] = {}
}

local vehSpawned = false

Citizen.CreateThread(function()
    Citizen.Wait(2000)
    exports.oxmysql:query('SELECT * FROM ta_matchmaking ORDER BY kills DESC', {}, function(result)
        if result then
            toplist = result
        end
    end)
    while true do
        Citizen.Wait(60000*30)
        exports.oxmysql:query('SELECT * FROM ta_matchmaking ORDER BY kills DESC', {}, function(result)
            if result then
                toplist = result
            end
        end)
    end
end)

RegisterServerEvent("ta-matchmaking:getLeaderboard", function()
    TriggerClientEvent("ta-matchmaking:sendLeaderboardInfoToClient", source, Teams["PlayerDB"][source], toplist)
end)

RegisterServerEvent("ta-matchmaking:login")
AddEventHandler("ta-matchmaking:login", function()
    local src = source
    if Teams["PlayerDB"][src] then
        --Already Logged
    else
        if GetPlayerSteamHexID(src) == null then
            DropPlayer(src, "Your Steam not found! Please open your steam!")
        end
        exports.oxmysql:execute('SELECT * FROM ta_matchmaking WHERE identifier = ?', {GetPlayerSteamHexID(src)}, function(result)
            if result[1] then
                Teams["PlayerDB"][src] = {
                    steam = GetPlayerSteamHexID(src),
                    team = "none",
                    name = GetPlayerName(src),
                    kills = result[1].kills,
                    deaths = result[1].deaths,
                    pts = result[1].pts,
                    wins = result[1].wins,
                    loses = result[1].loses,
                    rank = rankdetect(result[1].pts),
                    avatar = result[1].avatar,
                    totalmatches = result[1].totalmatches,
                    matchchunk = 0,
                    serverid = src,
                    invitedteam = "none"
                }
                
                TriggerClientEvent("ta-matchmaking:SendTeamToClient", src, Teams["TeamDB"][src], Teams["PlayerDB"][src])
            else
                exports.oxmysql:execute('INSERT INTO ta_matchmaking (identifier, kills, deaths, pts, wins, loses, rank, totalmatches, name) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)', {GetPlayerSteamHexID(src), 0, 0, 0, 0, 0, "Unranked", 0, GetPlayerName(src)}, function()
                    Teams["PlayerDB"][src] = {
                        steam = GetPlayerSteamHexID(src),
                        team = "none",
                        name = GetPlayerName(src),
                        kills = 0,
                        deaths = 0,
                        pts = 0,
                        avatar = "https://cdn.discordapp.com/attachments/1040606952352399429/1082432262534070412/Baslksz-2.png", -- default avatar
                        wins = 0,
                        loses = 0,
                        rank = rankdetect(0),
                        totalmatches = 0,
                        matchchunk = 0,
                        serverid = src,
                        invitedteam = "none"
                    }
                    
                    TriggerClientEvent("ta-matchmaking:SendTeamToClient", src, Teams["TeamDB"][src], Teams["PlayerDB"][src])
                end)
                
                GetIdentifier(src, "steam:", 7, function(id64)
                    PerformHttpRequest('https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=1928C27704C620AFB30F84CEB126E7D7&steamids=' .. id64, function(errorCode, steamPP, resultHeaders)
                        for k, v in pairs(json.decode(steamPP)) do
                            for k, v in pairs(v.players) do
                                exports.oxmysql:execute('UPDATE ta_matchmaking SET avatar = ? WHERE identifier = ?', {v.avatarfull, GetPlayerSteamHexID(src)})
                                Teams["PlayerDB"][src].avatar = v.avatarfull
                            end
                        end
                    end)
                end)
            end
        end)
    end
end)

function GetPlayerSteamHexID(playerServerID)
    local identifiers = GetPlayerIdentifiers(playerServerID)
    local steamHexID = nil

    for _, identifier in ipairs(identifiers) do
        if string.sub(identifier, 1, string.len("steam:")) == "steam:" then
            steamHexID = identifier
            break
        end
    end

    return steamHexID
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000 * BQVersus.SaveDataSecond)
        for k,v in pairs(Teams["PlayerDB"]) do
            exports.oxmysql:update('UPDATE ta_matchmaking SET kills = ?, deaths = ?, pts = ?, totalmatches = ?, wins = ?, loses = ?, rank = ?, name = ? WHERE identifier = ?', {v.kills, v.deaths, v.pts, v.totalmatches, v.wins, v.loses, v.rank, v.name, v.steam}, function(affectedRows)
                if affectedRows == 1 then
                end
            end)
        end
    end
end)

function GetIdentifier(playerId, identifierType, sSub, cb)
    for k,v in ipairs(GetPlayerIdentifiers(playerId)) do
        if string.match(v, identifierType) then
            identifier = string.sub(v, sSub)
            local len = string.len(identifier)
            local dec = 0
            for i=1,len do
                local val = string.sub(identifier, i, i)
                if val == "a" or val == "A" then val = 10*16^tonumber(len-i)
                elseif val == "b" or val == "B" then val = 11*16^tonumber(len-i)
                elseif val == "c" or val == "C" then val = 12*16^tonumber(len-i)
                elseif val == "d" or val == "D" then val = 13*16^tonumber(len-i)
                elseif val == "e" or val == "E" then val = 14*16^tonumber(len-i)
                elseif val == "f" or val == "F" then val = 15*16^tonumber(len-i)
                else val = tonumber(val)*16^tonumber(len-i)
                end
                dec = dec+math.ceil(val)
            end
            cb(dec)
        end
    end
end

RegisterServerEvent("ta-matchmaking:getPlayerData", function(serverid)
    local src = source
    if Teams["PlayerDB"][tonumber(serverid)] then
        TriggerClientEvent("ta-matchmaking:sendPlayerData", src, Teams["PlayerDB"][tonumber(serverid)])
    end
end)

RegisterServerEvent("ta-matchmaking:CreateTeam")
AddEventHandler("ta-matchmaking:CreateTeam", function(typeofteam)
    local src = source
    if Teams["PlayerDB"][src].team ~= "none" then
        return
    end
    if Teams["TeamDB"][src] then
        --you have team
    else
        Teams["TeamDB"][src] = {
            players = {Teams["PlayerDB"][src]},
            type = typeofteam.."v"..typeofteam,
            ownerid = src,
            ingame = false,
        }
        Teams["PlayerDB"][src].team = src
        TriggerClientEvent("ta-matchmaking:MyTeamPlayers", src, Teams["TeamDB"][src].players)
        TriggerClientEvent("ta-matchmaking:SendTeamToClient", src, Teams["TeamDB"][src], Teams["PlayerDB"][src])
    end
end)

RegisterServerEvent("ta-matchmaking:InvitePlayer")
AddEventHandler("ta-matchmaking:InvitePlayer", function(invitedid)
    local src = source
    if Teams["TeamDB"][src] and Teams["PlayerDB"][invitedid] ~= nil then
        if Teams["TeamDB"][src].ownerid == src then
            if Teams["PlayerDB"][invitedid] == nil then
                TriggerClientEvent("ta-matchmaking:notify", src, BQVersus.Notify.playerinbug)
            end
            if Teams["PlayerDB"][invitedid].team == "none" then
                Teams["PlayerDB"][invitedid].invitedteam = src
                TriggerClientEvent("ta-matchmaking:SendInviteToClient", invitedid, GetPlayerName(src))
                TriggerClientEvent("ta-matchmaking:notify", src, string.format(BQVersus.Notify.sentinvite, GetPlayerName(invitedid), invitedid))
            else
                TriggerClientEvent("ta-matchmaking:notify", src, BQVersus.Notify.hasteam)
            end
        end
    end
end)

RegisterServerEvent("ta-matchmaking:AcceptInvite")
AddEventHandler("ta-matchmaking:AcceptInvite", function()
    local src = source
    if Teams["PlayerDB"][src].invitedteam == "none" then
        --No invitation
        return
    end
    if Teams["PlayerDB"][src] then
        if Teams["PlayerDB"][src].team == "none" then
            if Teams["TeamDB"][Teams["PlayerDB"][src].invitedteam] then
                Teams["PlayerDB"][src].team = Teams["PlayerDB"][src].invitedteam
                Teams["PlayerDB"][src].invitedteam = "none"
                table.insert(Teams["TeamDB"][Teams["PlayerDB"][src].team].players, Teams["PlayerDB"][src])
                TriggerClientEvent("ta-matchmaking:JoinedTeam", src, Teams["TeamDB"][Teams["PlayerDB"][src].team].type)
                for k,v in pairs(Teams["TeamDB"][Teams["PlayerDB"][src].team].players) do
                    TriggerClientEvent("ta-matchmaking:SendTeamToClient", v.serverid, Teams["TeamDB"][Teams["PlayerDB"][src].team], Teams["PlayerDB"][v.serverid])

                    TriggerClientEvent("ta-matchmaking:notify", v.serverid, BQVersus.Notify.joinplayer)
                end
                -- TriggerClientEvent("ta-matchmaking:SendTeamToClient", src, Teams["TeamDB"][Teams["PlayerDB"][src].team], Teams["PlayerDB"][src])
            end
        else
            --You already have a team
        end
    end
end)

RegisterServerEvent("ta-matchmaking:getMyTeam")
AddEventHandler("ta-matchmaking:getMyTeam", function()
    local src = source
    if Teams["PlayerDB"][src].team == "none" then
        --teamnonelakanki
    else
        TriggerClientEvent("ta-matchmaking:SendTeamToClient", src, Teams["TeamDB"][Teams["PlayerDB"][src].team], Teams["PlayerDB"][src])
    end
end)

RegisterServerEvent("ta-matchmaking:kickTeamMember")
AddEventHandler("ta-matchmaking:kickTeamMember", function(kickedid)
    local src = source
    if Teams["TeamDB"][src] then
        if Teams["TeamDB"][src].ownerid == src then
            if Teams["PlayerDB"][kickedid].team == src then
                for k,v in pairs(Teams["TeamDB"][Teams["PlayerDB"][src].team].players) do
                    if v.serverid == kickedid then
                        table.remove(Teams["TeamDB"][Teams["PlayerDB"][src].team].players, k)
                        Teams["PlayerDB"][kickedid].team = "none"
                        TriggerClientEvent("ta-matchmaking:KickedFromTeam", kickedid)
                        
                        TriggerClientEvent("ta-matchmaking:notify", kickedid, BQVersus.Notify.youkickedfromteam)
                        --Successfully kicked from team
                    end
                end
                for k,v in pairs(Teams["TeamDB"][Teams["PlayerDB"][src].team].players) do
                    TriggerClientEvent("ta-matchmaking:SendTeamToClient", v.serverid, Teams["TeamDB"][Teams["PlayerDB"][src].team], Teams["PlayerDB"][v.serverid])
                end
            else
                --Player Has Not Team
            end
        else
            TriggerClientEvent("ta-matchmaking:notify", src, BQVersus.Notify.OnlyCanOwners)
            --Only team owner can do this
        end
    else
        --You don't have a team
    end
end)

RegisterServerEvent("ta-matchmaking:leaveTeam")
AddEventHandler("ta-matchmaking:leaveTeam", function()
    local src = source
    if Teams["TeamDB"][src] then
        --You're team owner, you can't leave team
        return
    end
    removeteamfromqueue(src, BQVersus.Notify.queuefailedplayerleft)

    if Teams["TeamDB"][Teams["PlayerDB"][src].team] then
        local leavedteam = Teams["PlayerDB"][src].team
        for k,v in pairs(Teams["TeamDB"][Teams["PlayerDB"][src].team].players) do
            if v.serverid == src then
                table.remove(Teams["TeamDB"][Teams["PlayerDB"][src].team].players, k)
                Teams["PlayerDB"][src].team = "none"
            end
        end

        for k,v in pairs(Teams["TeamDB"][leavedteam].players) do
            TriggerClientEvent("ta-matchmaking:SendTeamToClient", v.serverid, Teams["TeamDB"][leavedteam], Teams["PlayerDB"][v.serverid])
            
            TriggerClientEvent("ta-matchmaking:notify", v.serverid, string.format(BQVersus.Notify.playerleftyourteam, GetPlayerName(src), src))
        end
    end
end)

RegisterServerEvent("ta-matchmaking:deleteTeam")
AddEventHandler("ta-matchmaking:deleteTeam", function()
    local src = source
    if Teams["TeamDB"][src] then
        for k,v in pairs(Teams["TeamDB"][src].players) do
            Teams["PlayerDB"][v.serverid].team = "none"
            Teams["PlayerDB"][v.serverid].invitedteam = "none"
            TriggerClientEvent("ta-matchmaking:KickedFromTeam", v.serverid)
            TriggerClientEvent("ta-matchmaking:notify", v.serverid, BQVersus.Notify.teamdeletedbyowner)
            -- table.remove(Teams["TeamDB"][src].players, k)
        end
        -- table.remove(Teams["TeamDB"], src)
        Teams["TeamDB"][src] = nil
    end
end)

AddEventHandler('playerDropped', function (reason)
    local src = source

    if Teams["TeamDB"][Teams["PlayerDB"][src].team] then
        if Teams["TeamDB"][Teams["PlayerDB"][src].team].ingame == true then
            Teams["TeamDB"][Teams["PlayerDB"][src].team].ingame = false
            for k,v in pairs(Teams["TeamDB"][Teams["PlayerDB"][src].team].players) do
                Teams["PlayerDB"][v.serverid].loses += 1
                Teams["PlayerDB"][v.serverid].pts -= 10
                Teams["PlayerDB"][v.serverid].rank = rankdetect(Teams["PlayerDB"][v.serverid].pts)


                Teams["PlayerDB"][v.serverid].totalmatches += 1
                TriggerClientEvent("ta-matchmaking:matchend", v.serverid, "Kaybettiniz", string.format(BQVersus.Notify.youdefeatforleftplayer, GetPlayerName(src)))
            end


            Teams["TeamDB"][Teams["TeamDB"][Teams["PlayerDB"][src].team].enemy].ingame = false
            for k,v in pairs(Teams["TeamDB"][Teams["TeamDB"][Teams["PlayerDB"][src].team].enemy].players) do
                Teams["PlayerDB"][v.serverid].wins += 1
                Teams["PlayerDB"][v.serverid].pts += 50
                Teams["PlayerDB"][v.serverid].rank = rankdetect(Teams["PlayerDB"][v.serverid].pts)


                Teams["PlayerDB"][v.serverid].totalmatches += 1


                TriggerClientEvent("ta-matchmaking:matchend", v.serverid, "You Won", string.format(BQVersus.Notify.youwonforleftplayer, GetPlayerName(src)))
            end
        end
    end

    if Teams["TeamDB"][src] then
        removeteamfromqueue(src, BQVersus.Notify.queuefailedplayerleft)
        for k,v in pairs(Teams["TeamDB"][src].players) do
            Teams["PlayerDB"][v.serverid].team = "none"
            Teams["PlayerDB"][v.serverid].invitedteam = "none"
            TriggerClientEvent("ta-matchmaking:KickedFromTeam", v.serverid)
            
            TriggerClientEvent("ta-matchmaking:notify", v.serverid, BQVersus.Notify.teamdeletedbyowner)
            -- table.remove(Teams["TeamDB"][src].players, k)
        end
        -- table.remove(Teams["TeamDB"], src)
        Teams["TeamDB"][src] = nil
        Teams["PlayerDB"][src] = nil
        return
    end

    if Teams["PlayerDB"][src] then
        if Teams["PlayerDB"][src].team ~= "none" then
            if Teams["TeamDB"][Teams["PlayerDB"][src].team] then
                
                removeteamfromqueue(src, BQVersus.Notify.queuefailedplayerleft)
                for k,v in pairs(Teams["TeamDB"][Teams["PlayerDB"][src].team].players) do
                    if v.serverid == src then
                        table.remove(Teams["TeamDB"][Teams["PlayerDB"][src].team].players, k)

                    end
                end

                for k,v in pairs(Teams["TeamDB"][Teams["PlayerDB"][src].team].players) do
                    TriggerClientEvent("ta-matchmaking:notify", v.serverid, BQVersus.Notify.leftplayer)
                    TriggerClientEvent("ta-matchmaking:SendTeamToClient", v.serverid, Teams["TeamDB"][Teams["PlayerDB"][src].team], Teams["PlayerDB"][v.serverid])
                end
            end
        end
    end

    Teams["PlayerDB"][src] = nil
end)

RegisterServerEvent('ta-matchmaking:leaveMatch', function()
    local src = source
    if Teams["TeamDB"][Teams["PlayerDB"][src].team] then
        if Teams["TeamDB"][Teams["PlayerDB"][src].team].ingame == true then
            Teams["TeamDB"][Teams["PlayerDB"][src].team].ingame = false
            for k,v in pairs(Teams["TeamDB"][Teams["PlayerDB"][src].team].players) do
                Teams["PlayerDB"][v.serverid].loses += 1
                Teams["PlayerDB"][v.serverid].pts -= 10
                Teams["PlayerDB"][v.serverid].rank = rankdetect(Teams["PlayerDB"][v.serverid].pts)

                Teams["PlayerDB"][v.serverid].totalmatches += 1
                TriggerClientEvent("ta-matchmaking:matchend", v.serverid, "Kaybettiniz", string.format(BQVersus.Notify.youdefeatforleftplayer, GetPlayerName(src)))
            end

            Teams["TeamDB"][Teams["TeamDB"][Teams["PlayerDB"][src].team].enemy].ingame = false
            for k,v in pairs(Teams["TeamDB"][Teams["TeamDB"][Teams["PlayerDB"][src].team].enemy].players) do
                Teams["PlayerDB"][v.serverid].wins += 1
                Teams["PlayerDB"][v.serverid].pts += 50
                Teams["PlayerDB"][v.serverid].rank = rankdetect(Teams["PlayerDB"][v.serverid].pts)

                Teams["PlayerDB"][v.serverid].totalmatches += 1

                TriggerClientEvent("ta-matchmaking:matchend", v.serverid, "You Won", string.format(BQVersus.Notify.youwonforleftplayer, GetPlayerName(src)))
            end
        end
    end
end)

-- MatchMaking
local MatchMaking = {
    ["1vs1"] = {
        queue = "bos",
        chank = 0
    },
    ["2vs2"] = {
        queue = "bos",
        chank = 0
    },
    ["3vs3"] = {
        queue = "bos",
        chank = 0
    },
    ["4vs4"] = {
        queue = "bos",
        chank = 0
    },
    ["5vs5"] = {
        queue = "bos",
        chank = 0
    },
    ["15vs15"] = {
        queue = "bos",
        chank = 0
    },
}

RegisterServerEvent("removeteamfromqueue", function()
    removeteamfromqueue(source, "ZevkiSikis")
end)

function removeteamfromqueue(src, reason)
    if reason == "ZevkiSikis" then
        if not Teams["TeamDB"][src] then
            TriggerClientEvent("ta-matchmaking:notify", src, BQVersus.Notify.OnlyCanOwners)
            return
        else
            reason = string.format(BQVersus.Notify.matchmakingqueuestoppedbyname, GetPlayerName(src))
        end
    end
    if Teams["PlayerDB"][src].team == "none" then
        return
    end
    if Teams["TeamDB"][Teams["PlayerDB"][src].team] then
        if Teams["TeamDB"][Teams["PlayerDB"][src].team].inqueue == true then
            if MatchMaking["1vs1"].queue == Teams["PlayerDB"][src].team then
                MatchMaking["1vs1"].queue = "bos"
            elseif MatchMaking["2vs2"].queue == Teams["PlayerDB"][src].team then
                MatchMaking["2vs2"].queue = "bos"
            elseif MatchMaking["3vs3"].queue == Teams["PlayerDB"][src].team then
                MatchMaking["3vs3"].queue = "bos"
            elseif MatchMaking["4vs4"].queue == Teams["PlayerDB"][src].team then
                MatchMaking["4vs4"].queue = "bos"
            elseif MatchMaking["5vs5"].queue == Teams["PlayerDB"][src].team then
                MatchMaking["5vs5"].queue = "bos"
            end

            Teams["TeamDB"][Teams["PlayerDB"][src].team].inqueue = false
            for k,v in pairs(Teams["TeamDB"][Teams["PlayerDB"][src].team].players) do
                TriggerClientEvent("ta-matchmaking:leaveFromQueue", v.serverid, reason)
                -- TriggerClientEvent("ta-matchmaking:SendTeamToClient", v.serverid, Teams["TeamDB"][Teams["PlayerDB"][src].team], Teams["PlayerDB"][v.serverid])
            end

            if reason == "matchfound" then
                --Match Found
            elseif reason == "matchnotfound" then
                --Match Not Found
            end
        else
            TriggerClientEvent("ta-matchmaking:leaveFromQueue", src)
        end
    else
        return
    end
end

RegisterServerEvent("ta-matchmaking:matchmakingJoin")
AddEventHandler("ta-matchmaking:matchmakingJoin", function(gtype)
    local src = source
    if Teams["TeamDB"][src] then
        if Teams["TeamDB"][src].inqueue == true then
            --Zaten sıradasın
            return
        end
        if Teams["TeamDB"][src].ingame == true then
            TriggerClientEvent("ta-matchmaking:leaveFromQueue", src, BQVersus.Notify.alreadyingame)
            return
        end
        if gtype == "1vs1" then
            if tablelength(Teams["TeamDB"][src].players) == 1 then
                if MatchMaking["1vs1"].queue == "bos" then
                    MatchMaking["1vs1"].queue = src
                    Teams["TeamDB"][src].inqueue = true
                    BQWebhooks.sendIntoQueue(Teams["TeamDB"][src].players)
                    --Sıraya eklendiniz
                else
                    BQWebhooks.sendMatchInfo(Teams["TeamDB"][MatchMaking["1vs1"].queue].players ,Teams["TeamDB"][src].players)
                    local newmatchchunk = math.random(55555,9999999)
                    local mapid = math.random(1, #BQVersus.Maps["1VS1"])

                    --Configure Chunk
                    Teams["TeamDB"][src].matchchunk = newmatchchunk
                    Teams["TeamDB"][MatchMaking["1vs1"].queue].matchchunk = newmatchchunk



                    --Configure Ingame
                    Teams["TeamDB"][src].ingame = true
                    Teams["TeamDB"][MatchMaking["1vs1"].queue].ingame = true
                    Teams["TeamDB"][MatchMaking["1vs1"].queue].inqueue = false

                    --Configure Enemy
                    Teams["TeamDB"][src].enemy = MatchMaking["1vs1"].queue
                    Teams["TeamDB"][MatchMaking["1vs1"].queue].enemy = src


                    --PlayersLeft
                    Teams["TeamDB"][src].playersleft = 1
                    Teams["TeamDB"][MatchMaking["1vs1"].queue].playersleft = 1
                    Teams["TeamDB"][src].girilenmodsayisi = 1
                    Teams["TeamDB"][MatchMaking["1vs1"].queue].girilenmodsayisi = 1

                    --Rounds Left
                    Teams["TeamDB"][src].winnedrounds = 0
                    Teams["TeamDB"][MatchMaking["1vs1"].queue].winnedrounds = 0

                    --Bring Game Area All Team Members
                    for k,v in pairs(Teams["TeamDB"][src].players) do
                        TriggerClientEvent("ta-matchmaking:joinmatch", v.serverid, mapid, 2, "1VS1")
                    end
                    for k,v in pairs(Teams["TeamDB"][MatchMaking["1vs1"].queue].players) do
                        TriggerClientEvent("ta-matchmaking:joinmatch", v.serverid, mapid, 1, "1VS1")
                    end

                    MatchMaking["1vs1"].queue = "bos"
                end
            else
                TriggerClientEvent("ta-matchmaking:leaveFromQueue", src, BQVersus.Notify.notmatchthenumber)
                --Takımınızın 2 kişi olması gerekiyor.
            end
        elseif gtype == "2vs2" then
            if tablelength(Teams["TeamDB"][src].players) == 2 then
                if MatchMaking["2vs2"].queue == "bos" then
                    MatchMaking["2vs2"].queue = src
                    Teams["TeamDB"][src].inqueue = true
                    BQWebhooks.sendIntoQueue(Teams["TeamDB"][src].players)
                    --Sıraya eklendiniz
                else
                    BQWebhooks.sendMatchInfo(Teams["TeamDB"][MatchMaking["2vs2"].queue].players ,Teams["TeamDB"][src].players)
                    local newmatchchunk = math.random(11111,55555)
                    local mapid = math.random(1, #BQVersus.Maps["2VS2"])

                    --Configure Chunk
                    Teams["TeamDB"][src].matchchunk = newmatchchunk
                    Teams["TeamDB"][MatchMaking["2vs2"].queue].matchchunk = newmatchchunk


                    --Configure Enemy
                    Teams["TeamDB"][src].enemy = MatchMaking["2vs2"].queue
                    Teams["TeamDB"][MatchMaking["2vs2"].queue].enemy = src

                    --Configure Ingame
                    Teams["TeamDB"][src].ingame = true
                    Teams["TeamDB"][MatchMaking["2vs2"].queue].ingame = true
                    Teams["TeamDB"][MatchMaking["2vs2"].queue].inqueue = false

                    --PlayersLeft
                    Teams["TeamDB"][src].playersleft = 2
                    Teams["TeamDB"][MatchMaking["2vs2"].queue].playersleft = 2
                    Teams["TeamDB"][src].girilenmodsayisi = 2
                    Teams["TeamDB"][MatchMaking["2vs2"].queue].girilenmodsayisi = 2

                    --Rounds Left
                    Teams["TeamDB"][src].winnedrounds = 0
                    Teams["TeamDB"][MatchMaking["2vs2"].queue].winnedrounds = 0

                    --Bring Game Area All Team Members
                    for k,v in pairs(Teams["TeamDB"][src].players) do
                        TriggerClientEvent("ta-matchmaking:joinmatch", v.serverid, mapid, 2, "2VS2")
                    end
                    for k,v in pairs(Teams["TeamDB"][MatchMaking["2vs2"].queue].players) do
                        TriggerClientEvent("ta-matchmaking:joinmatch", v.serverid, mapid, 1, "2VS2")
                    end

                    MatchMaking["2vs2"].queue = "bos"
                end
            else
                TriggerClientEvent("ta-matchmaking:leaveFromQueue", src, BQVersus.Notify.notmatchthenumber)
                --Takımınızın 2 kişi olması gerekiyor.
            end
        elseif gtype == "3vs3" then
            if tablelength(Teams["TeamDB"][src].players) == 3 then
                if MatchMaking["3vs3"].queue == "bos" then
                    MatchMaking["3vs3"].queue = src
                    Teams["TeamDB"][src].inqueue = true
                    BQWebhooks.sendIntoQueue(Teams["TeamDB"][src].players)
                    --Sıraya eklendiniz
                else
                    BQWebhooks.sendMatchInfo(Teams["TeamDB"][MatchMaking["3vs3"].queue].players ,Teams["TeamDB"][src].players)
                    local newmatchchunk = math.random(11111,55555)
                    local mapid = math.random(1, #BQVersus.Maps["3VS3"])

                    --Configure Chunk
                    Teams["TeamDB"][src].matchchunk = newmatchchunk
                    Teams["TeamDB"][MatchMaking["3vs3"].queue].matchchunk = newmatchchunk

                    
                    --Configure Enemy
                    Teams["TeamDB"][src].enemy = MatchMaking["3vs3"].queue
                    Teams["TeamDB"][MatchMaking["3vs3"].queue].enemy = src


                    --Configure Ingame
                    Teams["TeamDB"][src].ingame = true
                    Teams["TeamDB"][MatchMaking["3vs3"].queue].ingame = true
                    Teams["TeamDB"][MatchMaking["3vs3"].queue].inqueue = false

                    --PlayersLeft
                    Teams["TeamDB"][src].playersleft = 3
                    Teams["TeamDB"][MatchMaking["3vs3"].queue].playersleft = 3
                    Teams["TeamDB"][src].girilenmodsayisi = 3
                    Teams["TeamDB"][MatchMaking["3vs3"].queue].girilenmodsayisi = 3

                    --Rounds Left
                    Teams["TeamDB"][src].winnedrounds = 0
                    Teams["TeamDB"][MatchMaking["3vs3"].queue].winnedrounds = 0

                    --Bring Game Area All Team Members
                    for k,v in pairs(Teams["TeamDB"][src].players) do
                        TriggerClientEvent("ta-matchmaking:joinmatch", v.serverid, mapid, 2, "3VS3")
                    end
                    for k,v in pairs(Teams["TeamDB"][MatchMaking["3vs3"].queue].players) do
                        TriggerClientEvent("ta-matchmaking:joinmatch", v.serverid, mapid, 1, "3VS3")
                    end

                    MatchMaking["3vs3"].queue = "bos"
                end
            else
                TriggerClientEvent("ta-matchmaking:leaveFromQueue", src, BQVersus.Notify.notmatchthenumber)
            end
        elseif gtype == "4vs4" then
            if tablelength(Teams["TeamDB"][src].players) == 4 then
                if MatchMaking["4vs4"].queue == "bos" then
                    MatchMaking["4vs4"].queue = src
                    Teams["TeamDB"][src].inqueue = true
                    BQWebhooks.sendIntoQueue(Teams["TeamDB"][src].players)
                    --Sıraya eklendiniz
                else
                    BQWebhooks.sendMatchInfo(Teams["TeamDB"][MatchMaking["4vs4"].queue].players ,Teams["TeamDB"][src].players)
                    local newmatchchunk = math.random(11111,55555)
                    local mapid = math.random(1, #BQVersus.Maps["4VS4"])

                    --Configure Chunk
                    Teams["TeamDB"][src].matchchunk = newmatchchunk
                    Teams["TeamDB"][MatchMaking["4vs4"].queue].matchchunk = newmatchchunk


                    --Configure Enemy
                    Teams["TeamDB"][src].enemy = MatchMaking["4vs4"].queue
                    Teams["TeamDB"][MatchMaking["4vs4"].queue].enemy = src

                    --Configure Ingame
                    Teams["TeamDB"][src].ingame = true
                    Teams["TeamDB"][MatchMaking["4vs4"].queue].ingame = true
                    Teams["TeamDB"][MatchMaking["4vs4"].queue].inqueue = false

                    --PlayersLeft
                    Teams["TeamDB"][src].playersleft = 4
                    Teams["TeamDB"][MatchMaking["4vs4"].queue].playersleft = 4
                    Teams["TeamDB"][src].girilenmodsayisi = 4
                    Teams["TeamDB"][MatchMaking["4vs4"].queue].girilenmodsayisi = 4

                    --Rounds Left
                    Teams["TeamDB"][src].winnedrounds = 0
                    Teams["TeamDB"][MatchMaking["4vs4"].queue].winnedrounds = 0

                    --Bring Game Area All Team Members
                    for k,v in pairs(Teams["TeamDB"][src].players) do
                        TriggerClientEvent("ta-matchmaking:joinmatch", v.serverid, mapid, 2, "4VS4")
                    end
                    for k,v in pairs(Teams["TeamDB"][MatchMaking["4vs4"].queue].players) do
                        TriggerClientEvent("ta-matchmaking:joinmatch", v.serverid, mapid, 1, "4VS4")
                    end

                    MatchMaking["4vs4"].queue = "bos"
                end
            else
                TriggerClientEvent("ta-matchmaking:leaveFromQueue", src, BQVersus.Notify.notmatchthenumber)
            end
        elseif gtype == "5vs5" then
            if tablelength(Teams["TeamDB"][src].players) == 5 then
                if MatchMaking["5vs5"].queue == "bos" then
                    MatchMaking["5vs5"].queue = src
                    Teams["TeamDB"][src].inqueue = true
                    BQWebhooks.sendIntoQueue(Teams["TeamDB"][src].players)
                    --Sıraya eklendiniz
                else
                    BQWebhooks.sendMatchInfo(Teams["TeamDB"][MatchMaking["5vs5"].queue].players ,Teams["TeamDB"][src].players)
                    local newmatchchunk = math.random(11111,55555)
                    local mapid = math.random(1, #BQVersus.Maps["5VS5"])

                    --Configure Chunk
                    Teams["TeamDB"][src].matchchunk = newmatchchunk
                    Teams["TeamDB"][MatchMaking["5vs5"].queue].matchchunk = newmatchchunk


                    --Configure Enemy
                    Teams["TeamDB"][src].enemy = MatchMaking["5vs5"].queue
                    Teams["TeamDB"][MatchMaking["5vs5"].queue].enemy = src

                    --Configure Ingame
                    Teams["TeamDB"][src].ingame = true
                    Teams["TeamDB"][MatchMaking["5vs5"].queue].ingame = true
                    Teams["TeamDB"][MatchMaking["5vs5"].queue].inqueue = false

                    --PlayersLeft
                    Teams["TeamDB"][src].playersleft = 5
                    Teams["TeamDB"][MatchMaking["5vs5"].queue].playersleft = 5
                    Teams["TeamDB"][src].girilenmodsayisi = 5
                    Teams["TeamDB"][MatchMaking["5vs5"].queue].girilenmodsayisi = 5

                    --Rounds Left
                    Teams["TeamDB"][src].winnedrounds = 0
                    Teams["TeamDB"][MatchMaking["5vs5"].queue].winnedrounds = 0

                    --Bring Game Area All Team Members
                    for k,v in pairs(Teams["TeamDB"][src].players) do
                        TriggerClientEvent("ta-matchmaking:joinmatch", v.serverid, mapid, 2, "5VS5")
                    end
                    for k,v in pairs(Teams["TeamDB"][MatchMaking["5vs5"].queue].players) do
                        TriggerClientEvent("ta-matchmaking:joinmatch", v.serverid, mapid, 1, "5VS5")
                    end

                    MatchMaking["5vs5"].queue = "bos"
                end
            end
        elseif gtype == "15vs15" then
            if tablelength(Teams["TeamDB"][src].players) == 1 then
                if MatchMaking["15vs15"].queue == "bos" then
                    MatchMaking["15vs15"].queue = src
                    Teams["TeamDB"][src].inqueue = true
                    BQWebhooks.sendIntoQueue(Teams["TeamDB"][src].players)
                    --Sıraya eklendiniz
                else
                    BQWebhooks.sendMatchInfo(Teams["TeamDB"][MatchMaking["15vs15"].queue].players ,Teams["TeamDB"][src].players)
                    local newmatchchunk = math.random(11111,55555)
                    local mapid = math.random(1, #BQVersus.Maps["15VS15"])

                    --Configure Chunk
                    Teams["TeamDB"][src].matchchunk = newmatchchunk
                    Teams["TeamDB"][MatchMaking["15vs15"].queue].matchchunk = newmatchchunk


                    --Configure Enemy
                    Teams["TeamDB"][src].enemy = MatchMaking["15vs15"].queue
                    Teams["TeamDB"][MatchMaking["15vs15"].queue].enemy = src

                    --Configure Ingame
                    Teams["TeamDB"][src].ingame = true
                    Teams["TeamDB"][MatchMaking["15vs15"].queue].ingame = true
                    Teams["TeamDB"][MatchMaking["15vs15"].queue].inqueue = false

                    --PlayersLeft
                    Teams["TeamDB"][src].playersleft = 15
                    Teams["TeamDB"][MatchMaking["15vs15"].queue].playersleft = 15
                    Teams["TeamDB"][src].girilenmodsayisi = 15
                    Teams["TeamDB"][MatchMaking["15vs15"].queue].girilenmodsayisi = 15

                    --Rounds Left
                    Teams["TeamDB"][src].winnedrounds = 0
                    Teams["TeamDB"][MatchMaking["15vs15"].queue].winnedrounds = 0
                    
                    vehSpawned = false

                    for k,v in pairs(Teams["TeamDB"][src].players) do
                        TriggerClientEvent("ta-matchmaking:joinmatch", v.serverid, mapid, 2, "15VS15")
                    end
                    for k,v in pairs(Teams["TeamDB"][MatchMaking["15vs15"].queue].players) do
                        TriggerClientEvent("ta-matchmaking:joinmatch", v.serverid, mapid, 1, "15VS15")
                    end

                    MatchMaking["15vs15"].queue = "bos"
                end
            end
        else
            TriggerClientEvent("ta-matchmaking:leaveFromQueue", src, "You are in the bug, contact with developer!")
        end
    else
        
        TriggerClientEvent("ta-matchmaking:leaveFromQueue", src, BQVersus.Notify.OnlyCanOwners)
        --Teaminiz galiba none abicim veya sahibi degilsiniz
    end
end)

local authobanCoords = {
    {
        coords = {
            {x = 2776.99, y = 4370.85, z = 48.9930, w = 197.22},
            {x = 2778.95, y = 4364.56, z = 49.0839, w = 196.95},
            {x = 2781.07, y = 4358.16, z = 49.1804, w = 197.54},
            {x = 2783.10, y = 4352.34, z = 49.2680, w = 197.91},
            {x = 2785.30, y = 4346.39, z = 49.3545, w = 199.29},
            {x = 2787.48, y = 4340.60, z = 49.4344, w = 200.10},
            {x = 2789.67, y = 4334.67, z = 49.5109, w = 199.33},
        },
    },
    {
        coords = {
            {x = 2475.84, y = 2934.81, z = 40.2642, w = 308.55},
            {x = 2480.30, y = 2938.60, z = 40.3341, w = 310.27},
            {x = 2484.82, y = 2942.60, z = 40.4051, w = 311.64},
            {x = 2489.23, y = 2946.52, z = 40.4798, w = 313.45},
            {x = 2493.66, y = 2950.80, z = 40.5619, w = 312.09},
            {x = 2497.99, y = 2954.87, z = 40.6585, w = 312.36},
            {x = 2503.34, y = 2959.93, z = 40.7637, w = 312.72},
        },
    }
}

RegisterNetEvent("ta-matchmaking:JoinChunk", function()
    local src = source
    if Teams["TeamDB"][Teams["PlayerDB"][src].team] then
        SetPlayerRoutingBucket(src, Teams["TeamDB"][Teams["PlayerDB"][src].team].matchchunk)
        
        if not vehSpawned then
            local spawned = 1
            vehSpawned = true
            local veh = nil

            for k, team in pairs(authobanCoords) do
                for _, coord in pairs(team.coords) do
                    if spawned == 1 or spawned == 8 then
                        veh = CreateVehicle(GetHashKey("zentorno"), coord.x, coord.y, coord.z, coord.w, true, false)
                        SetPlayerRoutingBucket(veh, Teams["TeamDB"][Teams["PlayerDB"][src].team].matchchunk)
                    elseif (spawned > 1 and spawned < 4) or (spawned > 8 and spawned < 11) then
                        veh = CreateVehicle(GetHashKey("everon"), coord.x, coord.y, coord.z, coord.w, true, false)
                        SetPlayerRoutingBucket(veh, Teams["TeamDB"][Teams["PlayerDB"][src].team].matchchunk)
                    elseif (spawned >= 4 and spawned < 8) or spawned >= 11 then 
                        veh = CreateVehicle(GetHashKey("neon"), coord.x, coord.y, coord.z, coord.w, true, false)
                        SetPlayerRoutingBucket(veh, Teams["TeamDB"][Teams["PlayerDB"][src].team].matchchunk)
                    end
                    SetVehicleNumberPlateText(veh, 'TA')  
                    spawned = spawned + 1
                end
            end
        end
    else
        SetPlayerRoutingBucket(src, 0)
    end
end)

RegisterServerEvent("ta-matchmaking:onDeath")
AddEventHandler("ta-matchmaking:onDeath", function(data)
    local src = source
    if Teams["TeamDB"][Teams["PlayerDB"][src].team] then
        if Teams["TeamDB"][Teams["PlayerDB"][src].team].ingame then
            if Teams["TeamDB"][Teams["PlayerDB"][data.killerServerId].team] then
                if Teams["TeamDB"][Teams["PlayerDB"][data.killerServerId].team].ingame then

                    Teams["PlayerDB"][data.killerServerId].kills += 1
                    Teams["PlayerDB"][data.killerServerId].pts += BQVersus.Points.killPoints
                    Teams["PlayerDB"][src].deaths += 1
                    Teams["PlayerDB"][src].pts -= BQVersus.Points.deathPoints

                    Teams["TeamDB"][Teams["PlayerDB"][src].team].playersleft = Teams["TeamDB"][Teams["PlayerDB"][src].team].playersleft - 1
                    if Teams["TeamDB"][Teams["PlayerDB"][src].team].playersleft == 0 then

                        Teams["TeamDB"][Teams["PlayerDB"][data.killerServerId].team].winnedrounds += 1
                        Teams["TeamDB"][Teams["PlayerDB"][src].team].playersleft = Teams["TeamDB"][Teams["PlayerDB"][src].team].girilenmodsayisi
                        Teams["TeamDB"][Teams["PlayerDB"][data.killerServerId].team].playersleft = Teams["TeamDB"][Teams["PlayerDB"][data.killerServerId].team].girilenmodsayisi

                        for k,v in pairs(Teams["TeamDB"][Teams["PlayerDB"][data.killerServerId].team].players) do
                            TriggerClientEvent("ta-matchmaking:changeScore", v.serverid, Teams["TeamDB"][Teams["PlayerDB"][data.killerServerId].team].winnedrounds, Teams["TeamDB"][Teams["PlayerDB"][src].team].winnedrounds)
                        end

                        for k,v in pairs(Teams["TeamDB"][Teams["PlayerDB"][src].team].players) do
                            TriggerClientEvent("ta-matchmaking:changeScore", v.serverid, Teams["TeamDB"][Teams["PlayerDB"][src].team].winnedrounds, Teams["TeamDB"][Teams["PlayerDB"][data.killerServerId].team].winnedrounds)
                        end

                        if Teams["TeamDB"][Teams["PlayerDB"][data.killerServerId].team].winnedrounds < BQVersus.maxRounds then
                            for k,v in pairs(Teams["TeamDB"][Teams["PlayerDB"][data.killerServerId].team].players) do
                                -- RESPAWN
                                TriggerClientEvent("ta-matchmaking:respawn", v.serverid)
                            end
                            for k,v in pairs(Teams["TeamDB"][Teams["PlayerDB"][src].team].players) do
                                -- RESPAWN
                                TriggerClientEvent("ta-matchmaking:respawn", v.serverid)
                            end

                        else
                            Teams["TeamDB"][Teams["PlayerDB"][data.killerServerId].team].ingame = false
                            BQWebhooks.sendMatchFinished(GetPlayerName(Teams["PlayerDB"][data.killerServerId].team), GetPlayerName(Teams["PlayerDB"][src].team), Teams["TeamDB"][Teams["PlayerDB"][data.killerServerId].team].players, Teams["TeamDB"][Teams["PlayerDB"][src].team].players, Teams["TeamDB"][Teams["PlayerDB"][data.killerServerId].team].winnedrounds, Teams["TeamDB"][Teams["PlayerDB"][src].team].winnedrounds)
                            for k,v in pairs(Teams["TeamDB"][Teams["PlayerDB"][data.killerServerId].team].players) do
                                
                                Teams["PlayerDB"][v.serverid].wins += 1
                                Teams["PlayerDB"][v.serverid].pts += BQVersus.Points.winPoints
                                Teams["PlayerDB"][v.serverid].rank = rankdetect(Teams["PlayerDB"][v.serverid].pts)

                                
                                Teams["PlayerDB"][v.serverid].totalmatches += 1
                                

                                TriggerClientEvent("ta-matchmaking:matchend", v.serverid, "You Won")
                            end
                            Teams["TeamDB"][Teams["PlayerDB"][src].team].ingame = false
                            for k,v in pairs(Teams["TeamDB"][Teams["PlayerDB"][src].team].players) do
                                Teams["PlayerDB"][v.serverid].loses += 1
                                Teams["PlayerDB"][v.serverid].pts -= BQVersus.Points.lossPoints
                                Teams["PlayerDB"][v.serverid].rank = rankdetect(Teams["PlayerDB"][v.serverid].pts)


                                Teams["PlayerDB"][v.serverid].totalmatches += 1
                                TriggerClientEvent("ta-matchmaking:matchend", v.serverid, "Kaybettiniz")
                            end
                        end
                    end
                end
            end
        end
    end
end)

function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

function rankdetect(pts)
    local rank = BQVersus.NoLeaugeName
    for k,v in pairs(BQVersus.Ranks) do
        if v.pts <= pts then
            local rank = v.name
        end
    end
    return rank
end