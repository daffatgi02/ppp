fx_version 'cerulean'
game 'gta5'
author 'atiysu'
lua54 'yes'

client_scripts{
    'client/weapons.lua',
    'client/client.lua',
    -- 'client/marker.lua',
    'client/damagemessage.lua',
}

server_scripts{
    'server/server.lua',
    'server/damagemessage.lua'
}

ui_page 'ui/index.html'

files {
    'ui/**/*.*',
    'ui/*.*',
}