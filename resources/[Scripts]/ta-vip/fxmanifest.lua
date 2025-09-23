fx_version 'cerulean'
game 'gta5'
author 'atiysu'
description 'ATY Report'
lua54 'yes'

client_scripts{
    'client/client.lua',
}

server_scripts{
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua',
}

ui_page 'ui/index.html'

files {
    'ui/**/*.*',
    'ui/*.*',
}

escrow_ignore {
    'config.lua',
}