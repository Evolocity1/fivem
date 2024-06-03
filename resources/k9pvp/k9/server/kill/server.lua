local listhour = {}

local allkill = {}

local function searchHour(hour)
    for i = 1, #listhour do
        if listhour[i] == hour then
            return true
        end
    end
    return false
end

local function searchIdentifierInList(identifier)
    for i = 1, #allkill do
        if allkill[i].identifier == identifier then
            return true, allkill[i]
        end
    end
end

local function addKillInList(identifier, name)
    local bool, leplayer = searchIdentifierInList(identifier)
    if bool then
        leplayer.kill = leplayer.kill + 1
    else
        table.insert(allkill, {identifier = identifier, name = name, kill = 1})
    end
end

local function removePlayerKillInList(identifier)
    for i = 1, #allkill do
        if allkill[i].identifier == identifier then
            table.remove(allkill, i)
            break
        end
    end
end

local function getPlayerBestKill()
    local bestkill, player = -1, allkill[1]
    for i = 1, #allkill do
        if allkill[i].kill > bestkill then
            bestkill, player = allkill[i].kill, allkill[i]
        end
    end
    return player
end

local reward = {
    {type = "money", name = "bank", count = 500},
    {type = "money", name = "bank", count = 1000},
    {type = "money", name = "bank", count = 1500},
    {type = "item", name = "WEAPON_ASSAULTRIFLE", count = 5},
    {type = "item", name = "WEAPON_COMBATMG", count = 2},
    {type = "item", name = "WEAPON_MG", count = 2},
    {type = "item", name = "WEAPON_TACTICALRIFLE", count = 2},
    {type = "item", name = "WEAPON_BULLPUPRIFLE", count = 3},
    {type = "item", name = "WEAPON_CARBINERIFLE", count = 5},
}
        

