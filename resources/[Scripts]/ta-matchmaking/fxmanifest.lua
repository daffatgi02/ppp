fx_version 'cerulean'
game 'gta5'
author 'barann & discord.gg/bqworkshop'
lua54 'yes'

client_scripts {
    'client.lua',
    'death.lua',
    'no_escrow.lua'
}
server_scripts {
    'server.lua',
    'webhooks.lua'
}
shared_scripts {
    'config.lua'
}

ui_page 'ui/index.html'

files {
    'ui/index.html',
    'ui/css/style.css',
    'ui/css/style.css.map',
    'ui/css/style.scss',
    'ui/js/main.js',
    'ui/assets/bg/*.png',
    'ui/assets/icons/*.png',
    'ui/assets/lobby/*.png',
}


escrow_ignore {
    'config.lua',
    'no_escrow.lua',
    'webhooks.lua'
}