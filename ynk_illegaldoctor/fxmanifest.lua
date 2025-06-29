fx_version 'cerulean'
game 'gta5'

lua54 'yes'

shared_script '@ox_lib/init.lua'

server_script 'server.lua'

client_scripts{
    'config.lua',
    'client.lua'
}

server_scripts {
    '@es_extended/imports.lua',
}
