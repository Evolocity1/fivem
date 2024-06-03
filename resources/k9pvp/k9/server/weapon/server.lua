local allweapon = {}
local function searchWeapon(idunique, name)
    for i = 1, #allweapon do
        if allweapon[i].idunique == idunique and allweapon[i].weapon == name then
            return true, allweapon[i]
        end
    end
    return false
end

local function isaelreadyComponentfromweapon(component, autrecompenent)
    for i = 1, #component do
        if component[i] == autrecompenent then
            return true
        end
    end
    return false
end

local function getAllWeapon(idunique)
    local list = {}
    for i = 1, #allweapon do
        if allweapon[i].idunique == idunique then
            table.insert(list, allweapon[i])
        end
    end
    return list
end
    
CreateThread(function()
    MySQL.Async.fetchAll("SELECT * FROM MP_weapon", {}, function(result)
        allweapon = result
        for i = 1, #allweapon do
              allweapon[i].weaponcomponent = json.decode(allweapon[i].weaponcomponent)
        end
                Citizen.Wait(1000)
        local players = GetPlayers()
        for i = 1, #players do
             	TriggerClientEvent("MP:AddAllWeapon", players[i], getAllWeapon(1))
        end
    end)
end)

RegisterServerEvent("MP:AddComponentWeapon")
AddEventHandler("MP:AddComponentWeapon", function(weaponname, weaponhash)
     local xPlayer = MP.Player[source]
     local bool, leweapon = searchWeapon(xPlayer.idunique, weaponname)
     if not bool then
          table.insert(allweapon, {idunique = xPlayer.idunique, weapon = weaponname, weaponcomponent = {weaponhash}})
          MySQL.Async.execute("INSERT INTO MP_weapon (idunique, weapon, weaponcomponent) VALUES (@idunique, @weapon, @weaponcomponent)", {
                ['@idunique'] = xPlayer.idunique,
                ['@weapon'] = weaponname,
                ['@weaponcomponent'] = json.encode({weaponhash}),
            })
     else
            if isaelreadyComponentfromweapon(leweapon.weaponcomponent, weaponhash) then return end
            table.insert(leweapon.weaponcomponent, weaponhash)
            MySQL.Async.execute('UPDATE MP_weapon SET weaponcomponent = @weaponcomponent WHERE idunique = @idunique AND weapon = @weapon', {
                ['@weaponcomponent'] = json.encode(leweapon.weaponcomponent),
                ['@idunique'] = xPlayer.idunique,
                ['@weapon'] = weaponname
            })
     end
     TriggerClientEvent("MP:AddAllWeapon", xPlayer.source, getAllWeapon(xPlayer.idunique))
end)

RegisterServerEvent("MP:RemoveComponentWeapon")
AddEventHandler("MP:RemoveComponentWeapon", function(weaponname, weaponhash)
     local xPlayer = MP.Player[source]
     local bool, leweapon = searchWeapon(xPlayer.idunique, weaponname)
     if bool then
            for i = 1, #leweapon.weaponcomponent do
                if leweapon.weaponcomponent[i] == weaponhash then
                    table.remove(leweapon.weaponcomponent, i)
                    MySQL.Async.execute('UPDATE MP_weapon SET weaponcomponent = @weaponcomponent WHERE idunique = @idunique AND weapon = @weapon', {
                        ['@weaponcomponent'] = json.encode(leweapon.weaponcomponent),
                        ['@idunique'] = xPlayer.idunique,
                        ['@weapon'] = weaponname
                    })
                    break
                end
          end
     end
     TriggerClientEvent("MP:AddAllWeapon", xPlayer.source, getAllWeapon(xPlayer.idunique))
end)

RegisterServerEvent("MP:PlayerLoad")
AddEventHandler("MP:PlayerLoad", function(playerid, xPlayer)
        TriggerClientEvent("MP:AddAllWeapon", xPlayer.source, getAllWeapon(xPlayer.idunique))
end)