-- ESX.RegisterCommand('tp', 'admin', function(xPlayer, args, showError)
-- 	xPlayer.setCoords({x = args.x, y = args.y, z = args.z})
-- end, false, {help = "Teleport to specific coordinates.", validate = true, arguments = {
-- 	{name = 'x', help = "x value", type = 'number'},
-- 	{name = 'y', help = "y value", type = 'number'},
-- 	{name = 'z', help = "z value", type = 'number'}
-- }})

-- ESX.RegisterCommand('car', 'user', function(xPlayer, args, showError)
-- 	xPlayer.triggerEvent('esx:spawnVehicle', args.car)
-- end, false, {help = "Spawn a vehicle", validate = false, arguments = {
-- 	{name = 'car', help = "Vehicle model or hash value.", type = 'any'}
-- }})

-- ESX.RegisterCommand({'dv'}, 'admin', function(xPlayer, args, showError)
-- 	xPlayer.triggerEvent('esx:deleteVehicle', args.radius)
-- end, false, {help = 'Delete nearby vehicle', validate = false, arguments = {
-- 	{name = 'radius', help = "(Optional) - Deletes all vehicles within the specified meter radius.", type = 'any'}
-- }})

ESX.RegisterCommand({'clear', 'cls'}, 'user', function(xPlayer, args, showError)
	xPlayer.triggerEvent('chat:client:ClearChat')
end, false, {help = "Clears the chat."})

-- ESX.RegisterCommand('setgroup', 'admin', function(xPlayer, args, showError)
-- 	args.playerId.setGroup(args.group)
-- end, true, {help = "Edit player's permission group.", validate = true, arguments = {
-- 	{name = 'playerId', help = "Player ID value.", type = 'player'},
-- 	{name = 'group', help = "Permission to give.", type = 'string'},
-- }})
