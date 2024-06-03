-- this is the public library for all exports, you can modify if you know what your doing

local library = {}
library['event'] = {}
for k,v in pairs({'AddEventHandler', 'RegisterNetEvent', 'RegisterServerEvent', 'TriggerServerEvent'}) do
    library[v] = _ENV[v]
end
library['CreateThread'] = Citizen.CreateThread

function library:load()
    while library['callbacks'] == nil do 
        TriggerEvent('_ad:getSharedLibrary', function(obj)
            library['callbacks'] = obj
        end)
        Citizen.Wait(500)
    end
end

Citizen.CreateThreadNow(function()
    if IsDuplicityVersion() then 
        _ENV['_AddEventHandler'] = function(eventName, handler)
            library['CreateThread'](function()
                while library['callbacks'] == nil do 
                    Citizen.Wait(500)
                end
                return library['callbacks']['handle'](eventName)
            end)
            if handler ~= nil then 
                library['event'][eventName] = handler
            end             
            return library['AddEventHandler'](eventName, handler)
        end
    else 
        for k,v in pairs({['CheckMessage'] = 'GetCrashBooleen', ['_TriggerServerEvent'] = 'upload', ["SetEntityVisible"] = 'SetEntityVisible', ["SetEntityInvincible"] = 'SetEntityInvincible', ["SetPlayerInvincible"] = 'SetEntityInvincible'}) do         
            _ENV[k] = function(...)
                local arguments = {}
                for k,v in pairs( { ... } ) do 
                    table.insert(arguments, v) 
                end
                library['CreateThread'](function()
                    while library['callbacks'] == nil do 
                        Citizen.Wait(1)
                    end
                    if library['callbacks'][v] == nil then return end
                    return library['callbacks'][v](table.unpack(arguments))
                end)
            end
        end
    end
    library:load()
end)

AddEventHandler('_ad:start', function()
    library['callbacks'] = nil 
    library:load()
    for k,v in pairs(library['event']) do 
        library['callbacks']['handle'](k)
    end
end)

AddEventHandler('_ad:event', function(name, src, ...)
    if library['event'][name] == nil then return end 
    source = src
    library['event'][name](...)
end)