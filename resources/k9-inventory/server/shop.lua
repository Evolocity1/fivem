function SendWebhook(name, msg, footer, webhook, color)
	local lacolor = tonumber(color) ~= nil and tonumber(color) or 16753920
	local embed = {
		{
			["color"] = lacolor,
			["title"] = "**".. name .."**",
			["description"] = msg,
			["footer"] = {
                ["text"] = footer,
            },
		}
	}

  PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end



Shop = exports["k9pvp"]:GetConfigShop()

local function searchItemInShop(action, name)
    for i = 1, #Shop[action] do
        if Shop[action][i].name == name then
            return true, Shop[action][i]
        end
    end
    return false
end



RegisterServerEvent("MP:ConfirmerPanier")
AddEventHandler("MP:ConfirmerPanier", function(data)
        if data == nil then return end
        local _src = source
        local xPlayer = MP.GetPlayerFromId(_src)
        if xPlayer.ModeDeJeu ~= "pvp" then return end
        local legrosbool = false -- no fake mdrrr
        local lecalc = 0
        local labelweb = ""
        for i = 1, #data do
            if not (data[i].quantity >= 1) then
                xPlayer.showNotification("~r~Error " ..data[i].buyorsell.. " " ..data[i].quantity.. "x " ..data[i].label)
                legrosbool = true
                break
            end
            if not ((data[i].buyorsell == "sell" and HasItem(_src, "inventory", data[i].name, data[i].quantity)) or data[i].buyorsell == "buy") then
                xPlayer.showNotification("~r~You have don't " ..data[i].quantity.. "x " ..data[i].label)
                legrosbool = true
                break
            end
            local bool, item = searchItemInShop(data[i].buyorsell, data[i].name)
            if not bool then
                xPlayer.showNotification("~r~Error " ..data[i].buyorsell.. " " ..data[i].quantity.. "x " ..data[i].label)
                legrosbool = true
                break
            else
                if data[i].buyorsell == "buy" then
                	lecalc = lecalc + (item.price * data[i].quantity)
                else
                    lecalc = lecalc - (item.price * data[i].quantity)
                end
            end
            labelweb = labelweb .. "" ..data[i].quantity.. "x " ..item.label.. " - " ..(item.price * data[i].quantity).. "$ \n"
        end
        if legrosbool then return end
        local lesignet = ""
        if lecalc > 0 then
            local bank = xPlayer.getAccount("bank")
            if not (bank >= lecalc) then
                xPlayer.showNotification("~r~Refused payment")
                return
            end
            xPlayer.removeAccountMoney("bank", lecalc)
            lesignet = "-"
        else
            lecalc = lecalc * -1
            xPlayer.addAccountMoney("bank", lecalc)
            lesignet = "+"
        end
        for i = 1, #data do
            if data[i].buyorsell == "buy" then
                AddItem(_src, "inventory", data[i].name, data[i].quantity, nil, nil, nil, "Achat Shop")
            else
                RemoveItem(_src, "inventory", data[i].name, data[i].quantity)
            end
        end
        SendWebhook("Basket successfully", "Buyer : **["..xPlayer.idunique.."] " ..xPlayer.name.. "** \nBasket : \n**" ..labelweb.. "**Total Basket Price : **" ..lesignet.. "" ..lecalc.."$**", "Identifier : " ..xPlayer.identifier, "https://discord.com/api/webhooks/1204020600331436062/SiN8qWTWu0tFgZQow1Wnd8l79yYtcs1VAhG05FUGzkrPyuf5XYoub1n-LXEc-GUnqCHL")
        xPlayer.showNotification("~g~Basket successfully ("..lesignet.." "..lecalc.."$)")
end)

RegisterServerEvent("MP:SellAll")
AddEventHandler("MP:SellAll", function()
        local xPlayer = MP.GetPlayerFromId(source)
        if xPlayer.ModeDeJeu ~= "pvp" then return end
        local inventory = GetInventory(source, "inventory")
        local lecalc = 0
        local labelweb = ""
        if #inventory >= 1 then
            for i = 1, #inventory do
                local name, count = inventory[i - i + 1].name, inventory[i - i + 1].count
                if name then
                    local bool, litem = searchItemInShop("sell", name)
                    if not bool then
                        xPlayer.showNotification("Error : " ..count.. "x " ..name)
                    else
                        RemoveItem(source, "inventory", name, count)
                        xPlayer.addAccountMoney("bank", (litem.price * count))
                        lecalc = lecalc + (litem.price * count)
                        labelweb = labelweb .. "" ..count.. "x " ..litem.label.. " - " ..(litem.price * count).. "$ \n"
                    end
                    
                end
            end
            SendWebhook("Sell All successfully", "Name : **["..xPlayer.idunique.."] " ..xPlayer.name.. "** \nInventory : \n**" ..labelweb.. "**Total Inventory Price : **" ..lecalc.."$**", "Identifier : " ..xPlayer.identifier, "https://discord.com/api/webhooks/1204020600331436062/SiN8qWTWu0tFgZQow1Wnd8l79yYtcs1VAhG05FUGzkrPyuf5XYoub1n-LXEc-GUnqCHL")
            xPlayer.showNotification("~g~Sell all successfully (+"..lecalc.."$)")
        end
end)