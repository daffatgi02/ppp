BQFunctions = {}

RegisterNUICallback("ta-matchmaking:client:menu-back", function()
    DoScreenFadeOut(200) Wait(400)
    TriggerEvent('ta-base:client:joingame')
    while not IsScreenFadedOut() do Wait(100) end
    Wait(200) DoScreenFadeIn(400)
    SetNuiFocus(0, 0)
end)

CreateThread(function()
	while true do
		Wait(0)
		if NetworkIsPlayerActive(PlayerId()) then
			TriggerServerEvent('ta-matchmaking:login')
			break
		end
	end
end)

RegisterNuiCallback("close", function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = "open",
        display = false
    })
    cb("ok")
end)

RegisterNetEvent("ta-matchmaking:show", function()
    SendNUIMessage({
        type = "open",
        display = true
    })
    TriggerServerEvent("ta-matchmaking:login")
    SetNuiFocus(true, true)
end)

RegisterNuiCallback("getLeaderboard", function(data, cb)
    TriggerServerEvent("ta-matchmaking:getLeaderboard")
end)

RegisterNetEvent("ta-matchmaking:sendLeaderboardInfoToClient", function(myStats, toplist)
    a = 0
    for k,v in pairs(toplist) do
        a = a + 1
        if v.identifier == myStats.steam then
            benimsiralama = a
        end
    end

    SendNUIMessage({
        type = "LeaderboardMyStats",
        sira = benimsiralama,
        stats = myStats
    })
    SendNUIMessage({
        type = "Leaderboard",
        toplist = toplist
    })
end)

RegisterNetEvent("ta-matchmaking:notify", function(text)
    SendNUIMessage({
        type = "Notify",
        message = text
    })
end)

RegisterNetEvent("ta-matchmaking:SendTeamToClient", function(teamPlayers, mydata)
    if teamPlayers then
        if teamPlayers.ownerid == mydata.serverid then
 
            SendNUIMessage({
                type = "getMyTeam",
                players = teamPlayers.players,
                myid = mydata.serverid,
                owner = true
            })
        else
            SendNUIMessage({
                type = "getMyTeam",
                players = teamPlayers.players,
                myid = mydata.serverid,
                owner = false
            })
        end
    end

end)

-- Create Team --
RegisterNuiCallback("CreateTeam", function(data, cb)
    TriggerServerEvent("ta-matchmaking:CreateTeam", data.type)
    cb("ok")
end)

RegisterNuiCallback("backbutton", function(data, cb) -- back button for the UI
    TriggerServerEvent("ta-matchmaking:deleteTeam") -- delete the team if you are in the team creation menu
    TriggerServerEvent("ta-matchmaking:leaveTeam") -- leave the team if you are in the team menu
    cb("ok")
end)

RegisterCommand("+accept", function()
    TriggerEvent("ta-base:showUi", true)
    SendNUIMessage({
        type = "stopNotification"
    })
    TriggerServerEvent("ta-matchmaking:AcceptInvite")
    TriggerEvent("ta-base:revokeFocus")
    TriggerEvent("ta-base:rekoAccept")
end)

RegisterCommand("+reject", function()
    TriggerEvent("ta-base:showUi", true)
    SendNUIMessage({
        type = "stopNotification"
    })
    TriggerServerEvent("ta-matchmaking:RejectInvite")
    TriggerEvent("ta-base:revokeFocus")
end)

RegisterNuiCallback("acceptMatch", function()
    TriggerEvent("ta-base:showUi", true)
    SendNUIMessage({
        type = "stopNotification"
    })
    TriggerServerEvent("ta-matchmaking:AcceptInvite")
    TriggerEvent("ta-base:revokeFocus")
    TriggerEvent("ta-base:rekoAccept")
end)

RegisterNuiCallback("declineMatch", function()
    TriggerEvent("ta-base:showUi", true)
    SendNUIMessage({
        type = "stopNotification"
    })
    TriggerServerEvent("ta-matchmaking:RejectInvite")
    TriggerEvent("ta-base:revokeFocus")
end)

RegisterNuiCallback("removeteamfromqueue", function()
    TriggerServerEvent("removeteamfromqueue")
end)

