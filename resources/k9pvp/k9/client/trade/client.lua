RegisterNetEvent("MP:TradeAccept")
AddEventHandler("MP:TradeAccept", function(myinv, traderinv, id, info)
        SetNuiFocus(true, true)
        SendNUIMessage({
                type = "trade",
                action = "tradeaccept",
                myinv = myinv,
                traderinv = traderinv,
                info = info,
                idtrade = id,
       })
end)

RegisterNetEvent("MP:RefreshTrade")
AddEventHandler("MP:RefreshTrade", function(type, inv, trade)
        if type ~= "me" and type ~= "trader" then return end
        local letype = type == "me" and "updatemytrade" or "updatetradertrade"
        SendNUIMessage({
                type = "trade",
                action = letype,
                inv = inv,
                trade = trade,
        })
end)

RegisterNetEvent("MP:CancelTrade")
AddEventHandler("MP:CancelTrade", function()
        SetNuiFocus(false, false)
        SendNUIMessage({
                type = "trade",
                action = "canceltrade"
            })
end)

RegisterNetEvent("MP:ShowTimerTrade")
AddEventHandler("MP:ShowTimerTrade", function()
        SendNUIMessage({
                type = "trade",
                action = "showtimer"
            })
end )

RegisterNetEvent("MP:SetAcceptTrade")
AddEventHandler("MP:SetAcceptTrade", function(type, bool)
        local letype = type == "me" and "setacceptme" or "setaccepttrader"
        SendNUIMessage({
                type = "trade",
                action = letype,
                bool = bool,
        })
end)

RegisterNUICallback("invtotrade", function(data)
        TriggerServerEvent("MP:SwitchTrade", data.name, "trade")
end)

RegisterNUICallback("tradetoinv", function(data)
        TriggerServerEvent("MP:SwitchTrade", data.name, "inventory")
end)

RegisterNUICallback("accepttrade", function()
        TriggerServerEvent("MP:AcceptTrade")
end)

RegisterNUICallback("canceltrade", function()
        TriggerServerEvent("MP:CancelTrade")
end)

RegisterNUICallback("changemoneytrade", function(data)
        if data["money"] == nil then return end
        TriggerServerEvent("MP:ChangeMoneyInTrade", data["money"])
end)

RegisterNUICallback("changekcointrade", function(data)
        if data["kcoin"] == nil then return end
        TriggerServerEvent("MP:ChangeKcoinInTrade", data["kcoin"])
end)

RegisterNetEvent("MP:ChangeMoneyTrader")
AddEventHandler("MP:ChangeMoneyTrader", function(money)
        SendNUIMessage({
                type = "trade",
                action = "refreshmoneytrader",
                value = money
            })
end)

RegisterNetEvent("MP:ChangeKcoinTrader")
AddEventHandler("MP:ChangeKcoinTrader", function(money)
        SendNUIMessage({
                type = "trade",
                action = "refreshkcoinsytrader",
                value = money
            })
end)