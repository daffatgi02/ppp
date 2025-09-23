

fx_version 'cerulean'

game 'gta5'

lua54 'yes'

description 'ES Extended'

version '1.2.0'

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',

	'config.lua',

	'server/common.lua',
	'server/classes/player.lua',
	'server/functions.lua',
	'server/main.lua',
	'server/commands.lua',

	'common/modules/math.lua',
	'common/modules/table.lua',
	'common/functions.lua'
}

client_scripts {

	'config.lua',

	'client/common.lua',
	'client/entityiter.lua',
	'client/functions.lua',
	'client/main.lua',

	'common/modules/math.lua',
	'common/modules/table.lua',
	'common/functions.lua'
}

exports {
	'getSharedObject'
}

server_exports {
	'getSharedObject'
}