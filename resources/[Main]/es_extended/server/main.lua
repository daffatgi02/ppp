first = false

RegisterNetEvent('esx:onPlayerJoined')
AddEventHandler('esx:onPlayerJoined', function()
	if not ESX.Players[source] then
		onPlayerJoined(source)
	end
end)

function onPlayerJoined(playerId)
	local identifier

	for k,v in ipairs(GetPlayerIdentifiers(playerId)) do
		if string.match(v, 'steam:') then
			identifier = v
			break
		end
	end

	if identifier then
		if ESX.GetPlayerFromIdentifier(identifier) then
			DropPlayer(playerId, 'This Steam ID is already connected to the server!')
		else
			MySQL.Async.fetchScalar('SELECT 1 FROM users WHERE identifier = @identifier', {
				['@identifier'] = identifier
			}, function(result)
				if result then
					loadESXPlayer(identifier, playerId, false)
				else
					geolocation = "errorapi"
					PerformHttpRequest("https://api.ipgeolocation.io/ipgeo?apiKey=88522be2a5d846b4912c0c3e7e47c6a4&ip=" .. GetPlayerEndpoint(playerId), function(status, body, headers, err)
						if (status == 200) then
							geolocation = body
						end

						MySQL.Async.execute('INSERT INTO users (identifier, geolocation, playername) VALUES (@identifier, @geolocation, @playername)', {
							['@identifier'] = identifier,
							['@geolocation'] = geolocation,
							['@playername'] = GetPlayerName(playerId)
						}, function(rowsChanged)
							loadESXPlayer(identifier, playerId, true)
						end)
					end)
				end
			end)
		end
	else
		DropPlayer(playerId, 'Steam ID not found. Make sure Steam is running and logged in before connecting to the server.')
	end
end

AddEventHandler('playerConnecting', function(name, setCallback, deferrals)
	local src = source
	deferrals.defer()
	local playerId, identifier = src
	Wait(100)

	for k,v in ipairs(GetPlayerIdentifiers(playerId)) do
		if string.match(v, 'steam:') then
			identifier = v
			break
		end
	end

	if identifier then
		if ESX.GetPlayerFromIdentifier(identifier) then
			deferrals.done('This Steam ID is already connected to the server!')
		else
			deferrals.done()
		end
	else
		deferrals.done('Steam ID not found! Make sure Steam is running and logged in!')
	end
end)

function loadESXPlayer(identifier, playerId, first)
	local tasks = {}
	local userData = {}

	table.insert(tasks, function(cb) 
		MySQL.Async.fetchAll('SELECT `group`, `geolocation` FROM users WHERE identifier = @identifier', {
			['@identifier'] = identifier
		}, function(result)
			userData.geolocation = result[1].geolocation
			if result[1].group then
				userData.group = result[1].group
			else
				userData.group = 'user'
			end
			cb()
		end)

		Wait(1500)
		MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
			['@identifier'] = identifier
		}, function(result)
			userData.kills = result[1].kills
			userData.death = result[1].death
			userData.skin = result[1].skin
			userData.ff_kills = result[1].ff_kills
			userData.ff_death = result[1].ff_death
			userData.point = result[1].point
			userData.coin = result[1].coin
			userData.playername = result[1].playername
			userData.rank = result[1].rank
			userData.level = result[1].level
			userData.xp = result[1].xp
		end)
	end)

	Async.parallel(tasks, function(results)
		while not userData.point do Wait(0) end
		local xPlayer = CreateExtendedPlayer(
			playerId,
			identifier,
			userData.skin,
			userData.group,
			userData.playername,
			userData.kills,
			userData.death,
			userData.ff_kills,
			userData.ff_death,
			userData.point,
			userData.coin,
			userData.level,
			userData.xp,
			userData.avatar,
			userData.rank,
			userData.geolocation
		)

		ESX.Players[playerId] = xPlayer
		xPlayer.triggerEvent('esx:playerLoaded', {
			playerId = playerId,
			identifier = xPlayer.getIdentifier(),
			playername = GetPlayerName(playerId),
			kills = userData.kills,
			death = userData.death,
			ff_kills = userData.ff_kills,
			ff_death = userData.ff_death,
			point = userData.point,
			skin = userData.skin,
			coin = userData.coin,
			level = userData.level,
			xp = userData.xp,
			avatar = userData.avatar,
			rank = userData.rank,
			userData.geolocation
		})
		xPlayer.triggerEvent('esx:registerSuggestions', ESX.RegisteredCommands)
		TriggerClientEvent('fivem-appearance:first:loadchar', playerId)
	end)
end

AddEventHandler('chatMessage', function(playerId, author, message)
	if message:sub(1, 1) == '/' and playerId > 0 then
		CancelEvent()
	end
end)

AddEventHandler('playerDropped', function(reason)
	local playerId = source
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer then
		TriggerEvent('esx:playerDropped', playerId, reason)
		ESX.SavePlayer(xPlayer, function()
			ESX.Players[playerId] = nil
		end)
	end
end)

ESX.RegisterServerCallback('esx:getPlayerData', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb({
		identifier   = xPlayer.identifier,
		name = GetPlayerName(source)
	})
end)

ESX.RegisterServerCallback('esx:getOtherPlayerData', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	cb({
		identifier   = xPlayer.identifier,
		name = GetPlayerName(target)
	})
end)

ESX.RegisterServerCallback('esx:getPlayerNames', function(source, cb, players)
	players[source] = nil

	for playerId,v in pairs(players) do
		local xPlayer = ESX.GetPlayerFromId(playerId)

		if xPlayer then
			players[playerId] = xPlayer.getName()
		else
			players[playerId] = nil
		end
	end

	cb(players)
end)

ESX.StartDBSync()