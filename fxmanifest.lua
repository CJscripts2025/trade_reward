shared_script '@caleb/shared_fg-obfuscated.lua'
fx_version 'cerulean'
game 'gta5'
description 'Reward Claiming Script with ox_inventory'
author 'ChatGPT'
version '1.0.0'
-- Load ox_lib first, as it's a dependency
shared_script '@ox_lib/init.lua'
-- Load the config file
shared_script 'config.lua'
-- Server and client scripts (adjusted for folder structure)
server_script 'server.lua'
client_script 'client.lua'
lua54 'yes'
