fx_version 'cerulean'
game 'gta5'
client_script {
	"config/items.lua",
	"config/clientconfig.lua",
	'client/*.lua',
}
server_script {
	'@k9pvp/mysql-async/lib/MySQL.lua',
	"config/items.lua",
	"config/serverconfig.lua",
	"server/*.lua",
}
ui_page "nui/index.html"

files {
	"config/jsconfig.json",
	'nui/index.html',
	'nui/script.js',
	'nui/css/*.css',
	'nui/assets/**/*.png',
}
lua54 'yes'
escrow_ignore {
	"server/*.lua",
}