Framework = nil

local list = {}

local arme = {
    {name = "WEAPON_RPG", label = "~y~RPG", nombre = 2},
    {name = "WEAPON_COMBATMG", label = "M60", nombre = 80},
    {name = "WEAPON_HOMINGLAUNCHER", label = "~y~Homing launcher", nombre = 1},
    {name = "WEAPON_MARKSMANRIFLE_MK2", label = "~y~Marksmanrifle MKII", nombre = 1},
    {name = "WEAPON_MARKSMANRIFLE", label = "~y~Marksmanrifle", nombre = 1},
    {name = "WEAPON_COMBATMG_MK2", label = "M60 MKII", nombre = 30},
    {name = "WEAPON_TACTICALRIFLE", label = "Tactical Rifle", nombre = 80},
    {name = "WEAPON_MICROSMG", label = "Micro SMG", nombre = 130},
    {name = "WEAPON_SMG", label = "SMG", nombre = 140},
    {name = "WEAPON_BULLPUPRIFLE_MK2", label = "Bullpup Mk2", nombre = 80},
    {name = "WEAPON_SPECIALCARBINE_MK2", label = "Carabine Special MKII", nombre = 80},
    {name = "WEAPON_CARBINERIFLE", label = "Carabine Rifle", nombre = 80},
    {name = "WEAPON_CARBINERIFLE_MK2", label = "Carabine Rifle MKII", nombre = 80},
    {name = "WEAPON_BULLPUPRIFLE", label = "Bullpup Rifle", nombre = 160},
    {name = "WEAPON_AUTOSHOTGUN", label = "Sweeper Shotgun", nombre = 180},
    {name = "WEAPON_FLAREGUN", label = "Flare Gun", nombre = 150},
    {name = "WEAPON_ADVANCEDRIFLE", label = "Advanced Rifle", nombre = 140},
    {name = "WEAPON_COMPACTRIFLE", label = "Compact Rifle", nombre = 130},
    {name = "WEAPON_BULLPUPSHOTGUN", label = "Bullpup Shotgun", nombre = 90},
    -- CAR 
    {name = "thruster", label = "~p~Thruster", nombre = 5},
    {name = "scarab", label = "~y~Scarab", nombre = 3},
    {name = "brutus", label = "Brutus", nombre = 120},
    {name = "deluxo", label = "~y~Deluxo", nombre = 2},
    {name = "revolter", label = "Revolter", nombre = 140},
    {name = "deathbike", label = "DeathBike", nombre = 100},
    {name = "vigilante", label = "~p~Vigilante", nombre = 3},
    {name = "oppressor", label = "~y~Oppressor", nombre = 2},
    {name = "nightshark", label = "~y~Nightshark", nombre = 2},
    {name = "dukes2", label = "~p~Dukes Of Death", nombre = 3},
    {name = "insurgent2", label = "~p~Insurgent", nombre = 3},
    {name = "dominator4", label = "Dominator", nombre = 100},
    
}

Citizen.CreateThread(function()
    for i = 1, #arme do
        for y = 1, arme[i].nombre do
            table.insert(list, arme[i])
        end
    end
end)

local function searchItem(name)
    for i = 1, #arme do
        if arme[i].name == name then
            return true, arme[i]
        end
    end
end

local function calc(nb)
    local result = MP.Round(tonumber(nb / #list), 4) * 100
    return result, MP.Round(100 / result)
end

RegisterCommand("calc", function(source, args)
    if source ~= 0 then return end
    if args[1] == nil then return end
    local bool, larme = searchItem(args[1])
    if bool then
        local pourcent, nb = calc(larme.nombre)
        print("Il y a " .. pourcent  .. "% de chance et il faudrait tuer environ " .. nb .. " zombie pour tomber sur un(e) " ..larme.label)
    else
        print("Arme / Véhicule non trouvé")
    end
end)


MP.RegisterServerEvent("kaves_zombie:server:giveLoot", function(zone)
    local source = source
    local xPlayer = MP.Player[source]
    local chance = math.random(1, 10)
    local money = 0
    xPlayer.AddStats("pvp", "zombiekill")
    if zone == "darkzone" then
        xPlayer.AddStats("redzone", "zombiekill")
        exports["k9-inventory"]:AddStats(xPlayer.identifier, "redzone", "zombiekill")
    end
    if #(GetEntityCoords(GetPlayerPed(source))-vector3(4840.571, -5174.425, 2.0)) < 2000 then
        xPlayer.AddStats("darkzone", "zombiekill")
        exports["k9-inventory"]:AddStats(xPlayer.identifier, "darkzone", "zombiekill")
    end
    if xPlayer.HasDefi(2) then
        xPlayer.CompleteDefi(2, 1)
    end
    if chance <= 7 then
        money = math.random(10, 15)
        local zrzuru = money
        if zone == "darkzone" then
            money = MP.Round(money + (money * 0.30))
        end
        xPlayer.addAccountMoney("bank", money)
        label = "~b~" .. money .. " points"
    else
        local random = list[math.random(1,#list)]
        label = random.label
        exports["k9-inventory"]:AddItem(source, "inventory", random.name, 1, "Loot zombie")
    end
    MP.SendWebhook("Loot Zombie", "Id Unique : **" ..xPlayer.getIdUnique().. "** \nName Steam : **" ..GetPlayerName(source).. "** \nLoot : **" .. label .. "**", "identifier : " ..xPlayer.identifier, "https://discord.com/api/webhooks/1181809919117238312/E14h3ECPF0FAh7c5wH3IVGnsxgd6yApa-9W-ECvqExf_ChnQxpHPeQ3hmkovNNIsqLmw")
    exports["k9-inventory"]:AddStats(xPlayer.identifier, "pvp", "zombiekill")
    
    
    --if chance <= 40 then
        --item = Config.ite25[math.random(1, #Config.ite25)]
        --AddInventoryItem(source, item, 1)
    --end
    --print(item, money)
    --if item == nil then item = money .. " points" end
    xPlayer.showNotification(Strings["you-found-item"]:format(label))
end)

local isokk = function(identifier, item)
    local bool = exports["inventory"]:HasItem(identifier, "inventory", item, 1)
    return bool
end

RegisterServerEvent("MP:UseItem")
AddEventHandler("MP:UseItem", function(itemName)
    if itemName ~= "antizin" then return end
    local _src = source
    local xPlayer = MP.Player[_src]
    if xPlayer.ModeDeJeu ~= "pvp" then xPlayer.showNotification("~r~You are not in PVP to use Antizin") return end
    local bool = isokk(xPlayer.identifier, "antizin")
    if bool then
        exports["inventory"]:RemoveItem(_src, xPlayer.identifier, "inventory", itemName, 1)
        TriggerClientEvent("MP:UseAntizin", _src, "mdr")
    end
end)