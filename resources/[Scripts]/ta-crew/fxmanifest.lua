fx_version 'adamant'
games { 'gta5' }
lua54 'yes'

client_scripts {
	'client/main.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
	'server/main.lua',
}

ui_page "ui/index.html"

files {
    'ui/*.*',
    'ui/**/*.*',
}

