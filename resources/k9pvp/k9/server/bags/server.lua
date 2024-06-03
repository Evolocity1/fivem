local idbags = 0

Citizen.CreateThread(function()
      Citizen.Wait(1000)
      local allitem = exports["k9-inventory"]:GetAllItem()
      for k, v in pairs(allitem) do
            MP.LabelItem[k] = v.label
      end
      print("Label Item Load")
end)

local function AddBags(contenu)
    table.insert(MP.Bags, contenu)
    for k, v in pairs(MP.Player) do
        if v.ModeDeJeu == "pvp" then
            TriggerClientEvent("MP:AddBag", v.source, contenu)
        end
    end
    print("+1 bags")
end
local function GetBags(id)
    for i = 1, #MP.Bags do
        if tonumber(MP.Bags[i].id) == tonumber(id) then
            return true, MP.Bags[i], i
        end
    end
    return false
end

local list = {
    ["deluxo"] = 4
}

RegisterServerEvent("MP:kill")
AddEventHandler("MP:kill", function(idkiller)
    print(source, "est mort")
    idbags = idbags + 1
    local id = idbags
    local xPlayer = MP.Player[source]
    local inventory = exports["k9-inventory"]:GetInventory(xPlayer.source, "inventory")
    local containerbags = ""
    if xPlayer.ModeDeJeu == "pvp" then
        if inventory then
            local leinventory = {}
            local isspawnbag = true
            for i = 1, #inventory do
                local tktname = inventory[i].name
                inventory[i].label = MP.LabelItem[tktname]
                containerbags = containerbags.. "" ..inventory[i].count.. "x " ..inventory[i].label.. " \n"
                if list[tktname] and list[tktname] >= inventory[i].count then
                    isspawnbag = false
                end
            end
            if containerbags == "" then
                    containerbags = "No content in the loot bag"
            end
            if isspawnbag and not MP.GiveMode then
                AddBags({id = id, inventory = inventory, coords = GetEntityCoords(GetPlayerPed(xPlayer.source)), name = "[".. xPlayer.getIdUnique() .. "] " ..GetPlayerName(source), claimed = false, nameclaimed = "", containerbags = containerbags})
            end
            if not MP.GiveMode then
                exports["k9-inventory"]:ClearInventory(xPlayer.source, "inventory")
            end
        end
    end
    if xPlayer.ModeDeJeu == "battleroyale" then
        local _, lemode = MP.GetModeDeJeu("battleroyale")
        if #MP.GetAllPlayerInRoutingBucket(lemode.id) > 1 then
            inventory = GetInventory(xPlayer.source)
            if #inventory >= 1 then
                for i = 1, #inventory do
                    local label, name, count, rarity, types = inventory[i].label, inventory[i].name, inventory[i].count, inventory[i].rarity, inventory[i].type
                    local id = #MP.StuffParTerre + 1
                    local coords = GetEntityCoords(GetPlayerPed(xPlayer.source))
                    local randomcoords = vector3(coords.x + MP.RandomFloat(-2.0, 2.0), coords.y + MP.RandomFloat(-2.0, 2.0), coords.z)
                    table.insert(MP.StuffParTerre, {id = id, name = name, label = label, count = count, type = types, rarity = rarity, coords = randomcoords, dispo = true})
                end
                for k, v in pairs(MP.Player) do
                    --if v.source ~= xPlayer.source then
                        if v.ModeDeJeu == "battleroyale" then
                            TriggerClientEvent("MP:RefreshStuffParTerre", v.source, MP.StuffParTerre)
                        end
                    --end
                end
            end
        end
        DeleteInventory(xPlayer.source)
        SetEntityCoords(GetPlayerPed(xPlayer.source), MP.GetClosestSafezone(GetEntityCoords(GetPlayerPed(xPlayer.source))))
        MP.ChangeModeDeJeu(xPlayer.source, "lobby")
    end
    if xPlayer.ModeDeJeu == "pvp" then
        if xPlayer.isvip and xPlayer.vip == 2 then
                exports["k9-inventory"]:AddItem(xPlayer.source, "inventory", "WEAPON_SPECIALCARBINE", 1, "Respawn after kill VIP")
                exports["k9-inventory"]:AddItem(xPlayer.source, "inventory", "revolter", 1, "Respawn after kill VIP")
        end
    end
    local xTarget = MP.Player[idkiller]
    local namekiller = xTarget and xTarget.name or "Inconnu"
    local idxtarget = xTarget and xTarget.idunique or 0
    MP.SendWebhook("New Kills !", "Killer : **["..idxtarget.."] " ..namekiller.. "** \nVictim : **["..xPlayer.idunique.."] " ..xPlayer.name.. "** \nArena : **" ..xPlayer.ModeDeJeu.. "**  \n Id Bags : **" ..id.. "** \nContainer Bags : \n**" ..containerbags.. "**", "", "https://discord.com/api/webhooks/1203812479269085214/bVdmnIZjNryjHIwkoX8Cs1Tbfl3FmraXE20eq-bYZYSqX183g-SVTzjUXUkrSPlcwPLz")
end)

