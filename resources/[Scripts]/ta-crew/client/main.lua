ESX = exports['es_extended']:getSharedObject()

isPlayerinCrew = false
local crew = false
local crewname = ""
local havecrew = false
crewmembers = 0
crewphoto = ""
local haveinvite = false
local invitecrew = ""

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x,y,z)
    if onScreen then
        local factor = #text / 100
        SetTextScale(0.50, 0.50)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0)
		SetTextOutline(1)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 250
    end
end

local currentlyOnlinePlayers = {}

RegisterNetEvent("ta-crew:openUI")
AddEventHandler("ta-crew:openUI", function()
    SetNuiFocus(true, true)
    ESX.TriggerServerCallback("ta-crew:getCrewBanner", function(banner)
        local PlayerData = ESX.GetPlayerData()
        SendNUIMessage({type = "open-menu", banner = PlayerData.avatar, name = PlayerData.name, crewbanner = banner, isHaveCrew = crewname})
    end, crewname)

	ESX.TriggerServerCallback("ta-crew:fetchAllCrew", function(crew_table)
		SendNUIMessage({type = "list-all-crew", table = crew_table})
	end)
end)

RegisterNUICallback("ta-crew:createCrew", function(data)
	TriggerServerEvent("createcrew:sv", data.pfp, data.name, data.altname, data.color)
	ESX.TriggerServerCallback("ta-crew:fetchAllCrew", function(crew_table)
		SendNUIMessage({type = "list-all-crew", table = crew_table})
	end)
    TriggerServerEvent("getcrew")
end)

RegisterNUICallback('ta-crew:sendInvite', function(data)
    if havecrew then 
        TriggerServerEvent("invitemember:sv", crewname, data.playerId)
    end
end)

RegisterNUICallback('ta-crew:inviteChoice', function(data)
	if (data.isAccepted) then
		TriggerServerEvent("joincrew:sv", data.crewname)
		print("You accepted the invitation from crew: " .. data.crewname)
		isPlayerinCrew = true
        crewname = data.crewname
	else
		print("You declined the invitation from crew: " .. data.crewname)
	end
	ESX.TriggerServerCallback("ta-crew:fetchAllCrew", function(crew_table)
		SendNUIMessage({type = "list-all-crew", table = crew_table})
	end)
end)

RegisterNUICallback('ta-crew:kickMember', function(identifier)
    TriggerServerEvent("kickmember:sv", crewname, identifier)
    Wait(1000)
    ESX.TriggerServerCallback("ta-crew:fetchAllCrew", function(crew_table)
		SendNUIMessage({type = "list-all-crew", table = crew_table})
	end)
    TriggerServerEvent("getcrew")
end)

RegisterNUICallback('ta-crew:fetchPlayerInformations', function(data)
    ESX.TriggerServerCallback("ta-crew:getPlayerInformation", function(playerInfo)
        SendNUIMessage({type = "refresh-crew-players", crewname = data.name, playerTable = playerInfo, leaders = data.leaders})
    end, data.players)
end)

Citizen.CreateThread(function()
    TriggerServerEvent("getcrew")
end)

RegisterNetEvent("send-data:cl")
AddEventHandler("send-data:cl", function(name, check, crewmembers, crewphoto)
    if check then 
        havecrew = true 
		crewmembers = crewmembers
		crewphoto = crewphoto
    else
        havecrew = false
    end
    crewname = name
	if crewname then
		isPlayerinCrew = true
	end
    crew = true 
    Wait(1200)
    SendNUIMessage({type = "isHaveCrew", value = havecrew})
end)


RegisterNetEvent("invitemember:cl")
AddEventHandler("invitemember:cl", function(name, crewmembers, crewphoto)
	
    if crew or isPlayerinCrew then 
        print("Invitation from crew " .. name .. " but you are currently in crew " .. crewname .. ". You need to leave first to join another crew.")
    else
        print("Invitation from crew " .. name .. " - type /accept to accept or /decline to decline")
        haveinvite = true 
        invitecrew = name
		SendNUIMessage({type = "renew-inbox", crewname = name, crewmembers = crewmembers, crewphoto = crewphoto})
    end
end)

RegisterNUICallback("ta-crew:client:menu-back", function()
    Wait(100)
    TriggerEvent('ta-base:client:joingame')
    SetNuiFocus(0, 0)
end)

RegisterNUICallback("ta-crew:client:change-name", function(data)
    print("geliyorrr", data)
    TriggerServerEvent('ta-crew:server:change-name', data)
end)

RegisterNUICallback("ta-crew:client:change-photo", function(data)
    print("geliyorr", data)
    TriggerServerEvent('ta-crew:server:change-photo', data)
end)

RegisterCommand("accept", function(source, arg)
    if haveinvite then
        TriggerServerEvent("joincrew:sv", invitecrew)
        haveinvite = false
        invitecrew = ""
    end
end)

RegisterCommand("decline", function(source, arg)
    if haveinvite then
        haveinvite = false
        invitecrew = ""
    end
end)

RegisterCommand("createcrew", function(source, arg)
    if crew == false then 
        TriggerServerEvent("createcrew:sv", arg[1])
        crewname = arg[1]
        crew = true 
        havecrew = true
    end
end)

RegisterCommand("closecrew", function()
    if crew then
        if havecrew then 
            TriggerServerEvent("closecrew:sv", crewname)
            crewname = ""
            crew = false 
            havecrew = false
        else
            TriggerServerEvent("leavecrew:sv", crewname)
            crewname = ""
            crew = false
            havecrew = false
        end 
    end
end)

RegisterNUICallback("closecrew", function()
    if crew then
        if havecrew then 
            TriggerServerEvent("closecrew:sv", crewname)
            crewname = ""
            crew = false 
            havecrew = false
        else
            TriggerServerEvent("leavecrew:sv", crewname)
            crewname = ""
            crew = false
            havecrew = false
        end 
    end
end)

RegisterCommand("crewkick", function(source, arg)
    if havecrew then 
        TriggerClientEvent("kickmember:sv", crewname, arg[1])
    end
end)

RegisterCommand("crewinvite", function(source, arg)
    if havecrew then 
        TriggerServerEvent("invitemember:sv", crewname, arg[1])
    end
end)