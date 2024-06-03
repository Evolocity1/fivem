local isokk = function(src, item)
    local bool = exports["k9-inventory"]:HasItem(src, "inventory", item, 1)
    return bool
end

local lesveh = {
	"oppressor",
	"deathbike",
}

local function randomId()
    return math.random(1, 99999999)
end

local isveh = function(item)
	for i = 1, #lesveh do
		if lesveh[i] == item then
			return true
		end
	end
	return false
end

local estcequejepeuxetresoumisamp = function(src, item)
	return ((#(GetEntityCoords(GetPlayerPed(src))-vector3(4840.571, -5174.425, 2.0)) < 2000 and isveh(item)) or #(GetEntityCoords(GetPlayerPed(src))-vector3(4840.571, -5174.425, 2.0)) > 2000)
end

local lecoldwon = {}

local allveh = {}

local function searchVehicle(id)
    for i = 1, #allveh do
        if allveh[i].id == id then
            return true, allveh[i], i
        end
    end
    return false
end

MP.RegisterServerEvent("MP:RangerVehicle")
MP.AddEventHandler("MP:RangerVehicle", function(source, id, netidvehicle)
    if not NetworkGetEntityFromNetworkId(netidvehicle) then
            DeleteEntity(netidvehicle)
    end
    local xPlayer = MP.Player[source]
    local bool, info, i = searchVehicle(id)
    if bool then
        if info.mdj == xPlayer.ModeDeJeu and info.mdj ~= "deluxotricks" then
        	exports["k9-inventory"]:AddItem(source, "inventory", info.model, 1, "K Véhicule : ("..id..")")
        end
        xPlayer.showNotification("You have stored ~y~" ..info.label.. " ~s~ \n~y~ID: " ..info.id)
        MP.SendWebhook("Stored Vehicle ID ["..info.id.."]", "Player : **["..xPlayer.idunique.."]" ..xPlayer.name.."** \nArena : **"..info.mdj.."** \nID Vehicle : **" ..info.id.. "** \nLabel : **"..info.label.."**", "Identifier : " ..xPlayer.identifier, "https://discord.com/api/webhooks/1205992003880489071/Tkw-n-ok9AnfwDUAK8CsCpRqZZq4dlOkhEpD3NHMGYI2JZM4iU8QQ62wDUPnVTmqHZt0")
        table.remove(allveh, i)
        DeleteEntity(vehicle)
        if lecoldwon[xPlayer.source] == nil then lecoldwon[xPlayer.source] = false end
        if not lecoldwon[xPlayer.source] then
            --TriggerClientEvent("MP:RangeVehicle", xPlayer.source)
            lecoldwon[xPlayer.source] = true
            Citizen.CreateThread(function()
                local isvipe = xPlayer.isvip and 2000 or 4000
                Wait(isvipe)
                lecoldwon[xPlayer.source] = false
            end)
        end
    else
        xPlayer.showNotification("~r~Vehicle Desync")
    end
end)

local function SpawnVehicle(src, veh, types, coords, heading, label, mdj)

        local xPlayer = MP.Player[src]
    	xPlayer.isspawnvehicle = true
        local id = randomId()
        table.insert(allveh, {model = veh, id = id, label = label, mdj = mdj})
        local _, custom = GetCustomVehicle(xPlayer.identifier, GetHashKey(veh))
        TriggerClientEvent("MP:usevehicle", src, veh, custom, id)
        xPlayer.showNotification("Vehicle: ~y~" ..label.. " ~s~ \n~s~ID: ~y~" ..id)
        MP.SendWebhook("Spawn Vehicle ID ["..id.."]", "Player : **["..xPlayer.idunique.."]" ..xPlayer.name.."** \nArena : **"..mdj.."** \nID Vehicle : **" ..id.. "**  \nLabel : **" ..label.."**", "Identifier : " ..xPlayer.identifier, "https://discord.com/api/webhooks/1205992003880489071/Tkw-n-ok9AnfwDUAK8CsCpRqZZq4dlOkhEpD3NHMGYI2JZM4iU8QQ62wDUPnVTmqHZt0")
    
    
end

local onecolwodn = {}

RegisterServerEvent("gfx-inventory:OnItemUsed")
AddEventHandler("gfx-inventory:OnItemUsed", function(itemName)
        local _src = source
        local xPlayer = MP.Player[_src]
        local _, _, item = exports["k9-inventory"]:GetItemByName(xPlayer.source, "inventory", itemName)
        if item == nil then return end
        if item.type ~= "vehicle" then return end
        if xPlayer.ModeDeJeu == "entrainement" then return end
        local ped = GetPlayerPed(_src)
        if GetVehiclePedIsIn(ped, false) ~= 0 then return end
        if lecoldwon[_src] == nil then lecoldwon[_src] = false end
        if onecolwodn[_src] == nil then onecolwodn[_src] = false end
        if not onecolwodn[_src] then
            if not lecoldwon[_src] then
                if isokk(xPlayer.source, itemName) then
            	    if estcequejepeuxetresoumisamp(_src, itemName) then
            	        onecolwodn[_src] = true
            	        Citizen.CreateThread(function()
                            local isvipe = xPlayer.isvip and 2000 or 4000
                			Wait(isvipe)
                            onecolwodn[_src] = false
                        end)
                        if xPlayer.ModeDeJeu ~= "deluxotricks" then
            	        	exports["k9-inventory"]:RemoveItem(source, "inventory", itemName, 1)
                        end

            	        SpawnVehicle(_src, itemName, "automobile", GetEntityCoords(ped), GetEntityHeading(ped), item.label, xPlayer.ModeDeJeu)
            	        if xPlayer.HasDefi(7) then
            	            xPlayer.CompleteDefi(7, 1)
            	        end
            	    end
                end
            else
                xPlayer.showNotification("~r~You have to wait for cooldown!")
            end
        end
end)