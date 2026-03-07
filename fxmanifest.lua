fx_version 'cerulean'
game { 'gta5' }


author 'JD'
description 'JD Library'
version '1.0.0'

ui_page 'modules/notify/html/index.html'

files {
    'modules/notify/html/index.html',
    'modules/notify/html/style.css',
    'modules/notify/html/app.js',
    'modules/noti-menu/noti-menu.css',  
    'modules/noti-menu/noti-menu.js', 
}

server_scripts {
    'addons/joinserver-event/*.lua',
    'addons/*.lua',

}

shared_scripts {
    'shared/lib.lua',    
}

client_scripts {
    'modules/notify/client.lua',
    'modules/noti-menu/client.lua', 
    'addons/joinserver-event/*.lua',
    'client/main.lua',
    'addons/*.lua',
}
