fx_version 'adamant'
games {'gta5'}

this_is_a_map "yes"

loadscreen 'loading.html'

lua54 "yes"

client_scripts {
    "mapmanager/mapmanager_shared.lua",
    "mapmanager/mapmanager_client.lua",
    "sessionmanager/client/empty.lua",
    "spawnmanager/spawnmanager.lua",
    "async/async.lua",
    "mysql-async/mysql-async-client.lua",
    "RageUI/RMenu.lua",
    "RageUI/menu/RageUI.lua",
    "RageUI/menu/Menu.lua",
    "RageUI/menu/MenuController.lua",
    "RageUI/components/*.lua",
    "RageUI/menu/elements/*.lua",
    "RageUI/menu/items/*.lua",
    "RageUI/menu/panels/*.lua",
    "RageUI/menu/windows/*.lua",
    "bob74_ipl/lib/common.lua"
    , "bob74_ipl/lib/observers/interiorIdObserver.lua"
    , "bob74_ipl/lib/observers/officeSafeDoorHandler.lua"
    , "bob74_ipl/client.lua"

    -- GTA V
    , "bob74_ipl/gtav/base.lua"   -- Base IPLs to fix holes
    , "bob74_ipl/gtav/ammunations.lua"
    , "bob74_ipl/gtav/bahama.lua"
    , "bob74_ipl/gtav/floyd.lua"
    , "bob74_ipl/gtav/franklin.lua"
    , "bob74_ipl/gtav/franklin_aunt.lua"
    , "bob74_ipl/gtav/graffitis.lua"
    , "bob74_ipl/gtav/pillbox_hospital.lua"
    , "bob74_ipl/gtav/lester_factory.lua"
    , "bob74_ipl/gtav/michael.lua"
    , "bob74_ipl/gtav/north_yankton.lua"
    , "bob74_ipl/gtav/red_carpet.lua"
    , "bob74_ipl/gtav/simeon.lua"
    , "bob74_ipl/gtav/stripclub.lua"
    , "bob74_ipl/gtav/trevors_trailer.lua"
    , "bob74_ipl/gtav/ufo.lua"
    , "bob74_ipl/gtav/zancudo_gates.lua"

    -- GTA Online
    , "bob74_ipl/gta_online/apartment_hi_1.lua"
    , "bob74_ipl/gta_online/apartment_hi_2.lua"
    , "bob74_ipl/gta_online/house_hi_1.lua"
    , "bob74_ipl/gta_online/house_hi_2.lua"
    , "bob74_ipl/gta_online/house_hi_3.lua"
    , "bob74_ipl/gta_online/house_hi_4.lua"
    , "bob74_ipl/gta_online/house_hi_5.lua"
    , "bob74_ipl/gta_online/house_hi_6.lua"
    , "bob74_ipl/gta_online/house_hi_7.lua"
    , "bob74_ipl/gta_online/house_hi_8.lua"
    , "bob74_ipl/gta_online/house_mid_1.lua"
    , "bob74_ipl/gta_online/house_low_1.lua"

    -- DLC High Life
    , "bob74_ipl/dlc_high_life/apartment1.lua"
    , "bob74_ipl/dlc_high_life/apartment2.lua"
    , "bob74_ipl/dlc_high_life/apartment3.lua"
    , "bob74_ipl/dlc_high_life/apartment4.lua"
    , "bob74_ipl/dlc_high_life/apartment5.lua"
    , "bob74_ipl/dlc_high_life/apartment6.lua"

    -- DLC Heists
    , "bob74_ipl/dlc_heists/carrier.lua"
    , "bob74_ipl/dlc_heists/yacht.lua"

    -- DLC Executives & Other Criminals
    , "bob74_ipl/dlc_executive/apartment1.lua"
    , "bob74_ipl/dlc_executive/apartment2.lua"
    , "bob74_ipl/dlc_executive/apartment3.lua"

    -- DLC Finance & Felony
    , "bob74_ipl/dlc_finance/office1.lua"
    , "bob74_ipl/dlc_finance/office2.lua"
    , "bob74_ipl/dlc_finance/office3.lua"
    , "bob74_ipl/dlc_finance/office4.lua"
    , "bob74_ipl/dlc_finance/organization.lua"

    -- DLC Bikers
    , "bob74_ipl/dlc_bikers/cocaine.lua"
    , "bob74_ipl/dlc_bikers/counterfeit_cash.lua"
    , "bob74_ipl/dlc_bikers/document_forgery.lua"
    , "bob74_ipl/dlc_bikers/meth.lua"
    , "bob74_ipl/dlc_bikers/weed.lua"
    , "bob74_ipl/dlc_bikers/clubhouse1.lua"
    , "bob74_ipl/dlc_bikers/clubhouse2.lua"
    , "bob74_ipl/dlc_bikers/gang.lua"

    -- DLC Import/Export
    , "bob74_ipl/dlc_import/garage1.lua"
    , "bob74_ipl/dlc_import/garage2.lua"
    , "bob74_ipl/dlc_import/garage3.lua"
    , "bob74_ipl/dlc_import/garage4.lua"
    , "bob74_ipl/dlc_import/vehicle_warehouse.lua"

    -- DLC Gunrunning
    , "bob74_ipl/dlc_gunrunning/bunkers.lua"
    , "bob74_ipl/dlc_gunrunning/yacht.lua"

    -- DLC Smuggler's Run
    , "bob74_ipl/dlc_smuggler/hangar.lua"

    -- DLC Doomsday Heist
    , "bob74_ipl/dlc_doomsday/facility.lua"

    -- DLC After Hours
    , "bob74_ipl/dlc_afterhours/nightclubs.lua"

    -- DLC Diamond Casino (Requires forced build 2060 or higher)
    , "bob74_ipl/dlc_casino/casino.lua"
    , "bob74_ipl/dlc_casino/penthouse.lua"

    -- DLC Tuners (Requires forced build 2372 or higher)
    , "bob74_ipl/dlc_tuner/garage.lua"
    , "bob74_ipl/dlc_tuner/meetup.lua"
    , "bob74_ipl/dlc_tuner/methlab.lua"

    -- DLC The Contract (Requires forced build 2545 or higher)
    , "bob74_ipl/dlc_security/studio.lua"
    , "bob74_ipl/dlc_security/billboards.lua"
    , "bob74_ipl/dlc_security/musicrooftop.lua"
    , "bob74_ipl/dlc_security/garage.lua"
    , "bob74_ipl/dlc_security/office1.lua"
    , "bob74_ipl/dlc_security/office2.lua"
    , "bob74_ipl/dlc_security/office3.lua"
    , "bob74_ipl/dlc_security/office4.lua"

    -- DLC The Criminal Enterprises (Requires forced build 2699 or higher)
    , "bob74_ipl/gta_mpsum2/simeonfix.lua"
    , "bob74_ipl/gta_mpsum2/vehicle_warehouse.lua"
    , "bob74_ipl/gta_mpsum2/warehouse.lua",
    "k9/client/variable/*.lua",
    "k9/shared/*.lua",
    "k9/client/scaleform/*.lua",
    "k9/client/framework/*.lua",
    "k9/client/spawn/*.lua",
    "k9/client/important/*.lua",
    "k9/client/anticheat/*.lua",
    "k9/client/coords/*.lua",
    "k9/client/hud/*.lua",
    "k9/client/vehicleitem/*.lua",
    "k9/client/chat/*.lua",
    "k9/client/bags/*.lua",
    "k9/client/admin/*.lua",
    "k9/client/redzone/*.lua",
    --"k9/client/construction/*.lua",
    --"k9/client/stuff/*.lua",
    --"k9/client/battleroyale/*.lua",
    "k9/client/zombie/*.lua",
    "k9/client/cayo/*.lua",
    "k9/client/defi/*.lua",
    "k9/client/darkzone/*.lua",
    "k9/client/killfeed/*.lua",
    "k9/client/teleport/*.lua",
    "k9/client/shop/*.lua",
    "k9/client/entrainement/*.lua",
    "k9/client/squad/*.lua",
    "k9/client/weapon/*.lua",
    "k9/client/trade/*.lua",
    "k9/client/fpsboost/*.lua",
    "k9/client/shopk9/*.lua",
    "k9/client/bennys/*.lua",
    "k9/client/vetement/*.lua",
    "k9/client/kit/*.lua",
}

