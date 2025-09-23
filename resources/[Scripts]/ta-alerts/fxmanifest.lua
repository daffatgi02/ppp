



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
}

ui_page "html/index.html"

files {
    'html/**/*.*',
    'html/*.*',
}

