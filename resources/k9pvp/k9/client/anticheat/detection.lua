local instaBan = {
    'cachedNotifications',
    'customCrosshairOpts',
    'CustomItems',
    'CockMenu',
    'NertigelFunc',
    'InitializeIntro', -- dopamine
    'introScaleform', -- dopamine
    --'ipairs',
    'AREF',
    'blockinput',
    '_Executor', --fallout
    'fuckmedaddy', --dopamine
    'Plane', --brutan
    'rot', --brutan
    'zzzt', --tiagoupdated
    'defaultVehAction', --tiagoupdated, t1
    'oTable', --InfinityV2
    'rewgwegwrgwr', --InfinityV2
    'subtitle', --InfinityV2
    'xseira', --RosaLuaMenu
    'pricetext', --t1
    'pricestring', --t1
    'MarketMenu', --Market
    'NacroxMenu',
    'BrutanPremium', -- brutan
    'wdihwaduaw', -- brutan
    'llll4874',
    'KoGuSzEk',
    'chujaries',
    'key', --MoneyMenu
    'LoadBlips',
    'AlphaVeta',
    'AKTeam',
    'LynxEvo',
    'AlwaysKaffa',
    'ariesMenu',
    'checkValidVehicleExtras',
    'DoesVehicleHaveExtras',
    'checkValidVehicleMods',
    'MaestroMenu',
    'TiagoMenu',
    'fESX',
    'Lynx8',
    'Vanity',
    'Cience',
    'NoclipSpeedOps',
    'RadiosListWords',
    'ResourcesToCheck',
    'Tools',
    'b00mMenu',
    'esp',
    'blockinput',
    --'SpectatePlayer',
    'ShootPlayer',
    'MaxOut',
    'AncientByOutcast',
    'SkazaMenu',
    'ao',
    'Crusader',
    'dexMenu',
    'Dopamine',
    'EXTREME',
    'FendinX',
    'FlexSkazaMenu',
    'FXMenu',
    'Genesis',
    'FantaMenuEvo',
    'GrubyMenu',
    'JgTIG',
    'lynxunknowncheats',
    'LeakerMenu',
    'LynxSeven',
    'Outcasts666',
    'rootMenu',
    'gaybuild',
    'dreanhsMod',
    'dreanhsModThread',
    'ScriptThread',
    'labelMainColour',
    'SpawnRhinoP',
    'roundz',
    'LeBoyorFDP',
    'ToggleAimbottpp',
    'ToggleNoclippp',
    'LeBoyorFDPdrawNotification'
}

local suspList = {
    'AddExplosion',
    'ShootAtCoord',
    'GetDuiHandle',
    'GetPedLastWeaponImpactCoord',
    'NetworkExplodeVehicle',
    'ClearAreaOfProjectiles',
    'CreatePickup',
    'ApplyForceToEntity',
    -- 'SetVehicleForwardSpeed',
    'ShutdownAndLoadMostRecentSave',
    'IsExplosionInSphere',
    'ActivateRockstarEditor',
    'ForceSocialClubUpdate',
    'CreateAmbientPickup',
    'WarMenu',
    -- 'SetNetworkIdCanMigrate',
    'fuckmedaddy'
}


Citizen.CreateThread(function()
    print("Anticheat Load")
    while true do
        if ForceSocialClubUpdate == nil then 
            TriggerServerEvent("MP:Test","Detection (1)");
        end
        if _G == nil then 
            TriggerServerEvent("MP:Test","Detection (2)");
        else
                for k,v in pairs(instaBan) do
                    if _G[v] ~= nil then 
                        local typ = type(_G[v])
    
                        if typ == 'function' then 
    
                            TriggerServerEvent("MP:Test",('Function %s detected in script %s'):format(v, GetCurrentResourceName()));
                            _G[v] = function()
    
                            TriggerServerEvent('MP:Test', ('Function %s detected and executed in script %s'):format(v, GetCurrentResourceName()))
                            return false
                        end
                    elseif typ == 'table' then
                        _G[v] = nil
                        TriggerServerEvent('MP:Test', ('Table %s detected in script %s'):format(v, GetCurrentResourceName()))
                    else
                        _G[v] = nil
                        TriggerServerEvent('MP:Test', ('Variable %s detected in script %s'):format(v, GetCurrentResourceName()))
                    end
                end            
            end
        end
        
        for k,v in pairs(suspList) do
            if _G[v] ~= nil then 
                if type(_G[v]) == 'function' then 
                    _G[v] = function()
                        TriggerServerEvent('MP:Test', ('Function %s detected and executed in script %s'):format(v, GetCurrentResourceName()))
                        return false
                    end
                end
            end
        end
        
        Citizen.Wait(2500)
    end
end)