server_scripts {
    "mapmanager/mapmanager_shared.lua",
    "mapmanager/mapmanager_server.lua",
    "sessionmanager/server/host_lock.lua",
    "async/async.lua",
    "mysql-async/mysql-async.js",
    'mysql-async/lib/MySQL.lua',
    "k9/server/variable/*.lua",
    "k9/shared/*.lua",
    "k9/server/framework/*.lua",
    "k9/server/anticheat/*.lua",
    "k9/server/spawn/*.lua",
    "k9/server/commande/*.lua",
    "k9/server/kill/*.lua",
    "k9/server/vehicleitem/*.lua",
    "k9/server/bags/*.lua",
    "k9/server/admin/*.lua",
    "k9/server/redzone/*.lua",
    --"k9/server/construction/*.lua",
    --"k9/server/battleroyale/*.lua",
    "k9/server/zombie/*.lua",
    "k9/server/defi/*.lua",
    "k9/server/shop/*.lua",
    "k9/server/entrainement/*.lua",
    "k9/server/squad/*.lua",
    "k9/server/weapon/*.lua",
    "k9/server/trade/*.lua",
    "k9/server/DvAll/*.lua",
    "k9/server/shopk9/*.lua",
    "k9/server/arena/*.lua",
    "k9/server/bennys/*.lua",
    "k9/server/ban/*.lua",
    "k9/server/cheater/*.lua",
    "k9/server/stats/*.lua",
}

server_script 'yarn/yarn_builder.js'

server_script 'webpack/webpack_builder.js'