RegisterKeyMapping('+accept', 'Key To Accept Invite', 'keyboard', 'F9')
RegisterKeyMapping('+reject', 'Key To Reject Invite', 'keyboard', 'F10')

-- INVITE SYSTEM --
RegisterNuiCallback("getInviteablePlayers", function(data, cb)
    InviteablePlayers = {} -- reset the table
    local closestplayers = GetActivePlayers() -- get all players in the server (max 64)
    for k,v in pairs(closestplayers) do
        if GetPlayerServerId(v) ~= GetPlayerServerId(PlayerId()) then -- if the player is not you
            table.insert(InviteablePlayers, {id=GetPlayerServerId(v), name=GetPlayerName(v)}) -- add the player to the table
        end
    end
    cb(InviteablePlayers) -- send the table to the UI
end)

RegisterNuiCallback("invitePlayer", function(data, cb)
    TriggerServerEvent("ta-matchmaking:InvitePlayer", tonumber(data.id)) -- send the invite to the server
    cb("ok")
end)

RegisterNetEvent("ta-matchmaking:SendInviteToClient", function(invitername)
    TriggerEvent("ta-base:showUi", false)
    SetNuiFocus(1,1)
    SendNUIMessage({
        type = "recieveinvite",
        message = string.format("You have been invited by %s. Do you want to join?", invitername)
    })
end)

RegisterNetEvent("ta-matchmaking:leaveFromQueue", function(reason)
    SendNUIMessage({
        type = "CloseQueue",
    })
    if reason then
        SendNUIMessage({
            type = "Notify",
            message = reason
        })
    end
end)

RegisterNetEvent("ta-matchmaking:QueueUI", function()
    SendNUIMessage({
        type = "StartMatchmakingUI",
    })
end)

-- Get Player Data --
RegisterNuiCallback("getPlayerdata", function(data, cb)
    TriggerServerEvent("ta-matchmaking:getPlayerData", tonumber(data.serverid))
    cb("ok")
end)

RegisterNetEvent("ta-matchmaking:sendPlayerData", function(playerData)
    SendNUIMessage({ -- send the player data to the UI
        type = "playerData",
        playerData = playerData
    })
end)

RegisterNuiCallback("startmatchmaking", function(data, cb)
    gamename = data.type.."vs"..data.type
    TriggerServerEvent("ta-matchmaking:matchmakingJoin", gamename)
    cb("ok")
end)

Bools = {}
Bools.ingame = false

RegisterNetEvent("ta-matchmaking:joinmatch", function(mapid, teamid, modid)
    DoScreenFadeOut(200) Wait(400)
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = "open",
        display = false
    })
    SendNUIMessage({
        type = "CloseQueue",
    })
    SendNUIMessage({
        type = "roundopen",
    })
    TriggerEvent('ta-base:client:close-main-menu:matchmaking')
    curmap = BQVersus.Maps[modid][mapid][teamid]
    SetEntityCoords(PlayerPedId(), curmap.x, curmap.y, curmap.z, false, false, false, false)
    
    TriggerEvent('ta-death:client:matchmaking', "join")
    TriggerServerEvent("ta-matchmaking:JoinChunk")
    TriggerServerEvent('ta-base:server:clear-inv')
    TriggerEvent('ta-inv:client:inv_default', "join")
    if modid == "15VS15" then
        TriggerEvent('ta-basics:general-hud', "show", "MATCHMAKING - OTOBAN SAVASI")
        TriggerServerEvent('ta-base:server:weapons', "otobanfightsilahlar", "add", true)
        TriggerEvent('ta-base:client:matchmaking-otoban', "join")
    else
        TriggerEvent('ta-basics:general-hud', "show", "MATCHMAKING - "..modid)
        TriggerServerEvent('ta-base:server:weapons', "custom_damaged_only_pistol", "add", true)
    end
    Bools.ingame = true
    BQFunctions.JoinMatch()
    while not IsScreenFadedOut() do Citizen.Wait(100) end
    Wait(200) DoScreenFadeIn(300)
    if modid == "15VS15" then
        BQFunctions.GeriSayim_Otoban()
    else
        BQFunctions.GeriSayim()
    end
