fx_version 'bodacious'
game 'gta5'

Author 'Ayazwai#3900'
version '1.0.2'
scriptname 'wais-squad-esx'

client_scripts {
    'config.lua',
    'mission.lua',
    'client.lua'
}

server_scripts {
    'config.lua',
    '@mysql-async/lib/MySQL.lua',
    'server.lua'
}

ui_page "html/index.html"

files {
    'html/*.js',
    'html/*.css',
    'html/*.html',
    'html/img/*.png',
    'html/img/*.jpg',
    'html/fonts/*.ttf',
    'html/fonts/*.otf',
    'html/fonts/*.woff',
    'html/img/rooms/*.png',
}

lua54 'yes'

escrow_ignore {
    'config.lua'
}