local function searchStuff(id)
    for i = 1, #MP.StuffParTerre do
        if MP.StuffParTerre[i].id == id then
            return true, MP.StuffParTerre[i], i
        end
    end
    return false
end

RegisterServerEvent("MP:TakeStuff")
AddEventHandler("MP:TakeStuff", function(id)
    local xPlayer = MP.Player[source]
    if xPlayer.group ~= "owner" then return end
    if xPlayer.ModeDeJeu ~= "battleroyale" then return end
    local bool, stuff, i = searchStuff(id)
    if bool then
        AddItem(source, stuff.name, stuff.count, stuff.rarity, stuff.type)
        for k, v in pairs(MP.Player) do
            if v.ModeDeJeu == "battleroyale" then
                TriggerClientEvent("MP:DeleteStuffParTerre", v.source, stuff.id)
            end
        end
        table.remove(MP.StuffParTerre, i)
    end
end)

RegisterServerEvent("MP:ClaimBag")
AddEventHandler("MP:ClaimBag", function(id)
    local _src = source
    local xPlayer = MP.Player[_src]
    if xPlayer.ModeDeJeu ~= "pvp" then return end
    local bool, lebags, i = GetBags(tonumber(id))
    if bool then
        for i = 1, #lebags.inventory do
            local name, label, count = lebags.inventory[i].name, lebags.inventory[i].label, lebags.inventory[i].count
            xPlayer.showNotification("You found ~g~" ..count.. "x " ..label)
            exports["k9-inventory"]:AddItem(xPlayer.source, "inventory", name, count, "Claim lootbag ("..id..")")
        end
        MP.SendWebhook("Take Lootbags !", "Target : **[" ..xPlayer.idunique.. "]** \nOwner Bags : **" ..lebags.name.. "** \n Id Bags : **"..id.."** \nContainer Bags : \n**" ..lebags.containerbags.. "**", "", "https://discord.com/api/webhooks/1203816899394277466/OTJFbLb2gMWlxdMx1V3hPKVrblLwIHLj5WcthEmHQtCY-EnuGz09rlNJ_mxdJvkmIzaq")
        TriggerClientEvent("MP:ClaimBags", -1, lebags.id, "[" ..xPlayer.getIdUnique().. "] " ..GetPlayerName(_src))
        table.remove(MP.Bags, i)
    end
end)

RegisterServerEvent("MP:DeleteBag")
AddEventHandler("MP:DeleteBag", function(id)
    local _src = source
    local xPlayer = MP.Player[_src]
    if xPlayer.group ~= "owner" then return end
    local bool, lebags, i = GetBags(id)
    if bool then
        TriggerClientEvent("MP:ClaimBags", -1, lebags.id, "[" ..xPlayer.getIdUnique().. "] " ..GetPlayerName(_src))
        table.remove(MP.Bags, i)
    end
end)