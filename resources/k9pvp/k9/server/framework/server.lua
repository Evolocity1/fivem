exports("getSharedObject", function()
    return MP
end)
Citizen.CreateThread(function()
    for i = 1, 10 do
        SetRoutingBucketPopulationEnabled(i, false)
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for k, v in pairs(MP.Player) do
            MP.SetPlayerRoutingBucket(v.source, 0)
        end
    end
end)

function MP.IsInSafezone(coordss)
    for i = 1, #Config.Safezone do
		if #(coordss-vector3(Config.Safezone[i].coords.x, Config.Safezone[i].coords.y, Config.Safezone[i].coords.z)) < Config.Safezone[i].dist then
		    return true
		 end
	end 
	return false
end

function MP.InDarkzone(coords)
    return (#(coords-vector3(4840.571, -5174.425, 2.0)) <= 2000.0)
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        for k, v in pairs(MP.Player) do
                
            if v.ModeDeJeu == "pvp" then
                local bool = MP.IsInSafezone(GetEntityCoords(GetPlayerPed(v.source)))
                local vehicle = GetVehiclePedIsIn(GetPlayerPed(v.source), false)
                if (bool and not v.inSafezone) then
                    local idsafezone = v.cheatermonde and 8 or 1
                    v.inSafezone = true
                    if vehicle ~= 0 then
                        
                        SetEntityRoutingBucket(vehicle, idsafezone)
                    end
                    MP.SetPlayerRoutingBucket(v.source, idsafezone)
                elseif (not bool and v.inSafezone) then
                    local idpvp = v.cheatermonde and 9 or 2
                    v.inSafezone = false
                    if vehicle ~= 0 then
                        
                        SetEntityRoutingBucket(vehicle, idpvp)
                    end
                    MP.SetPlayerRoutingBucket(v.source, idpvp)
                    
                end
            elseif v.ModeDeJeu == "gungame" or v.ModeDeJeu == "deathmatch" then
                   if #(GetEntityCoords(GetPlayerPed(v.source))-arenablip[arenablipactuel[v.ModeDeJeu]].coords) >= arenablip[arenablipactuel[v.ModeDeJeu]].radius then
                            local coords = arenarespawn[arenaactuel[v.ModeDeJeu]][math.random(1,#arenarespawn[arenaactuel[v.ModeDeJeu]])]
                            SetEntityCoords(GetPlayerPed(v.source), coords)
                            v.anciencoords = coords
                   end
            end
        end
        for i = 1, #GetAllVehicles() do
                local vehicle = GetAllVehicles()[i]
                local b, c = NetworkGetEntityOwner(vehicle)
                local idpvpveh, idsafeveh = 2, 1
                if b then
                    local xPlayer = MP.Player[tonumber(b)]
                   	if xPlayer then
                        if xPlayer.cheatermonde then
                            idpvpveh, idsafeveh = 9, 8
                        end
                    end
                end
                local bool = MP.IsInSafezone(GetEntityCoords(vehicle))
                if bool and GetEntityRoutingBucket(vehicle) == 2 then
                    SetEntityRoutingBucket(vehicle, idsafeveh)
                elseif not bool and GetEntityRoutingBucket(vehicle) == 1 then
                    SetEntityRoutingBucket(vehicle, idpvpveh)
                end
        end
                
                
    end
end)

local function searchPlayerInAttenteBattleRoyale(id)
    for i = 1, #MP.AttenteBattleRoyale do
        if MP.AttenteBattleRoyale[i].source == id then
            return true, MP.AttenteBattleRoyale[i], i
        end
    end
end

local function addPlayerInAttenteBattleRoyale(info)
    local bool = searchPlayerInAttenteBattleRoyale(info.source)
    if not bool then
        table.insert(MP.AttenteBattleRoyale, info)
    end
end

local function deletePlayerInAttenteBattleRoyale(id)
    local bool, _, i = searchPlayerInAttenteBattleRoyale(id)
    if bool then
        table.remove(MP.AttenteBattleRoyale, i)
    end
end

RegisterCommand("leave", function(source, args)
    local xPlayer = MP.Player[source]
    if xPlayer.ModeDeJeu == "lobby" then xPlayer.showNotification("~r~You are already in the lobby") return end
    if xPlayer.ModeDeJeu == "pvp" and not MP.InDarkzone(GetEntityCoords(GetPlayerPed(xPlayer.source))) then xPlayer.showNotification("~r~You are already in the pvp") return end
    if (xPlayer.ModeDeJeu ~= "battleroyale" or not MP.GameBattleRoyaleLancer) then
        if xPlayer.ModeDeJeu == "battleroyale" then
            deletePlayerInAttenteBattleRoyale(xPlayer.source)
        end
        if xPlayer.ModeDeJeu == "deluxotricks" or xPlayer.ModeDeJeu == "gungame" or xPlayer.ModeDeJeu == "deathmatch" then
                exports["k9-inventory"]:ClearInventory(xPlayer.source, "inventory")
        end
        xPlayer.ModeDeJeu = "pvp"
        local idsafezone = xPlayer.cheatermonde and 8 or 1
        MP.SetPlayerRoutingBucket(xPlayer.source, idsafezone)
        TriggerClientEvent("MP:ChangeModeDeJeu", xPlayer.source, "pvp")
        local coords = MP.GetClosestSafezone(GetEntityCoords(GetPlayerPed(xPlayer.source)))
        SetEntityCoords(GetPlayerPed(xPlayer.source), coords)
        MP.SendWebhook("Retour PVP", GetPlayerName(xPlayer.source) .. " vient de retourné pvp", "Identifier : " ..xPlayer.identifier, "https://discord.com/api/webhooks/1182683326566371349/eXQqum7hxDUiryU8OJcsWvZ-xygiR4dgbjHBGO167bGc-R6GNWkZz2anCB-MEcNJbVLu")
    end
end)

RegisterCommand("deathmessage", function(source, args)
        local xPlayer = MP.Player[source]
        if not xPlayer.isvip then xPlayer.showNotification("~r~You have not vip") return end
        local arg = ""
        for k,v in pairs(args) do
            arg = arg..v.. " " 
        end
        if arg == nil or arg == "" then xPlayer.showNotification("~r~Error") return end
        if string.len(arg) >= 50 then xPlayer.showNotification("~r~The deathmessage is too long") return end
        xPlayer.deathmessage = arg
end)

RegisterCommand("mutevoice", function(source, args)
    local idunique = tonumber(args[1])
    if idunique == nil then return end
    local xPlayer = MP.Player[source]
    if xPlayer.group == "user" then return end
    local xTarget = MP.GetPlayerFromIdUnique(idunique)
    if xTarget then
            MumbleSetPlayerMuted(xTarget.source, true)
            xTarget.showNotification("~r~You are muted")
            xPlayer.showNotification("~r~Player "..xTarget.name.. " is muted")
    else
        xPlayer.showNotification("~r~Player is not online")
    end
end)

RegisterCommand("demutevoice", function(source, args)
    local idunique = tonumber(args[1])
    if idunique == nil then return end
    local xPlayer = MP.Player[source]
    if xPlayer.group == "user" then return end
    local xTarget = MP.GetPlayerFromIdUnique(idunique)
    if xTarget then
            MumbleSetPlayerMuted(xTarget.source, false)
            xTarget.showNotification("~r~You are demuted")
            xPlayer.showNotification("~r~Player "..xTarget.name.. " is demuted")
    else
        xPlayer.showNotification("~r~Player is not online")
    end
end)

RegisterServerEvent("MP:GoMode")
AddEventHandler("MP:GoMode", function(mode)
    local xPlayer = MP.Player[source]
    if xPlayer.cheatermonde then xPlayer.showNotification("~r~You are in cheater world") return end
    if xPlayer.ModeDeJeu ~= "pvp" then return end
    local bool, lemode = MP.GetModeDeJeu(mode)
    if bool then
        xPlayer.ModeDeJeu = mode
        MP.SetPlayerRoutingBucket(xPlayer.source, lemode.id)
        if mode == "battleroyale" and not MP.GameBattleRoyaleLancer then
            addPlayerInAttenteBattleRoyale({source = xPlayer.source, identifier = xPlayer.identifier, name = GetPlayerName(xPlayer.source)})
        end
        TriggerClientEvent("MP:ChangeModeDeJeu", xPlayer.source, mode)
        --MP.SendWebhook("Changement de mode de jeu", GetPlayerName(xPlayer.source) .. " vient de rentré dans le mode " ..lemode.text, "Identifier : " ..xPlayer.identifier, "https://discord.com/api/webhooks/1182683326566371349/eXQqum7hxDUiryU8OJcsWvZ-xygiR4dgbjHBGO167bGc-R6GNWkZz2anCB-MEcNJbVLu")
    end
end)

RegisterServerEvent("MP:SetParameter")
AddEventHandler("MP:SetParameter", function(data)
        if data == nil then return end
        if data["categorie"] == nil then return end
        if data["parameter"] == nil then return end
        if data["value"] == nil then return end
        local xPlayer = MP.Player[source]
        if xPlayer.parameter[data["categorie"]] == nil then return end
        if xPlayer.parameter[data["categorie"]][data["parameter"]] == nil then return end
        xPlayer.parameter[data["categorie"]][data["parameter"]] = data["value"]
        if data["parameter"] == "ppsteam" then
            if data["value"] then
                xPlayer.ppsteam = xPlayer.ppsteamcache
            else
                xPlayer.ppsteam = "https://avatars.cloudflare.steamstatic.com/fef49e7fa7e1997310d705b2a6158ff8dc1cdfeb_full.jpg"
            end
        end
        xPlayer.refreshMyClient()
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000)
        for k, v in pairs(MP.Player) do
            local _src = v.source
            if GetEntityCoords(GetPlayerPed(_src)) ~= vector3(0.0, 0.0, 0.0) then
                local xPlayer = MP.Player[_src]
                xPlayer.timevip = v.timevip - 60
                if xPlayer.timevip <= 0 then
                        xPlayer.vip = 0
                        xPlayer.timevip = 0
                end
                updateUser(xPlayer.identifier, {account = xPlayer.getAccount(), group = xPlayer.group, coin = xPlayer.coin, position = {x = GetEntityCoords(GetPlayerPed(xPlayer.source)).x, y = GetEntityCoords(GetPlayerPed(xPlayer.source)).y, z = GetEntityCoords(GetPlayerPed(xPlayer.source)).z, h = GetEntityHeading(GetPlayerPed(xPlayer.source))}, defi = xPlayer.defi, parameter = xPlayer.parameter, vip = xPlayer.vip, timevip = xPlayer.timevip, xp = xPlayer.xp, deathmessage = xPlayer.deathmessage})
       MySQL.Async.execute('UPDATE MP_user SET coin = @coin, account = @account, groupe = @groupe, position = @position, name = @name, defi = @defi, parameter = @parameter, xp = @xp, deathmessage = @deathmessage, timevip = @timevip, vip = @vip WHERE identifier = @identifier', {
                    ['@coin'] = xPlayer.coin,
                    ['@account'] = json.encode(xPlayer.getAccount()),
                    ['@groupe'] = xPlayer.group,
                    ['@position'] = json.encode({x = GetEntityCoords(GetPlayerPed(xPlayer.source)).x, y = GetEntityCoords(GetPlayerPed(xPlayer.source)).y, z = GetEntityCoords(GetPlayerPed(xPlayer.source)).z, h = GetEntityHeading(GetPlayerPed(xPlayer.source))}),
                    ['@name'] = xPlayer.name,
                    ['@defi'] = json.encode(xPlayer.defi),
                    ["@parameter"] = json.encode(xPlayer.parameter),
                    ["@xp"] = xPlayer.xp,
                    ["@deathmessage"] = xPlayer.deathmessage,
                    ['@timevip'] = xPlayer.timevip,
                    ["@vip"] = xPlayer.vip,
                    ['@identifier'] = xPlayer.identifier,
        })
            end
        end
    end
end)

AddEventHandler('playerDropped', function (reason)
    local _src = source
    --deletePlayerInAttenteBattleRoyale(_src)
    --local boole, _, i = SearchPlayerInBattleRoyale(_src)
    --if boole then
        --DeletePlayerInBattleRoyale(_src)
    --end
    MP.DeletePlayerRoutingBucket(_src)
    DeleteServiceStaff(_src)
    local xPlayer = MP.Player[_src]
    if xPlayer then
        CancelTradeInProgress(xPlayer.idunique)
        QuitSquad(xPlayer.source)
        DeleteToken(xPlayer.source)
        if xPlayer.ModeDeJeu ~= "pvp" and xPlayer.ModeDeJeu ~= "entrainement" then 
                exports["k9-inventory"]:ClearInventory(_src, "inventory")
        end
        MP.NbPlayer = MP.NbPlayer - 1
   		TriggerClientEvent("MP:UpdateNbJoueur", -1, MP.NbPlayer)
        MP.SendWebhook("Deconnexion", "Info du joueur qui vient de se déconnecter : \nNom : **" ..xPlayer.name.. "** \nIdentifier : **" ..xPlayer.identifier.. "** \nPoints : **" ..xPlayer.getAccount("bank").. "**", "Nombre de joueur restant : " ..MP.NbPlayer, "https://discord.com/api/webhooks/1182686078017212436/aPeM-62WG9nnj8ZfkVUJwjC1z588qEYPH7vkXJJWBrnA9yID5h2CeW7NqMsdgtb6jqLg", 15158332)
        updateUser(xPlayer.identifier, {account = xPlayer.getAccount(), group = xPlayer.group, coin = xPlayer.coin, position = {x = GetEntityCoords(GetPlayerPed(xPlayer.source)).x, y = GetEntityCoords(GetPlayerPed(xPlayer.source)).y, z = GetEntityCoords(GetPlayerPed(xPlayer.source)).z, h = GetEntityHeading(GetPlayerPed(xPlayer.source))}, defi = xPlayer.defi, parameter = xPlayer.parameter, vip = xPlayer.vip, timevip = xPlayer.timevip, xp = xPlayer.xp, deathmessage = xPlayer.deathmessage})
        TriggerEvent("MP:PlayerDropped", _src)
       MySQL.Async.execute('UPDATE MP_user SET coin = @coin, account = @account, groupe = @groupe, position = @position, name = @name, defi = @defi, parameter = @parameter, xp = @xp, deathmessage = @deathmessage, timevip = @timevip, vip = @vip WHERE identifier = @identifier', {
                    ['@coin'] = xPlayer.coin,
                    ['@account'] = json.encode(xPlayer.getAccount()),
                    ['@groupe'] = xPlayer.group,
                    ['@position'] = json.encode({x = GetEntityCoords(GetPlayerPed(xPlayer.source)).x, y = GetEntityCoords(GetPlayerPed(xPlayer.source)).y, z = GetEntityCoords(GetPlayerPed(xPlayer.source)).z, h = GetEntityHeading(GetPlayerPed(xPlayer.source))}),
                    ['@name'] = xPlayer.name,
                    ['@defi'] = json.encode(xPlayer.defi),
                    ["@parameter"] = json.encode(xPlayer.parameter),
                    ["@xp"] = xPlayer.xp,
                    ["@deathmessage"] = xPlayer.deathmessage,
                    ['@timevip'] = xPlayer.timevip,
                    ["@vip"] = xPlayer.vip,
                    ['@identifier'] = xPlayer.identifier
        }, function()
            MP.Player[_src] = nil
            UpdateNbPlayer()
        end)
    end
end)