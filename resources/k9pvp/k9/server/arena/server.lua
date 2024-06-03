Citizen.CreateThread(function()
        while true do
            local random = tostring(math.random(1,3))
            arenaactuel["deathmatch"] = random
            arenablipactuel["deathmatch"] = random
            for k, v in pairs(MP.Player) do
                if v.ModeDeJeu == "deathmatch" then
                    local coords = arenarespawn[random][math.random(1,#arenarespawn[random])]
                    v.istp = true
                    SetEntityCoords(GetPlayerPed(v.source), coords)
                    
                    v.showNotification("New Arena")
                end
            end
            Citizen.Wait(30 * 60 * 1000)
        end
end)

function WinGungame(xTarget)
    local random = tostring(math.random(1,3))
    arenaactuel["deathmatch"] = random
    arenablipactuel["deathmatch"] = random
    xTarget.showNotification("~g~You have win gungame")
    for k, v in pairs(MP.Player) do
        if v.ModeDeJeu == "gungame" and v.source ~= xTarget.source then
            v.showNotification(xTarget.name.. " win a gungame")
        end
        if v.ModeDeJeu == "gungame" then
            exports["k9-inventory"]:ClearInventory(v.source, "inventory")
            exports["k9-inventory"]:AddItem(v.source, "inventory", listweapon["gungame"][1], 1, "Win Gungame")
            GiveWeaponToPed(GetPlayerPed(v.source), GetHashKey(listweapon["gungame"][1]), 250, false, true)
            local coords = arenarespawn[random][math.random(1,#arenarespawn[random])]
            v.istp = true
            SetEntityCoords(GetPlayerPed(v.source), coords)
            
        end
    end
end

RegisterServerEvent("MP:GoArena")
AddEventHandler("MP:GoArena", function(name)
        if name == nil then return end
        if name == "battleroyale" then return end
        if listweapon[name] == nil then return end
        local xPlayer = MP.Player[source]
        if xPlayer.cheatermonde then xPlayer.showNotification("~r~You are in cheater world") return end
        if xPlayer.ModeDeJeu ~= "pvp" then xPlayer.showNotification("You are not in pvp") return end
        if not MP.IsInSafezone(GetEntityCoords(GetPlayerPed(source))) then xPlayer.showNotification("You are not in safezone") return end
        local bool, lemode = MP.GetModeDeJeu(name)
        if not bool then return end
        MP.MooveAllItemInProtected(xPlayer.source)
        MP.ChangeModeDeJeu(xPlayer.source, name)
        if name ~= "deluxotricks" then
            local coords = arenarespawn[arenaactuel[name]][math.random(1,#arenarespawn[arenaactuel[name]])]
            xPlayer.istp = true
            SetEntityCoords(GetPlayerPed(xPlayer.source), coords)
        end
        if name ~= "gungame" then
            for i = 1, #listweapon[name] do
                exports["k9-inventory"]:AddItem(xPlayer.source, "inventory", name == "deathmatch" and string.upper(listweapon[name][i]) or listweapon[name][i], 1, "Go arena deathmatch/all")
            end
        else
            exports["k9-inventory"]:AddItem(xPlayer.source, "inventory", string.upper(listweapon[name][1]), 1, "Go arena gungame")
            GiveWeaponToPed(GetPlayerPed(xPlayer.source), GetHashKey(listweapon[name][1]),250, false, true)
        end
end)