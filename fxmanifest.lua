fx_version 'cerulean'
game 'gta5'

-- Vereisen dat Lua 5.4 wordt gebruikt
lua54 'yes'

-- Andere configuratie...
client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

-- Andere instellingen en afhankelijkheden
dependency 'ox_lib'
shared_script '@ox_lib/init.lua'