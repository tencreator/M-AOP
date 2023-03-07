--Partial Code Taken From https://github.com/LGDevelopment/Lances-AOP I would like to thank him as if this didn't exist it would be a LOT harder to make this resource.

fx_version 'cerulean'
game 'gta5'

author 'FuriousFoxGG.'
description 'A Simple AOP script for FiveM, usage /aop [AOP]'
version 'BETA - v0.5.0'

-------------------------------------
-------------- Shared ---------------
-------------------------------------

shared_scripts {
    'config.lua'
}

-------------------------------------
-------------- Client ---------------
-------------------------------------

client_scripts {
    'client.lua',
    '@PolyZone/client.lua',
}

-------------------------------------
-------------- Server ---------------
-------------------------------------

server_scripts {
    'server.lua'
}

-------------------
----- Exports -----
-------------------

exports {

}