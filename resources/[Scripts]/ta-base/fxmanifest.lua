fx_version 'adamant'
games { 'gta5' }
lua54 'yes'

client_scripts {
	'@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/EntityZone.lua',
	'@PolyZone/CircleZone.lua',
	'@PolyZone/ComboZone.lua',
	--------------------------
	'client/main.lua',
	'client/drs.lua',
	'client/gamemodes/main.lua',
	'client/gamemodes/gungame.lua',
	'client/gamemodes/req/coords.lua',
	'client/gamemodes/req/blips.lua',
	'client/gamemodes/req/spawn.lua',	
	'client/gamemodes/req/zones.lua',
	'client/gamemodes/req/npcs.lua',
	'client/gamemodes/ff.lua',
	'client/gamemodes/deluxo.lua',
	'client/gamemodes/sumo.lua',
	'client/gamemodes/face2face.lua',
	'client/gamemodes/driveby.lua',
	'client/scaleform/lib.lua',
	'client/death.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua',
	'server/gamemodes/gungame.lua',
	'server/gamemodes/weapons.lua',
	'server/gamemodes/face2face.lua',
	'server/joingame.lua',
	'server/death.lua',
}

ui_page "html/index.html"

files {
    'html/*.html',
    'html/js/*.js',
    'html/js/*.ogg',
    'html/js/*.mp3',
    'html/images/*.png',
	'html/images/*.jpg',
    'html/css/*.css',
	'html/fonts/*.ttf',
	'html/fonts/*.otf'
}

