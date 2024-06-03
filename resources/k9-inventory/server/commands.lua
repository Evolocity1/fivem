MP = exports["k9pvp"]:getSharedObject()

RegisterCommand("clearinventory", function(source, args)
    local monxPlayer = MP.GetPlayerFromId(source)
    if monxPlayer.group == "owner" then
        ClearInventory(tonumber(args[1]), args[2])
    end
end)

RegisterCommand("additem", function(source, args)
    local monxPlayer = MP.GetPlayerFromId(source)
    if monxPlayer.group == "owner" then
        local xPlayer = MP.GetPlayerFromIdUnique(tonumber(args[1]))
        if xPlayer ~= false then
            local target, inventoryType, itemName, itemCount = xPlayer.source, args[2], args[3], tonumber(args[4])
            AddItem(target, inventoryType, itemName, itemCount, nil, nil, nil, "Give Item")
        end
    end
end)

RegisterCommand("removeitem", function(source, args)
    local monxPlayer = MP.GetPlayerFromId(source)
    if monxPlayer.group == "owner" then
        local xPlayer = ESX.GetPlayerFromIdUnique(tonumber(args[1]))
        if xPlayer ~= false then
            local target, inventoryType, itemName, itemCount = xPlayer.source, args[2], args[3], tonumber(args[4])
            RemoveItem(target, inventoryType, itemName, itemCount)
        end
    end
end)