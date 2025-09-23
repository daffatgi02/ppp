function CreateExtendedPlayer(playerId, identifier, skin, group, playername, kills, death, ff_kills, ff_death, points, coin, level, xp, avatar, rank, geolocation)
	local self = {}
	self.group = group
	self.identifier = identifier
	self.skin = skin
	self.playerId = playerId
	self.source = playerId
	self.geolocation = geolocation
	self.playername = playername
	self.kills = kills
	self.death = death
	self.ff_kills = ff_kills
	self.ff_death = ff_death
	self.points = points
	self.coin = coin
	self.level = level
	self.xp = xp
	self.avatar = avatar
	self.rank = rank
	self.variables = {}

	ExecuteCommand(('add_principal identifier.%s group.%s'):format(self.identifier, self.group))

	self.triggerEvent = function(eventName, ...)
		TriggerClientEvent(eventName, self.source, ...)
	end

	self.setCoords = function(coords)
		self.updateCoords(coords)
		self.triggerEvent('esx:teleport', coords)
	end

	self.getIdentifier = function()
		return self.identifier
	end

	self.setGroup = function(newGroup)
		ExecuteCommand(('remove_principal identifier.%s group.%s'):format(self.identifier, self.group))
		self.group = newGroup
		ExecuteCommand(('add_principal identifier.%s group.%s'):format(self.identifier, self.group))
	end

	self.getName = function()
		return GetPlayerName(self.source)
	end

	self.getPlayerGeolocation = function()
		return self.geolocation
	end

	self.getGroup = function()
		return self.group
	end

	self.getPlayerAvatar = function()
		return self.avatar
	end

	self.set = function(k, v)
		self.variables[k] = v
	end

	self.get = function(k)
		return self.variables[k]
	end

	return self
end