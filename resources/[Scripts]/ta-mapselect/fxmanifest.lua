fx_version 'cerulean'
game 'gta5'
author 'atiysu#6666'
description 'Map Selector'
lua54 'yes'

shared_scripts{
    'config.lua'
}

client_scripts{
    'client/main.lua',
}

server_scripts{
    'server/main.lua',
}

ui_page 'ui/index.html'

files{
    'ui/**/*.*',
    'ui/*.*',
}

exports{
    'StartSelection'
}