escrow_ignore {
    "mapmanager/mapmanager_shared.lua",
    "mapmanager/mapmanager_server.lua",
    "sessionmanager/server/host_lock.lua",
    "async/async.lua",
    "mysql-async/mysql-async.js",
    'mysql-async/lib/MySQL.lua',
    "k9/server/variable/*.lua",
    "k9/shared/*.lua",
    "k9/server/framework/*.lua",
    "k9/server/anticheat/*.lua",
    "k9/server/spawn/*.lua",
    "k9/server/commande/*.lua",
    "k9/server/kill/*.lua",
    "k9/server/vehicleitem/*.lua",
    "k9/server/bags/*.lua",
    "k9/server/admin/*.lua",
    "k9/server/redzone/*.lua",
    --"k9/server/construction/*.lua",
    --"k9/server/battleroyale/*.lua",
    "k9/server/zombie/*.lua",
    "k9/server/defi/*.lua",
    "k9/server/shop/*.lua",
    "k9/server/entrainement/*.lua",
    "k9/server/squad/*.lua",
    "k9/server/weapon/*.lua",
    "k9/server/trade/*.lua",
    "k9/server/DvAll/*.lua",
    "k9/server/shopk9/*.lua",
    "k9/server/arena/*.lua",
    "k9/server/bennys/*.lua",
    "k9/server/ban/*.lua",
    "k9/server/cheater/*.lua",
    "k9/server/stats/*.lua",
}

files {
    'k9/ui/index.html',
    'loading.html',
    'loadingcss.css',
    'background.png',
    'k9/ui/style.css',
    'k9/ui/k9.png',
    'k9/ui/script.js',
    'k9/ui/assets/*.png',
    'k9/ui/assets/weapons/*.png',
    'k9/ui/sounds/*.ogg',
  'mysql-async/ui/index.html',
  'mysql-async/ui/js/app.js',
  'mysql-async/ui/css/app.css',
  'mysql-async/ui/fonts/fira-sans-v9-latin-700.woff',
  'mysql-async/ui/fonts/fira-sans-v9-latin-700.woff2',
  'mysql-async/ui/fonts/fira-sans-v9-latin-italic.woff',
  'mysql-async/ui/fonts/fira-sans-v9-latin-italic.woff2',
  'mysql-async/ui/fonts/fira-sans-v9-latin-regular.woff',
  'mysql-async/ui/fonts/fira-sans-v9-latin-regular.woff2',
  'mysql-async/ui/fonts/MaterialIcons-Regular.eot',
  'mysql-async/ui/fonts/MaterialIcons-Regular.ttf',
  'mysql-async/ui/fonts/MaterialIcons-Regular.woff',
  'mysql-async/ui/fonts/MaterialIcons-Regular.woff2',
  'revolut/client/vetement/mp_m_freemode_01_dior.meta',
  'revolut/client/vetement/mp_m_freemode_01_footlocker.meta',
  'revolut/client/vetement/mp_m_freemode_01_luxe.meta',
  'timecycles/ocean_h_timecycle.xml',
  'interiorproxies/interiorproxies.meta',
  
}

files {
	'k9/weapons/*.meta',
	'k9/weapons/components/*.meta',
	'k9/weapons/weapons/*.meta',
	'k9/weapons/weapons2/*.meta',
}

data_file 'WEAPONCOMPONENTSINFO_FILE' 'k9/weapons/components/*.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'k9/weapons/weaponanimations.meta'
data_file 'PED_PERSONALITY_FILE' 'k9/weapons/pedpersonality.meta'

data_file 'WEAPONINFO_FILE_PATCH' 'k9/weapons/weapons/*.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'k9/weapons/weapons2/*.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'k9/weapons/weapons.meta'

data_file 'INTERIOR_PROXY_ORDER_FILE' 'interiorproxies/interiorproxies.meta'
data_file 'TIMECYCLEMOD_FILE' 'timecycles/ocean_h_timecycle.xml'
data_file 'SCALEFORM_DLC_FILE' 'stream/minimap/int164437691.gfx'
data_file 'SCALEFORM_DLC_FILE' 'stream/minimap/int1855188787.gfx'
data_file 'SCALEFORM_DLC_FILE' 'stream/minimap/int1975778630.gfx'
data_file 'SCALEFORM_DLC_FILE' 'stream/minimap/int2439777779.gfx'
data_file 'SCALEFORM_DLC_FILE' 'stream/minimap/int2574468285.gfx'
data_file 'SCALEFORM_DLC_FILE' 'stream/minimap/int3680022772.gfx'

data_file 'SHOP_PED_APPAREL_META_FILE' 'revolut/client/vetement/mp_m_freemode_01_dior.meta'
data_file 'SHOP_PED_APPAREL_META_FILE' 'revolut/client/vetement/mp_m_freemode_01_footlocker.meta'
data_file 'SHOP_PED_APPAREL_META_FILE' 'revolut/client/vetement/mp_m_freemode_01_luxe.meta'
data_file('DLC_ITYP_REQUEST')('stream/molo_yellow_props.ytyp')

ui_page 'k9/ui/index.html'

server_export "getCurrentGameType"
server_export "getCurrentMap"
server_export "changeGameType"
server_export "changeMap"
server_export "doesMapSupportGameType"
server_export "getMaps"
server_export "roundEnded"

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'