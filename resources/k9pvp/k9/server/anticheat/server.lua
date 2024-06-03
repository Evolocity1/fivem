local ancien = {}

local function KickPlayerAnticheat(src, reason, debug)
    local xPlayer = MP.Player[tonumber(src)]
    if xPlayer == nil then return end
    if debug == nil then debug = "" end
    if type(debug) ~= "string" then debug = "." end
    if (reason == "Anti No Recoil" or reason == "Anti Auto Farm Zombie") and xPlayer.cheatermonde then return end
    MP.SendWebhook("Kicked for ["..reason.."]", "Player : **["..xPlayer.idunique.."]" ..xPlayer.name.."** \nArena : **"..xPlayer.ModeDeJeu.."** \nReason : **" ..reason.. "** \nDebug : \n**" ..debug.. "**", "Identifier : " ..xPlayer.identifier, "https://discord.com/api/webhooks/1206640318347354122/iTRnPl5VV3Ljxr_c3clF2KmtxuWPjNAyw-h96KgEFiPbPTtBxApU6xo5A_doBb3IRl_u")
    exports["chat"]:sendmsg(xPlayer.name.." ~r~kicked from the server!")
    DropPlayer(src, "Kicked for " ..reason)
end

local function BanPlayerAnticheat(src, reason, debug, ischeatermode, iskick)
    local xPlayer = MP.Player[tonumber(src)]
    if xPlayer == nil then return end
    if debug == nil then debug = "." end
    if type(debug) ~= "string" then debug = "." end
    
    if ischeatermode then
        if not xPlayer.cheatermonde then
        	MP.BanPlayerCheaterMonde(src, "Anticheat K9 PVP", reason, "BAN ANTICHEAT")
            MP.SendWebhook("World cheater for ["..reason.."]", "Player : **["..xPlayer.idunique.."]" ..xPlayer.name.."** \nArena : **"..xPlayer.ModeDeJeu.."** \nReason : **" ..reason.. "** \nDebug : \n**" ..debug.. "**", "Identifier : " ..xPlayer.identifier, "https://discord.com/api/webhooks/1208564453721776198/VUlq-1BBGKAjEnArv4Icm34PfTmYLcC_Gpve2mWkb5zf7ZgjD7kXgx45Ft8On-yXYcU8")
        elseif iskick then
            KickPlayerAnticheat(src, reason, debug)
            MP.SendWebhook("Kick World cheater for ["..reason.."]", "Player : **["..xPlayer.idunique.."]" ..xPlayer.name.."** \nArena : **"..xPlayer.ModeDeJeu.."** \nReason : **" ..reason.. "** \nDebug : \n**" ..debug.. "**", "Identifier : " ..xPlayer.identifier, "https://discord.com/api/webhooks/1208564226818576394/C4YIsxAtMMYHc9HDOi5z1E7J80iLXzv5Qq6g6EW374vwnqMnF4OaE8H4rvbrGnXNKhgE")
        end
    else
    	MP.BanPlayer(src, "Anticheat K9 PVP", reason)
        MP.SendWebhook("Blacklist for ["..reason.."]", "Player : **["..xPlayer.idunique.."]" ..xPlayer.name.."** \nArena : **"..xPlayer.ModeDeJeu.."** \nReason : **" ..reason.. "** \nDebug : \n**" ..debug.. "**", "Identifier : " ..xPlayer.identifier, "https://discord.com/api/webhooks/1206641182923563079/ap4h4ZJx0u5UvrrzWnyNM8YLrKEWGdx2XRvjYG4FvQzl1RdrRCqRgm9C5NLdR6vncei9")
    exports["chat"]:sendmsg(xPlayer.name.." ~r~banned from the server!")
    end
end

local function IsGiveWeapon(src)
    local ped = GetPlayerPed(src)
    local weapon = GetSelectedPedWeapon(ped)
    if ancien[src] == nil then ancien[src] = GetHashKey("weapon_unarmed") end
    if weapon ~= GetHashKey("weapon_unarmed") and weapon ~= 966099553 and weapon ~= 0 and GetEntityHealth(ped) > 0 and weapon ~= GetHashKey("weapon_pistol") then
        ancien[src] = weapon
        local inv = exports["k9-inventory"]:GetInventory(src, "inventory")
        for i = 1, #inv do
            local name = inv[i].name
            if GetHashKey(name) == weapon then
                return false
            end
        end
        return true
    end
    return false
end

local function IsTeleportWaypoint(src)
    local ped = GetPlayerPed(src)
    local xPlayer = MP.Player[src]
    local coords = GetEntityCoords(ped)
    if xPlayer.anciencoords ~= vector3(0,0,0) and coords ~= vector3(0,0,0) then
        if #(coords-xPlayer.anciencoords) >= 100.0 and not MP.IsInSafezone(coords) and not MP.InDarkzone(coords) and not MP.IsInSafezone(xPlayer.anciencoords) then
            if not xPlayer.istp then
                xPlayer.anciencoords = coords
                return false
            end
            xPlayer.anciencoords = coords
            return true
        end
    end
    xPlayer.anciencoords = coords
    xPlayer.istp = false
    return false
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        for k, v in pairs(MP.Player) do
            if IsGiveWeapon(v.source) then
               RemoveAllPedWeapons(GetPlayerPed(v.source))
            end
        end
    end
end)

local featuresban = {
    ["Anti Warp Vehicle"] = true,
    ["Anti Explosive Ammo"] = true,
    ["Anti Texture"] = true,
}

