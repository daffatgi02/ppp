fx_version "adamant"

game "gta5"

lua54 'yes'
client_script "client.lua"
server_script "server.lua"
shared_script "shared.lua"
ui_page 'html/index.html'

files {
    'html/*.html',
    'html/*.js',
    'html/*.css',
    'html/sounds/*.mp3',
}

escrow_ignore {
    "*.lua"
}