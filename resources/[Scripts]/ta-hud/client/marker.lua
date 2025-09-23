Config = {
    showTime = 4, -- 10 seconds default
    DefaultKey = "Z", -- Default key to open the menu
    PlaySound = true, -- Play sound when a marker is created
}

function GetSquadMembers(source)
	return exports["ta-squad"]:GetSquadMembers(source)
end

function HasMemberGotSquad()
    return exports["ta-squad"]:HasSquad()
end

local markers = {}
local spamChecker = 0
local fasulye = 0

function DrawText3D(coords, text, colourData)
	colourData = colourData or {255, 255, 255, 255}
	local size = 1
	local font = 4
    local scale = 0.6
	SetTextScale(0.0 * scale, 0.55 * scale)
	SetTextFont(font)
	SetTextColour(colourData[1], colourData[2], colourData[3], colourData[4])
	-- SetTextDropshadow(255, 255, 255, 255, 255)
	SetTextDropShadow()
	SetTextCentre(true)
	SetTextProportional(1)
	SetDrawOrigin(coords.x, coords.y, coords.z-0.3, 0)
	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(0.0, 0.0)
	ClearDrawOrigin()
end

function DrawSprite3d(data)
    local dist = #(GetGameplayCamCoords().xy - data.pos.xy)
    local fov = (1 / GetGameplayCamFov()) * 250
    local scale = 0.3
    SetDrawOrigin(data.pos.x, data.pos.y, data.pos.z, 0)
	if not HasStreamedTextureDictLoaded(data.textureDict) then
		local timer = 1000
		RequestStreamedTextureDict(data.textureDict, true)
		while not HasStreamedTextureDictLoaded(data.textureDict) and timer > 0 do
			timer = timer-1
			Citizen.Wait(100)
		end
	end
    DrawSprite(
        data.textureDict,
        data.textureName,
        (data.x or 0) * scale,
        (data.y or 0) * scale,
        data.width * scale,
        data.height * scale,
        data.heading or 0,
        data.r or 0,
        data.g or 0,
        data.b or 0,
        data.a or 255
    )
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    SendNUIMessage({
        type = "setConfig",
        Config = Config
    })
end)

local function RotationToDirection(rotation)
	local adjustedRotation = { 
		x = (math.pi / 180) * rotation.x, 
		y = (math.pi / 180) * rotation.y, 
		z = (math.pi / 180) * rotation.z 
	}
	local direction = {
		x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
		y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
		z = math.sin(adjustedRotation.x)
	}
	return direction
end

local function RayCastGamePlayCamera(distance)
	local cameraRotation = GetGameplayCamRot()
	local cameraCoord = GetGameplayCamCoord()
	local direction = RotationToDirection(cameraRotation)
	local destination = { 
		x = cameraCoord.x + direction.x * distance, 
		y = cameraCoord.y + direction.y * distance, 
		z = cameraCoord.z + direction.z * distance 
	}
	local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, -1, 1))
	return b, c, e
end

local createdThread = nil
function CreateMarkerThread()
    if fasulye < 6 then
        fasulye = fasulye + 1
    if #markers <= 0 or createdThread then return end
    createdThread = CreateThread(function()
        while #markers > 0 do 
            for i = #markers, 1, -1 do
                if markers[i] then
                    dist = #(GetEntityCoords(PlayerPedId()) - markers[i].coords) -- distance from marker
                    DrawSprite3d({
                        pos = markers[i].coords + vector3(0.0, 0.0, dist/100),
                        textureDict = 'markers',
                        textureName = "marker3", -- markers[i].markerType
                        width = 0.06,
                        height = 0.1,
                        r = 242,
                        g = 28,
                        b = 28,
                        a = 255
                    })
                    DrawText3D(markers[i].coords, tostring(math.floor(dist))..'m')
                end
    
                if ((GetGameTimer() - markers[i].now) >= Config.showTime * 1000) then
                    markers[i].markerActive = false
                    fasulye = fasulye - 1
                end
    
                if ((GetGameTimer() - markers[i].now) >= Config.showTime * 1000) then
                    markers[i].markerActive = false
                    if markers[i].source == GetPlayerServerId(PlayerId()) then
                        spamChecker = spamChecker - 1
                        fasulye = fasulye - 1
                    end
                    RemoveBlip(markers[i].blip)
                    table.remove(markers, i)
                end
            end
            Wait(0)
        end
        createdThread = nil
    end)
end
end

RegisterNetEvent("marker:CreateMarker", function(a,b,c, src, markerType)
    table.insert(markers, {
        coords = b,
        entity = c,
        now = GetGameTimer(),
        source = src,
        markerType = markerType
    })
    if Config.PlaySound then
        PlaySoundFrontend(-1, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET", 1)
    end
    CreateMarkerThread()
end)

local isMenuOpened = false
RegisterKeyMapping('+openMarker', 'Marker', 'keyboard', Config.DefaultKey)
RegisterCommand("+openMarker", function()
    local allahsehit = "marker3"
    if not allahsehit then return end
    local _, coords, entity = RayCastGamePlayCamera(1000.0)
    if spamChecker >= 5 then return end
    spamChecker = spamChecker + 1
    TriggerServerEvent("ta-marker:CreateMarker", _, coords, entity, allahsehit)
end)