RegisterServerEvent("MP:K9ONTOP")
AddEventHandler("MP:K9ONTOP", function(reason, debug)
    local xPlayer = MP.Player[source]
    print(GetPlayerName(xPlayer.source).. " est detect pour " ..reason)
    if featuresban[reason] then
            BanPlayerAnticheat(xPlayer.source, reason, debug, true, true)
     else
            KickPlayerAnticheat(xPlayer.source, reason, debug)
     end
    
end)
        
RegisterServerEvent("MP:AntiNoclip")
AddEventHandler("MP:AntiNoclip", function(debug)
	local xPlayer = MP.Player[source]
    if xPlayer.ModeDeJeu == "deathmatch" or xPlayer.ModeDeJeu == "gungame" or xPlayer.ModeDeJeu == "entrainement" then return end
    print(GetPlayerName(xPlayer.source).. " est detect pour Anti Noclip")
    KickPlayerAnticheat(xPlayer.source, "Anti Noclip", debug)
end)

RegisterServerEvent("MP:goat")
AddEventHandler("MP:goat", function(resource)
        if resource == nil then resource = "Unknow" end
        BanPlayerAnticheat(source, "Anti stop : " ..resource, ".", false)
end)

RegisterServerEvent("MP:DetectRPF")
AddEventHandler("MP:DetectRPF", function()
        DropPlayer(source, "Anti RPF")
end)

AddEventHandler("explosionEvent", function(source, ev)
	local _src = source
	if ev then
        print(_src, ev.ownerNetId, "explosion")
		print(GetPlayerName(_src) .. " vient de créé une explosion de type " ..ev.explosionType)
		if ev.explosionType == 82 then
            BanPlayerAnticheat(_src, "Anti Explosion Eulen", ".", true, false)
            CancelEvent()
		end
		if ev.explosionType ~= 4 and ev.explosionType ~= 7 and ev.explosionType ~= 1 then
		    print("cancel event")
		    CancelEvent()
		end
	end
end)

local props = {
			GetHashKey("prop_mil_crate_01"),
			GetHashKey("prop_big_bag_01"),
			1336576410,
}

checkpropswhitelist = function(hash)
	for i = 1, #props do
		if props[i] == hash then
			return true
		end
	end
	return false
end

local allvehiclecreate = {}

AddEventHandler("entityCreating", function(a)
        if DoesEntityExist(a) then
            if GetEntityType(a) == 2 then
                local b, c = NetworkGetEntityOwner(a)
                print(b .. " a fait spawn un véhicule")
                local xPlayer = MP.Player[tonumber(b)]
                if xPlayer.isspawnvehicle then
                    xPlayer.isspawnvehicle = false
                    return
                end
                if allvehiclecreate[tostring(b)] == nil then allvehiclecreate[tostring(b)] = 0 end
                allvehiclecreate[tostring(b)] = tonumber(allvehiclecreate[tostring(b)] + 1)
                if allvehiclecreate[tostring(b)] >= 50 then
                    BanPlayerAnticheat(b, "Anti Spawn Vehicle", ".", true, true)
                end
                if xPlayer then
                    MP.SendWebhook("Vehicle Desync ["..a.."]", "Player : **["..xPlayer.idunique.."]" ..xPlayer.name.."** \nArena : **"..xPlayer.ModeDeJeu.."**", "Identifier : " ..xPlayer.identifier, "https://discord.com/api/webhooks/1206647917172228147/aAsGCJkj6F2SdQLRlf5yGq9psxWfZ0ySftSNPpNMOx3G-nrQEuTaOg-wmvspCub6kCFM")
                end
                CancelEvent()
            end
		end
end)
AddEventHandler("entityCreated", function(a)
	if DoesEntityExist(a) then
		--[[if GetEntityType(a) == 2 then
			local b, c = NetworkGetEntityOwner(a)
			print(b .. " a fait spawn un véhicule")
            DeleteEntity(a)
            local xPlayer = MP.Player[tonumber(b)]
            if xPlayer then
                xPlayer.showNotification("T'es detect : Anti Spawn Véhicule")
            end
		end]]
		if GetEntityType(a) == 1 then
			local b, c = NetworkGetEntityOwner(a)
			print(GetPlayerName(b).. " vient de spawn un ped (" ..a..")")
			--TriggerClientEvent("MP:testped", b, NetworkGetNetworkIdFromEntity(a))
			DeleteEntity(a)
		end
		if GetEntityType(a) == 3 then
			if GetEntityModel(a) ~= 0 then 
				local b, c = NetworkGetEntityOwner(a)
					if not checkpropswhitelist(GetEntityModel(a)) then
						DeleteEntity(a)
						print(GetPlayerName(b).. " vient de spawn un props non whitelist (" ..GetEntityModel(a).. ")")
					end
			end
		end
	end
end)

AddEventHandler('weaponDamageEvent', function(sender, ev)
        local xPlayer = MP.Player[tonumber(sender)]
        if ev["weaponType"] == GetHashKey("weapon_stungun") then

            BanPlayerAnticheat(sender, "Anti Taze Player", ".", true, false)
            CancelEvent()
        end
        if ev["weaponDamage"] == 512 then

            --BanPlayerAnticheat(sender, "Anti Kill Him Player")
            CancelEvent()
        end
        if ev["weaponDamage"] >= 600 then

            --BanPlayerAnticheat(sender, "Anti One Hit")
            CancelEvent()
        end
end)

AddEventHandler("RemoveWeaponEvent", function(src, b)
        CancelEvent()
end)

AddEventHandler("giveWeaponEvent", function(src, b)
          if b.givenAsPickup == false then
                CancelEvent()
           end
end)

AddEventHandler("ptFxEvent", function()
	CancelEvent()
end)