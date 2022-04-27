fx_version 'adamant'
games {'gta5'}

version '1.0.0'
author 'theMani_kh'
description 'Easy Pixel AntiCheat For QBCore'

client_script {
	'configs/*.lua',
	'tables/*.lua',
	'client.lua'
}

server_scripts {
	'configs/*.lua',
	'tables/*.lua',
	'server.lua'
}

ui_page "html/index.html"

files {
    'html/index.html',
    'html/js/*.js',
}