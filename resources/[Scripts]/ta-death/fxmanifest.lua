fx_version 'cerulean'
games { 'gta5' }
description 'ta-death'
lua54 'yes'

client_scripts {
    'config.lua',
	'client/main.lua'
}

server_scripts {
    'config.lua',
	'server/main.lua'
}

ui_page "html/index.html"

files {
    'html/*.html',
    'html/js/*.js',
    'html/css/*.css'
}

escrow_ignore {
    'config.lua',
    'client/main.lua',
    'server/main.lua'
}