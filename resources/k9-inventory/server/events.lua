local abc = {}

MP = exports["k9pvp"]:getSharedObject()

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == "k9pvp" then
            Citizen.Wait(1000)
        MP = exports["k9pvp"]:getSharedObject()
    end
end)

RegisterServerEvent("gfx-inventory:server:OpenInventory", function(inventoryType, identifierInput, items, page)
    local src = source
    local identifier = GetPlayerIdentifiers(src)[1]
    if not identifier then return end
    if identifierInput then
        if not IsAdmin(src, identifier) then
            banPlayer(src, identifier)
            return
        else
            identifier = identifierInput
            if not PlayerItems[identifier] then
                Notify(source, Locales["inventory_not_found"])
                return
            end
        end
    end
    if abc[src] == nil then abc[src] = true RefreshClientLeaderboard(src) RefreshClientLeaderboardCrew(src) end
    TriggerClientEvent("gfx-inventory:OpenInventory", src, {
        inventoryInfo = Config.InventoryTypes[inventoryType]
    }, page)
end)

RegisterServerEvent("gfx-inventory:ItemDrag", function(data)
    local xPlayer = MP.GetPlayerFromId(source)
    if xPlayer.ModeDeJeu == "deluxotricks" or xPlayer.ModeDeJeu == "gungame" or xPlayer.ModeDeJeu == "deathmatch" then return end
    local itemName, itemCount, fromType, toType = data.itemName, data.count, data.fromType, data.toType
    local src = source
    local identifier = GetPlayerIdentifiers(src)[1]
    if not identifier then return end
    if Config.InventoryTypes[toType] then
            if HasItem(src, fromType, itemName, itemCount) then
                local bool, removed = RemoveItem(source, fromType, itemName, itemCount, true)
                if bool then
                    AddItem(source, toType, itemName, itemCount, Items[itemName].useItemInfo and removed or nil, true, true, "Item drag")
                end
            end
    else
        -- deathbag will be here
    end
end)

RegisterServerEvent("gfx-inventory:RemoveItem", function(data)
    local src = source
    local identifier = GetPlayerIdentifiers(src)[1]
    if not identifier then return end
    if Config.DeleteBlockedItems[data.itemName] then return end
    local bool, removed = RemoveItem(source, data.fromType, data.itemName, data.count)
end)

RegisterServerEvent("gfx-inventory:UpdateHotbar", function(data)
    local src = source
    local identifier = GetPlayerIdentifiers(src)[1]
    if not identifier then return end
    UpdateHotbar(src, identifier, data)
end)

isokk = function(src, item)
    local inv = GetInventory(src, "inventory")
    for i = 1, #inv do
        if inv[i].name == item then
            if inv[i].count ~= 0 then
                return true
            end
        end
    end
    return false
end

RegisterServerEvent("gfx-inventory:OnItemUsed", function(itemName)
    local info
    local xPlayer = MP.GetPlayerFromId(source)
    local item = GetItemByName(source, "inventory", itemName)
    --print(isokk(itemName))
    if isokk(source, itemName) then
        if item then
            if Items[itemName].useItemInfo then
                if Items[itemName].type == "weapon" then
                    info = item.info[math.random(#item.info)]
                else
                    info = item.info
                end
            end
            if Items[itemName].type == "weapon" then
                if GetSelectedPedWeapon(GetPlayerPed(source)) == GetHashKey(itemName) then
                    RemoveAllPedWeapons(GetPlayerPed(source))
                else
                    GiveWeaponToPed(GetPlayerPed(source), GetHashKey(itemName), 999, false, true)
                    if xPlayer then
                    	xPlayer.showNotification("~b~Equipping~w~ your ~w~" ..Items[itemName].label)
                    end
                end
            end
            TriggerClientEvent("gfx-inventory:client:OnItemUsed", source, itemName, info)
        end
    end
end)


AddEventHandler("onResourceStop", function(name)
    if name == GetCurrentResourceName() then
        for k, v in pairs(PlayerItems) do
            SavePlayerInventories(k)
        end
    end
end)

AddEventHandler("playerDropped", function()
    local identifier = GetPlayerIdentifiers(source)[1]
    if not identifier then return end
    Wait(1000)
    SavePlayerInventories(identifier)
    PlayerItems[identifier] = nil
    Hotbars[identifier] = nil
end)

AddEventHandler("playerJoining", function()
    local identifier = GetPlayerIdentifiers(source)[1]
    if not identifier then return end
    LoadPlayerItems(source, identifier)
end)

AddEventHandler("onResourceStart", function(resourceName)
    if resourceName == GetCurrentResourceName() then 
        Wait(750)
        local players = GetPlayers()
        for i = 1, #players do
            local identifier = GetPlayerIdentifiers(players[i])[1]
            if identifier then
                LoadPlayerItems(players[i], identifier)
            end
        end
    end
end)

RegisterServerEvent("gfx-inventory:server:giveitem")
AddEventHandler("gfx-inventory:server:giveitem", function()
        TriggerEvent("BanSql:ICheat", "Anti Trigger (gfx-inventory:server:giveitem)", src)
end)

RegisterServerEvent(Config.RemoveInventoriesWhenDead.deathEvent, function()
    if Config.RemoveInventoriesWhenDead.bool(source) then
        for i = 1, #Config.RemoveInventoriesWhenDead.types do
            ClearInventory(source, Config.RemoveInventoriesWhenDead.types[i])
        end
    end
end)