end)

RegisterNetEvent("ta-matchmaking:JoinedTeam", function(type2)
    SendNUIMessage({
        type = "open",
        display = true
    })
    SetNuiFocus(true,true)
    SendNUIMessage({
        type = "openNUIWithTeam",
        kackisivararkakoltukta = type2
    })
end)

RegisterNetEvent("ta-matchmaking:KickedFromTeam", function()
    SendNUIMessage({
        type = "kicked"
    })

    SendNUIMessage({
        type = "getMyTeam",
        players = {}
    })
end)

RegisterNetEvent("ta-matchmaking:changeScore", function(mscore, escore)
    SendNUIMessage({
        type = "roundupdate",
        myteam = mscore,
        enemyteam = escore
    })
end)

RegisterNetEvent("ta-matchmaking:matchend", function(wonordefeat, iste)
    Bools.ingame = false
    -- ExecuteCommand("base")
    DoScreenFadeOut(200)
    Wait(200)
    SendNUIMessage({
        type = "roundupdate",
        myteam = 0,
        enemyteam = 0
    })
    SendNUIMessage({
        type = "roundclose"
    })

    if wonordefeat == "Kaybettiniz" then
        SendNUIMessage({
            type = "Notify",
            message = BQVersus.Notify.losemessage
        })
    else
        SendNUIMessage({
            type = "Notify",
            message = BQVersus.Notify.winmessage
        })
    end

    if iste then
        SendNUIMessage({
            type = "Notify",
            message = iste
        })

    end

    BQFunctions.MatchEnd()

    TriggerServerEvent("ta-matchmaking:getMyTeam")
    
    if BQVersus.ReviveTrigger == "hospital:client:Revive" then
        Wait(6000)
        BQFunctions.Revive()
        return
    else
        BQFunctions.Revive()
        return
    end
    
    TriggerEvent('ta-death:client:matchmaking', "left")
    TriggerEvent("ta-base:client:joingame")
end)

RegisterNuiCallback("kickPlayer", function(data, cb)
    TriggerServerEvent("ta-matchmaking:kickTeamMember", tonumber(data.id))
    cb("ok")
end)

BQFunctions.GeriSayim = function()
    sayimsuresi = 5 + 1
    FreezeEntityPosition(PlayerPedId(), true)
    for i=1,5 do
        if i == 3 and BQVersus.ReviveTrigger == "hospital:client:Revive" then
            BQFunctions.Revive()
        end
        TriggerEvent("announceversus", sayimsuresi-i)

        Wait(1000)
    end
    TriggerEvent("announceversus", "PARCALAYIN")
    FreezeEntityPosition(PlayerPedId(), false)

    if Bools.ingame then
        SetEntityCoords(PlayerPedId(), curmap.x, curmap.y, curmap.z, false, false, false, false)
    end

    TriggerServerEvent("ta-matchmaking:JoinChunk")
end

BQFunctions.GeriSayim_Otoban = function()
    sayimsuresi = 40 + 1
    for i=1,40 do
        TriggerEvent("announceversus", sayimsuresi-i)

        Wait(1000)
    end
    TriggerEvent("announceversus", "PARCALAYIN")
    
end

announcestring = false
RegisterNetEvent('announceversus')
AddEventHandler('announceversus', function(msg)
    if msg == 0 then
        announcestring = "PARCALAYIN"
    else
        announcestring = msg
    end
    PlaySoundFrontend(-1, "DELETE","HUD_DEATHMATCH_SOUNDSET", 1)
    Wait(2 * 1000)
    announcestring = false
end)

function Initialize(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
    PushScaleformMovieFunctionParameterString("~r~FIGHT BASLIYOR!")
    PushScaleformMovieFunctionParameterString(announcestring)
    PopScaleformMovieFunctionVoid()
    return scaleform
end

CreateThread(function()
    while true do
	    Wait(0)
        if announcestring then
	    	scaleform = Initialize("mp_big_message_freemode")
            DrawScaleformMovie(scaleform, 0.52, 0.27, 0.81, 0.74, 255, 255, 255, 255)
	    	-- DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
        end
    end
end)