--[[Citizen.CreateThread(function()
    for i =1, 12 do
        local hour = i + 12 - 1
        local value = tostring(hour) .. ":00"
        table.insert(listhour, value)
    end
    table.insert(listhour, "00:00")
    while true do
        Citizen.Wait(60000)
        local _, _, _, lheure = getDate()
        if searchHour(lheure) then
            if #allkill >= 2 then
                local leplayer = getPlayerBestKill()
                local xPlayer = MP.GetPlayerFromIdentifier(leplayer.identifier)
                if not xPlayer then
                    removePlayerKillInList()
                    while not xPlayer and #allkill > 0 do
                        leplayer = getPlayerBestKill()
                        xPlayer = MP.GetPlayerFromIdentifier(leplayer.identifier)
                        if not xPlayer then
                            removePlayerKillInList()
                        end
                        Citizen.Wait(1)
                    end
                end
                if #allkill > 0 and xPlayer then
                    if leplayer.kill > 0 then
                        local lereward = reward[math.random(1, #reward)]
                        if lereward.type == "money" then
                            xPlayer.addAccountMoney(lereward.name, lereward.count)
                            -- notification chat
                        elseif lereward.type == "item" then
                            exports["k9-inventory"]:AddItem(xPlayer.source, "protected", lereward.name, lereward.count)
                            -- notification chat
                        end
                    end
                end
            end
            allkill = {}
        end
    end
end)]]

RegisterServerEvent("MP:kill")
AddEventHandler("MP:kill", function(id, causes, weapon)
    local xPlayer = MP.Player[source]
    local xTarget = MP.Player[id]
    local cause = causes ~= nil and causes or "Inconnu"
    print(source, " est mort par ", id)
    xPlayer.AddStats("pvp", "death")
    
    exports["k9-inventory"]:AddStats(xPlayer.identifier, "pvp", "death")
    xPlayer.combokill = 0
    if MP.InRedzone(GetEntityCoords(GetPlayerPed(xPlayer.source))) and xPlayer.ModeDeJeu == "pvp" then
        xPlayer.AddStats("redzone", "death")
        exports["k9-inventory"]:AddStats(xPlayer.identifier, "redzone", "death")
    end
    if MP.InDarkzone(GetEntityCoords(GetPlayerPed(xPlayer.source))) and xPlayer.ModeDeJeu == "pvp" then
        xPlayer.AddStats("darkzone", "death")
        exports["k9-inventory"]:AddStats(xPlayer.identifier, "darkzone", "death")
    end
    if xPlayer.ModeDeJeu == "deathmatch" or xPlayer.ModeDeJeu == "gungame" then
          xPlayer.AddStats(xPlayer.ModeDeJeu, "death")
          exports["k9-inventory"]:AddStats(xPlayer.identifier, xPlayer.ModeDeJeu, "kill")
          local coords = arenarespawn[arenaactuel[xPlayer.ModeDeJeu]][math.random(1,#arenarespawn[arenaactuel[xPlayer.ModeDeJeu]])]
          SetEntityCoords(GetPlayerPed(xPlayer.source), vector3(coords.x, coords.y, coords.z - 1.0))
          xPlayer.anciencoords = coords
          if xPlayer.ModeDeJeu == "gungame" then
          		GiveWeaponToPed(GetPlayerPed(xPlayer.source), GetHashKey(listweapon["gungame"][GetKillInArena("gungame", xPlayer.source)]), 250, false, true)
          end
    end
    if xPlayer.ModeDeJeu == "deluxotricks" then
         xPlayer.AddStats("deluxoarena", "death")
            exports["k9-inventory"]:AddStats(xPlayer.identifier, "deluxoarena", "kill")
    end
    local idxtarget = xTarget and xTarget.source or 0
    TriggerClientEvent("MP:DrawBlips", -1, GetEntityCoords(GetPlayerPed(xPlayer.source)), xPlayer.source, idxtarget)
    if xTarget then
        local nbargent = 0
        if xTarget.ModeDeJeu == "pvp" then
            nbargent = xTarget.isvip and 75 or 30
        	xTarget.addAccountMoney("bank", nbargent)
        end
        xTarget.showNotification("You killed ~r~" ..xPlayer.name.. "~s~ ["..xPlayer.idunique.."]")
        xTarget.showNotification("You earn ~g~"..nbargent.."$")
        xTarget.AddStats("pvp", "kill")
        exports["k9-inventory"]:AddStats(xTarget.identifier, "pvp", "kill")
        addKillInList(xTarget.identifier, xTarget.name)
        if MP.InDarkzone(GetEntityCoords(GetPlayerPed(xTarget.source))) and xTarget.ModeDeJeu == "pvp" then
            xTarget.AddStats("darkzone", "kill")
            exports["k9-inventory"]:AddStats(xTarget.identifier, "darkzone", "kill")
        end
        if xTarget.HasDefi(1) then
            xTarget.CompleteDefi(1, 1)
        end
        xTarget.combokill = xTarget.combokill + 1
            
        if xTarget.ModeDeJeu == "deathmatch" or xTarget.ModeDeJeu == "gungame" then
              xTarget.AddStats(xTarget.ModeDeJeu, "kill")
              exports["k9-inventory"]:AddStats(xTarget.identifier, xTarget.ModeDeJeu, "kill")
              local lereturn = AddKillInArena(xTarget.ModeDeJeu, xTarget.source)
              if xTarget.ModeDeJeu == "gungame" then
                    if listweapon["gungame"][lereturn] then
                        RemoveWeaponFromPed(GetPlayerPed(xTarget.source), GetHashKey(string.upper(listweapon["gungame"][lereturn - 1])))
                        exports["k9-inventory"]:RemoveItem(xTarget.source, "inventory", string.upper(listweapon["gungame"][lereturn - 1]), 1)
                        exports["k9-inventory"]:AddItem(xTarget.source, "inventory", string.upper(listweapon["gungame"][lereturn]), 1, "Changement d'arme en gungame")
                        GiveWeaponToPed(GetPlayerPed(xTarget.source), GetHashKey(string.upper(listweapon["gungame"][lereturn])), 250, false, true)
                    else
                        WinGungame(xTarget)
                    end
              end
        end
        if xTarget.ModeDeJeu == "deluxotricks" then
             xTarget.AddStats("deluxoarena", "kill")
             exports["k9-inventory"]:AddStats(xTarget.identifier, "deluxoarena", "kill")
        end
        xTarget.addXp(75)
        --TriggerClientEvent("MP:AddChat", -1, "~r~"..GetPlayerName(id).. " ~s~à éliminé ~r~" ..GetPlayerName(source).. " ~s~avec un ~r~ " ..cause.. " ~r~ (" ..MP.Round(#(GetEntityCoords(GetPlayerPed(source))-GetEntityCoords(GetPlayerPed(id))), 2).. "m)")
        for k, v in pairs(MP.Player) do
            if v.ModeDeJeu == xPlayer.ModeDeJeu then
        		TriggerClientEvent("MP:AddKillfeed", v.source, {comboCount = xTarget.combokill, distance = MP.Round(#(GetEntityCoords(GetPlayerPed(source))-GetEntityCoords(GetPlayerPed(id))), 2), attackerId = xTarget.source, victimId = xPlayer.source, assistId = xPlayer.source, attackerName = xTarget.name, attackerPP = xTarget.ppsteam, weaponHash = weapon or 0, victimName = xPlayer.name, victimPP = xPlayer.ppsteam})
            end
        end
    else
        --TriggerClientEvent("MP:AddChat", -1, "~r~"..GetPlayerName(source).. " ~s~est mort ~r~(" ..cause.. ") ~s~")
    end
end)

RegisterServerEvent("MP:Killcam")
AddEventHandler("MP:Killcam", function(data)
       local xPlayer = MP.Player[source]
       local xTarget = MP.Player[tonumber(data.id)]
       if xTarget then
            TriggerClientEvent("MP:showKillcam", source, {name = xTarget.name, health = data.health, armor = data.armor, hashweapon = data.weaponHash, pp = xTarget.ppsteam}, xTarget.deathmessage, "["..xTarget.idunique.."] " ..xTarget.name)
       end
end)

RegisterServerEvent("wais:s:writehit")
AddEventHandler("wais:s:writehit", function(attackerid, victimid, hit, victimDied, bonehash)
        TriggerClientEvent("wais:c:writehit", attackerid, victimid, hit, victimDied, bonehash)
end)