exports("OpenShop", function()
    OpenInventory("protected", "shop")
end)

function GroupDigits(value)
	local left, num, right = string.match(value, '^([^%d]*%d)(%d*)(.-)$')

	return left .. (num:reverse():gsub('(%d%d%d)', '%1' .. " "):reverse()) .. right
end

function sort_on_valueseeezezeeee(t,a)
    table.sort(t, function (u,v)
        return
             tonumber(u[a])<tonumber(v[a])
    
    end)
end

Citizen.CreateThread(function()
        Wait(2500)
        local data = exports["k9pvp"]:GetConfigShop()
        sort_on_valueseeezezeeee(data["buy"], "price")
        sort_on_valueseeezezeeee(data["sell"], "price")
                for i = 1, #data["buy"] do
                    data["buy"][i].priceeee = GroupDigits(data["buy"][i].price)
                end
                for i = 1, #data["sell"] do
                    data["sell"][i].priceeee = GroupDigits(data["sell"][i].price)
                end
        SendNUIMessage({
                type = "setshop",
                data = data
        })
end)

RegisterNUICallback("ConfirmBakset", function(data)
        TriggerServerEvent("MP:ConfirmerPanier", data["panier"])
end)
RegisterNUICallback("SellAll", function()
        TriggerServerEvent("MP:SellAll")
end)