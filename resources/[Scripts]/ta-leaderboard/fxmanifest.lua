fx_version 'cerulean'
game 'gta5'

author 'TAC Development'
description 'Farm and Fight Leaderboard System'
version '1.0.0'

ui_page 'html/index.html'

shared_scripts {
    'shared/config.lua'
}

client_scripts {
    'client/client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua'
}

files {
    'html/index.html',
    'html/css/style.css',
    'html/js/script.js'
}