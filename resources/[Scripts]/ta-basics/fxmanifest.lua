fx_version 'adamant'
games { 'gta5' }
lua54 'yes'

client_scripts {
	'client/main.lua',
}

server_scripts {
	'server/main.lua',
}

ui_page "html/index.html"

files {
    'html/*.html',
    'html/js/*.js',
    'html/images/*.png',
	'html/images/*.jpg',
    'html/css/*.css',
	'html/fonts/*.ttf',
	'html/fonts/*.otf'
}

