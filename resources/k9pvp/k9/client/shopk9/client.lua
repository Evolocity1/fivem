RegisterNUICallback("buyshopk9", function(data)
        if data == nil then return end
        TriggerServerEvent("MP:BuyInShopK9", data["name"])
end)

RegisterNUICallback("closeshopk9", function()
        SetNuiFocus(false, false)
end)

RegisterCommand("openshopk9", function(source, args)
        SetNuiFocus(true, true)
        SendNUIMessage({
                type = "shopk9",
                action = "open",
                id = MP.GetPlayerData().idunique,
                kcoin = MP.GroupDigits(MP.GetPlayerData().coin),
        })
end)

RegisterKeyMapping("openshopk9", "Ouvrir le shop kcoins", "keyboard", "F5")