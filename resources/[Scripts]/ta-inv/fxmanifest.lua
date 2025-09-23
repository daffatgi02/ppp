fx_version 'cerulean'
game 'gta5'
lua54 'yes'
client_script {
	"config/items.lua",
	"config/clientconfig.lua",
	"config/sharedconfig.lua",
	'client/variables.lua',
	'client/*.lua',
}
server_script {
	'@oxmysql/lib/MySQL.lua',
	"config/items.lua",
	"config/serverconfig.lua",
	"config/sharedconfig.lua",
	'server/variables.lua',
	"server/*.lua",
}
ui_page "nui/index.html"
files {
	"config/jsconfig.json",
	'nui/index.html',
	'nui/src/*.js',
	'nui/style.css',
	'nui/assets/*.png',
	'nui/assets/invassets/*.png'
}
