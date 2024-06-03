local function foundItemInConfig(name)
    for k, v in pairs(Config.ShopK9) do
        for i = 1, #Config.ShopK9[k] do
            if Config.ShopK9[k][i].name == name then
                return true, Config.ShopK9[k][i], k
            end
         end
     end
    return false
end

RegisterServerEvent("MP:BuyInShopK9")
AddEventHandler("MP:BuyInShopK9", function(name)
        local xPlayer = MP.Player[source]
        local bool, item, k = foundItemInConfig(name)
        if not bool then return end
        if xPlayer.coin >= item.kcoins then
            
            if k == "items" then
                xPlayer.removeCoin(tonumber(item.kcoins))
                exports["k9-inventory"]:AddItem(xPlayer.source, "inventory", item.name, item.count, "Buy shop K9 coins")
                MP.SendWebhook("Buy in K9 SHOP", "Player : **["..xPlayer.idunique.."] " ..xPlayer.name.."** \nType : **Items** \nItems : **" ..item.label.. "**", "Identifier : " ..xPlayer.identifier, "https://discord.com/api/webhooks/1206019018977189938/PYtEjMkS-e1cQB6ynigC8Yx7ta40bJhBuntMLfMbUjn9QUvnV6syxSebLtE32yhJS_kr")
            elseif k == "points" then
                xPlayer.removeCoin(tonumber(item.kcoins))
                xPlayer.addAccountMoney("bank", item.count)
                MP.SendWebhook("Buy in K9 SHOP", "Player : **["..xPlayer.idunique.."] " ..xPlayer.name.."** \nType : **Points** \nNumber Points : **" ..item.count.. "**", "Identifier : " ..xPlayer.identifier, "https://discord.com/api/webhooks/1206019018977189938/PYtEjMkS-e1cQB6ynigC8Yx7ta40bJhBuntMLfMbUjn9QUvnV6syxSebLtE32yhJS_kr")
            elseif k == "vip" then
                if not xPlayer.isvip then
                    xPlayer.removeCoin(tonumber(item.kcoins))
                    local time = 2592000
                    if item.lifetime then
                        time = 99999999999
                    end
                    xPlayer.addVip((item.name == "diamond" or item.name == "diamondlifetime") and 1 or 2, time)
                    MP.SendWebhook("Buy in K9 SHOP", "Player : **["..xPlayer.idunique.."] " ..xPlayer.name.."** \nType : **VIP** \nVIP : **" ..item.name.."**", "Identifier : " ..xPlayer.identifier, "https://discord.com/api/webhooks/1206019018977189938/PYtEjMkS-e1cQB6ynigC8Yx7ta40bJhBuntMLfMbUjn9QUvnV6syxSebLtE32yhJS_kr")
                else
                    xPlayer.showNotification("~r~You already have vip")
                    return
                end
            end
            xPlayer.showNotification("~g~Buy successfully")
        else
           xPlayer.showNotification("~r~You don't have enough KCoins") 
        end
end)

RegisterCommand("addkcoin", function(source, args)
        if source ~= 0 then return end
        local id, coins = tonumber(args[1]), tonumber(args[2])
        if id == nil or coins == nil then return end
        local xTarget = MP.GetPlayerFromIdUnique(id)
        if xTarget then
            xTarget.addCoin(coins)
            print(coins .. " bien a ajouté à " ..xTarget.name)
        else
            print("Joueur non connecté")
        end
end)