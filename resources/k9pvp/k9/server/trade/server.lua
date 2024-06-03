local alltrade = {
    ["inattente"] = {},
    ["inprogress"] = {},
}

local idtrade = 0

function CancelTradeInProgress(id)
    local letrade = alltrade["inprogress"][id]
    if letrade then
        for i = 1, #letrade["player"] do
            local xPlayer = MP.GetPlayerFromIdUnique(tonumber(letrade["player"][i]))
            if xPlayer then
                xPlayer.TradeID = 0
                xPlayer.InTrade = false
                TriggerClientEvent("MP:CancelTrade", xPlayer.source)
                xPlayer.showNotification("~r~Trade Cancel")
            end
        end
        alltrade["inprogress"][id] = nil
    end
end

local function FinTradeInProgress(id)
    local letrade = alltrade["inprogress"][id]
    for i = 1, #letrade["player"] do
        local xPlayer = MP.GetPlayerFromIdUnique(tonumber(letrade["player"][i]))
        if xPlayer then
            xPlayer.TradeID = 0
            xPlayer.InTrade = false
            TriggerClientEvent("MP:CancelTrade", xPlayer.source)
            xPlayer.showNotification("~g~Trade success")
        end
    end
    alltrade["inprogress"][id] = nil
end

RegisterCommand("trade", function(source, args)
        local idplayer = tonumber(args[1])
        if idplayer == nil then return end
        local xPlayer = MP.Player[source]
        if xPlayer.ModeDeJeu ~= "pvp" then xPlayer.showNotification("~r~You are not in pvp") return end
        if MP.GiveMode then xPlayer.showNotification("~r~Impossible at the moment") return end
        if alltrade["inattente"][xPlayer.idunique] then return end
        if xPlayer.InTrade then return end
        local xTarget = MP.GetPlayerFromIdUnique(idplayer)
        if xPlayer.cheatermonde ~= xTarget.cheatermonde then return end
        if xTarget then
            if not xTarget["parameter"]["privacy"]["trade"] then xPlayer.showNotification("~r~Player does not accept trade requests") return end
            if xTarget.InTrade then xPlayer.showNotification("~r~Player already in trading") return end
            if xTarget.ModeDeJeu ~= "pvp" then xPlayer.showNotification("~r~Player is not in pvp") return end
            alltrade["inattente"][xPlayer.idunique] = xTarget.idunique
            SetTimeout(15000, function()
                    if alltrade["inattente"][xPlayer.idunique] then
                        alltrade["inattente"][xPlayer.idunique] = nil
                   	end
            end)
            xPlayer.showNotification("Trade Send")
            xTarget.showNotification("You just received a trade from "..xPlayer.name.." ["..xPlayer.idunique.."] make /tradeaccept "..xPlayer.idunique.." to accept the traded")
        else
            xPlayer.showNotification("~r~Player not online")
        end
end)

RegisterCommand("tradeaccept", function(source, args)
        local idplayer = tonumber(args[1])

        if idplayer == nil then return end
        local xPlayer = MP.Player[source]
        if xPlayer.ModeDeJeu ~= "pvp" then xPlayer.showNotification("~r~You are not in pvp") return end
        if MP.GiveMode then xPlayer.showNotification("~r~Impossible at the moment") return end
        if idplayer == xPlayer.idunique then return end
        if alltrade["inattente"][idplayer] == nil then return end

        if alltrade["inattente"][idplayer] ~= xPlayer.idunique then return end
        if xPlayer.InTrade then return end
        local xTarget = MP.GetPlayerFromIdUnique(idplayer)
        if xPlayer.cheatermonde ~= xTarget.cheatermonde then return end
        if xTarget then
            if xTarget.InTrade then xPlayer.showNotification("~r~Player already in trading") return end
            if xPlayer.ModeDeJeu ~= "pvp" then xPlayer.showNotification("~r~You are not in pvp") return end
            alltrade["inattente"][idplayer] = nil
            idtrade = idtrade + 1
            local id = idtrade
            xPlayer.TradeID = id
            xTarget.TradeID = id
            xPlayer.InTrade = true
            xTarget.InTrade = true
            local xPlayerinventory = exports["k9-inventory"]:GetInventory(xPlayer.source, "inventory")
            local xTargetinventory = exports["k9-inventory"]:GetInventory(xTarget.source, "inventory")
            for i = 1, #xPlayerinventory do
                local lename = xPlayerinventory[i].name
                xPlayerinventory[i].label = MP.LabelItem[lename]
            end
            for i = 1, #xTargetinventory do
                local lenames = xTargetinventory[i].name
                xTargetinventory[i].label = MP.LabelItem[lenames]
            end
            alltrade["inprogress"][id] = {}
            alltrade["inprogress"][id][xPlayer.idunique] = {
                ["inventory"] = xPlayerinventory,
                ["trade"] = {},
                ["money"] = 0,
                ["kcoin"] = 0,
            }
            alltrade["inprogress"][id][xTarget.idunique] = {
                ["inventory"] = xTargetinventory,
                ["trade"] = {},
                ["money"] = 0,
                ["kcoin"] = 0,
            }
            alltrade["inprogress"][id]["player"] = {xPlayer.idunique, xTarget.idunique}
            alltrade["inprogress"][id]["cancel"] = false
            alltrade["inprogress"][id]["accept"] = {
                [xPlayer.idunique] = false,
                [xTarget.idunique] = false,
            }
            TriggerClientEvent("MP:TradeAccept", xPlayer.source, xPlayerinventory, xTargetinventory, id, {["me"] = {pp = xPlayer.ppsteam, name = xPlayer.name, id = xPlayer.idunique}, ["trader"] = {pp = xTarget.ppsteam, name = xTarget.name, id = xTarget.idunique}})
            TriggerClientEvent("MP:TradeAccept", xTarget.source, xTargetinventory, xPlayerinventory, id, {["me"] = {pp = xTarget.ppsteam, name = xTarget.name, id = xTarget.idunique}, ["trader"] = {pp = xPlayer.ppsteam, name = xPlayer.name, id = xPlayer.idunique}})
        end
end)

local function searchItemInInventory(name, inv)
    for i = 1, #inv do
        if inv[i].name == name then
            return true, i
        end
    end
end

local function searchItemInTrade(name, trade)
    for i = 1, #trade do
        if trade[i].name == name then
            return true, i
        end
    end
end

local function searchPlayerInTrade(idunique, p)
    for i = 1, #p do
        if tonumber(p[i]) ~= tonumber(idunique) then
            return tonumber(p[i])
        end
    end
end

RegisterServerEvent("MP:SwitchTrade")
AddEventHandler("MP:SwitchTrade", function(name, to)
        local xPlayer = MP.Player[source]
        if not xPlayer.InTrade then return end
        if xPlayer.TradeID == 0 then return end
        if to ~= "inventory" and to ~= "trade" then return end
        local iduniquextarget = searchPlayerInTrade(xPlayer.idunique, alltrade["inprogress"][xPlayer.TradeID]["player"])
        if alltrade["inprogress"][xPlayer.TradeID]["accept"][xPlayer.idunique] and alltrade["inprogress"][xPlayer.TradeID]["accept"][iduniquextarget] then return end
        if alltrade["inprogress"][xPlayer.TradeID]["accept"][xPlayer.idunique] then
            alltrade["inprogress"][xPlayer.TradeID]["accept"][xPlayer.idunique] = false
            TriggerClientEvent("MP:SetAcceptTrade", xPlayer.source, "me", false)
            local xTargets = MP.GetPlayerFromIdUnique(iduniquextarget)
            if xTargets then
                TriggerClientEvent("MP:SetAcceptTrade", xTargets.source, "trader", false)
            end
        end
        if alltrade["inprogress"][xPlayer.TradeID]["accept"][iduniquextarget] then
            alltrade["inprogress"][xPlayer.TradeID]["accept"][iduniquextarget] = false
            TriggerClientEvent("MP:SetAcceptTrade", xPlayer.source, "trader", false)
            local xTargetss = MP.GetPlayerFromIdUnique(iduniquextarget)
            if xTargetss then
                TriggerClientEvent("MP:SetAcceptTrade", xTargetss.source, "me", false)
            end
        end
        local from = to == "inventory" and "trade" or "inventory"
        local tradeincours = alltrade["inprogress"][xPlayer.TradeID][xPlayer.idunique]
        local bool, i = searchItemInInventory(name, tradeincours[from])
        if not bool then return end
        tradeincours[from][i].count = tradeincours[from][i].count - 1
        local boole, d = searchItemInTrade(name, tradeincours[to])
        if boole then
            tradeincours[to][d].count = tradeincours[to][d].count + 1
        else
            table.insert(tradeincours[to], {name = name, label = tradeincours[from][i].label, count = 1})
        end
        if tradeincours[from][i].count <= 0 then
            table.remove(tradeincours[from], i)
        end
        
        if iduniquextarget then
            local xTarget = MP.GetPlayerFromIdUnique(iduniquextarget)
            if xTarget then
                TriggerClientEvent("MP:RefreshTrade", xPlayer.source, "me", tradeincours["inventory"], tradeincours["trade"])
                TriggerClientEvent("MP:RefreshTrade", xTarget.source, "trader", tradeincours["inventory"], tradeincours["trade"])
            end
        end
end)

local function isInventoryIsGood(src, name, count)
    local inventory = exports["k9-inventory"]:GetInventory(src, "inventory")
    for i = 1, #inventory do
        if inventory[i].name == name and inventory[i].count >= count then
            return true
        end
    end
    return false
end

RegisterServerEvent("MP:AcceptTrade")
AddEventHandler("MP:AcceptTrade", function()
        local xPlayer = MP.Player[source]
        if not xPlayer.InTrade then return end
        if xPlayer.TradeID == 0 then return end
        local idtrade = xPlayer.TradeID
        local tradeaccept = alltrade["inprogress"][xPlayer.TradeID]["accept"]
        if tradeaccept[xPlayer.idunique] then return end
        tradeaccept[xPlayer.idunique] = true
        local iduniquextarget = searchPlayerInTrade(xPlayer.idunique, alltrade["inprogress"][xPlayer.TradeID]["player"])
        local xTarget = MP.GetPlayerFromIdUnique(iduniquextarget)
        TriggerClientEvent("MP:SetAcceptTrade", xPlayer.source, "me", true)
        if xTarget then
       		TriggerClientEvent("MP:SetAcceptTrade", xTarget.source, "trader", true)
        end
        if tradeaccept[xPlayer.idunique] and tradeaccept[iduniquextarget] then
            
            TriggerClientEvent("MP:ShowTimerTrade", xPlayer.source)
            if xTarget then
                TriggerClientEvent("MP:ShowTimerTrade", xTarget.source)
            end
            Citizen.Wait(5000)
            if alltrade["inprogress"][idtrade] and not alltrade["inprogress"][idtrade]["cancel"] then
                xTarget = MP.GetPlayerFromIdUnique(iduniquextarget)
                if xPlayer.cheatermonde ~= xTarget.cheatermonde then CancelTradeInProgress(idtrade) return end
                if xTarget and xPlayer then
                    local boolxPlayer = false
                    for i = 1, #alltrade["inprogress"][idtrade][xPlayer.idunique]["trade"] do
                        local name, count = alltrade["inprogress"][idtrade][xPlayer.idunique]["trade"][i].name, alltrade["inprogress"][idtrade][xPlayer.idunique]["trade"][i].count
                        if not isInventoryIsGood(xPlayer.source, name, count) then
                            boolxPlayer = true
                        end
                   	end
                    if boolxPlayer then
                        CancelTradeInProgress(idtrade)
                        return 
                    end
                    local boolxTarget = false
                    for i = 1, #alltrade["inprogress"][idtrade][xTarget.idunique]["trade"] do
                        local name, count = alltrade["inprogress"][idtrade][xTarget.idunique]["trade"][i].name, alltrade["inprogress"][idtrade][xTarget.idunique]["trade"][i].count
                        if not isInventoryIsGood(xTarget.source, name, count) then
                            boolxTarget = true
                        end
                   	end
                    if boolxTarget then
                        CancelTradeInProgress(idtrade)
                        return
                    end
                    if alltrade["inprogress"][idtrade][xPlayer.idunique]["money"] < 0 then CancelTradeInProgress(idtrade) return end
                    if alltrade["inprogress"][idtrade][xTarget.idunique]["money"] < 0 then CancelTradeInProgress(idtrade) return end
                    if alltrade["inprogress"][idtrade][xPlayer.idunique]["kcoin"] < 0 then CancelTradeInProgress(idtrade) return end
                    if alltrade["inprogress"][idtrade][xTarget.idunique]["kcoin"] < 0 then CancelTradeInProgress(idtrade) return end
                    if xPlayer.getAccount("bank") < alltrade["inprogress"][idtrade][xPlayer.idunique]["money"] then CancelTradeInProgress(idtrade) return end
                    if xTarget.getAccount("bank") < alltrade["inprogress"][idtrade][xTarget.idunique]["money"] then CancelTradeInProgress(idtrade) return end
                    if xPlayer.coin < alltrade["inprogress"][idtrade][xPlayer.idunique]["kcoin"] then CancelTradeInProgress(idtrade) return end
                    if xTarget.coin < alltrade["inprogress"][idtrade][xTarget.idunique]["kcoin"] then CancelTradeInProgress(idtrade) return end
                    if xPlayer.ModeDeJeu ~= "pvp" then CancelTradeInProgress(idtrade) return end
                    if xTarget.ModeDeJeu ~= "pvp" then CancelTradeInProgress(idtrade) return end
                    local logsdiscord = {
                        ["inventorytrade"] = "",
                        ["inventorytradertrade"] = "",
                        ["moneytrade"] = "0$",
                        ["moneytradertrade"] = "0$",
                        ["kcoinstrade"] = "0 KCoins",
                        ["kcoinstradertrade"] = "0 KCoins",
                    }
                    for i = 1, #alltrade["inprogress"][idtrade][xPlayer.idunique]["trade"] do
                        local name, count, label = alltrade["inprogress"][idtrade][xPlayer.idunique]["trade"][i].name, alltrade["inprogress"][idtrade][xPlayer.idunique]["trade"][i].count, alltrade["inprogress"][idtrade][xPlayer.idunique]["trade"][i].label
                        exports["k9-inventory"]:RemoveItem(xPlayer.source, "inventory", name, count)
                        exports["k9-inventory"]:AddItem(xTarget.source, "inventory", name, count, "Trade ID : ("..idtrade..")")
                        local len = ""
                        if alltrade["inprogress"][idtrade][xPlayer.idunique]["trade"][i+1] then
                            len = "\n"
                        end
                        logsdiscord["inventorytrade"] = logsdiscord["inventorytrade"].. "" ..count.. "x " ..label.. " " ..len
                   end
                    for i = 1, #alltrade["inprogress"][idtrade][xTarget.idunique]["trade"] do
                        local name, count, label = alltrade["inprogress"][idtrade][xTarget.idunique]["trade"][i].name, alltrade["inprogress"][idtrade][xTarget.idunique]["trade"][i].count, alltrade["inprogress"][idtrade][xTarget.idunique]["trade"][i].label
                        exports["k9-inventory"]:RemoveItem(xTarget.source, "inventory", name, count)
                        exports["k9-inventory"]:AddItem(xPlayer.source, "inventory", name, count, "Trade ID : ("..idtrade..")")
                        local len = ""
                        if alltrade["inprogress"][idtrade][xPlayer.idunique]["trade"][i+1] then
                            len = "\n"
                        end
                        logsdiscord["inventorytradertrade"] = logsdiscord["inventorytradertrade"].. "" ..count.. "x " ..label.. " " ..len
                   end
                    if alltrade["inprogress"][idtrade][xPlayer.idunique]["money"] >= 1 then
                        xPlayer.removeAccountMoney("bank", alltrade["inprogress"][idtrade][xPlayer.idunique]["money"])
                        xTarget.addAccountMoney("bank", alltrade["inprogress"][idtrade][xPlayer.idunique]["money"])
                        logsdiscord["moneytrade"] = alltrade["inprogress"][idtrade][xPlayer.idunique]["money"].. "$"
                    end
                    if alltrade["inprogress"][idtrade][xTarget.idunique]["money"] >= 1 then
                        xTarget.removeAccountMoney("bank", alltrade["inprogress"][idtrade][xTarget.idunique]["money"])
                        xPlayer.addAccountMoney("bank", alltrade["inprogress"][idtrade][xTarget.idunique]["money"])
                        logsdiscord["moneytradertrade"] = alltrade["inprogress"][idtrade][xTarget.idunique]["money"].. "$"
                    end
                    if alltrade["inprogress"][idtrade][xPlayer.idunique]["kcoin"] >= 1 then
                        xPlayer.removeCoin(alltrade["inprogress"][idtrade][xPlayer.idunique]["kcoin"])
                        xTarget.addCoin(alltrade["inprogress"][idtrade][xPlayer.idunique]["kcoin"])
                        logsdiscord["kcoinstrade"] = alltrade["inprogress"][idtrade][xPlayer.idunique]["kcoin"].. " KCoins"
                    end
                    if alltrade["inprogress"][idtrade][xTarget.idunique]["kcoin"] >= 1 then
                        xTarget.removeCoin(alltrade["inprogress"][idtrade][xTarget.idunique]["kcoin"])
                        xPlayer.addCoin(alltrade["inprogress"][idtrade][xTarget.idunique]["kcoin"])
                        logsdiscord["kcoinstradertrade"] = alltrade["inprogress"][idtrade][xTarget.idunique]["kcoin"].. " KCoins"
                    end
                    MP.SendWebhook("Trade Success", "ID TRADE : **"..xPlayer.TradeID.."** \n \nTrader 1 : **[" ..xPlayer.idunique.. "] " ..xPlayer.name.. "** \nTrader 2 : **[" ..xTarget.idunique.."] " ..xTarget.name.. "** \n \nTrader 1 Inventory : \n**" ..logsdiscord["inventorytrade"].. "** \nTrader 2 Inventory : \n**" ..logsdiscord["inventorytradertrade"].. "** \n \nTrader 1 Money : **" ..logsdiscord["moneytrade"].. "** \nTrader 2 Money : **" ..logsdiscord["moneytradertrade"].. "** \n \nTrader 1 KCoins : **" ..logsdiscord["kcoinstrade"].. "** \nTrader2 KCoins : **" ..logsdiscord["kcoinstradertrade"].. "**", "Identifier 1 : " ..xPlayer.identifier.. " | Identifier 2 : " ..xTarget.identifier, "https://discord.com/api/webhooks/1204011191891132426/mOKmJHjH29d2ay-DJyBwHy6xtz1S2Y0Af3CxR6R2XL5qO4IwfEkg-BtQ3h0EDXruLknW")
                   FinTradeInProgress(idtrade)
                end
            end
        end
end)

RegisterServerEvent("MP:ChangeMoneyInTrade")
AddEventHandler("MP:ChangeMoneyInTrade", function(money)
        local lamoney = tonumber(money)
        if lamoney == nil then return end
        local xPlayer = MP.Player[source]
        if not xPlayer.InTrade then return end
        if xPlayer.TradeID == 0 then return end
        local iduniquextarget = searchPlayerInTrade(xPlayer.idunique, alltrade["inprogress"][xPlayer.TradeID]["player"])
        local xTarget = MP.GetPlayerFromIdUnique(iduniquextarget)
        if alltrade["inprogress"][xPlayer.TradeID]["accept"][xPlayer.idunique] and alltrade["inprogress"][xPlayer.TradeID]["accept"][iduniquextarget] then return end
        if alltrade["inprogress"][xPlayer.TradeID]["accept"][xPlayer.idunique] then
            alltrade["inprogress"][xPlayer.TradeID]["accept"][xPlayer.idunique] = false
            TriggerClientEvent("MP:SetAcceptTrade", xPlayer.source, "me", false)
            if xTarget then
                TriggerClientEvent("MP:SetAcceptTrade", xTarget.source, "trader", false)
            end
        end
        if alltrade["inprogress"][xPlayer.TradeID]["accept"][iduniquextarget] then
            alltrade["inprogress"][xPlayer.TradeID]["accept"][iduniquextarget] = false
            TriggerClientEvent("MP:SetAcceptTrade", xPlayer.source, "trader", false)
            if xTarget then
                TriggerClientEvent("MP:SetAcceptTrade", xTarget.source, "me", false)
            end
        end
        if alltrade["inprogress"][xPlayer.TradeID][xPlayer.idunique]["money"] == lamoney then return end
        alltrade["inprogress"][xPlayer.TradeID][xPlayer.idunique]["money"] = lamoney
        
        
        if xTarget then
        	TriggerClientEvent("MP:ChangeMoneyTrader", xTarget.source, lamoney)
        end
            
end)

RegisterServerEvent("MP:ChangeKcoinInTrade")
AddEventHandler("MP:ChangeKcoinInTrade", function(money)
        local lamoney = tonumber(money)
        if lamoney == nil then return end
        local xPlayer = MP.Player[source]
        if not xPlayer.InTrade then return end
        if xPlayer.TradeID == 0 then return end
        if alltrade["inprogress"][xPlayer.TradeID][xPlayer.idunique]["kcoin"] == lamoney then return end
        local iduniquextarget = searchPlayerInTrade(xPlayer.idunique, alltrade["inprogress"][xPlayer.TradeID]["player"])
        local xTarget = MP.GetPlayerFromIdUnique(iduniquextarget)
        if alltrade["inprogress"][xPlayer.TradeID]["accept"][xPlayer.idunique] and alltrade["inprogress"][xPlayer.TradeID]["accept"][iduniquextarget] then return end
        if alltrade["inprogress"][xPlayer.TradeID]["accept"][xPlayer.idunique] then
            alltrade["inprogress"][xPlayer.TradeID]["accept"][xPlayer.idunique] = false
            TriggerClientEvent("MP:SetAcceptTrade", xPlayer.source, "me", false)
            if xTarget then
                TriggerClientEvent("MP:SetAcceptTrade", xTarget.source, "trader", false)
            end
        end
        if alltrade["inprogress"][xPlayer.TradeID]["accept"][iduniquextarget] then
            alltrade["inprogress"][xPlayer.TradeID]["accept"][iduniquextarget] = false
            TriggerClientEvent("MP:SetAcceptTrade", xPlayer.source, "trader", false)
            if xTarget then
                TriggerClientEvent("MP:SetAcceptTrade", xTarget.source, "me", false)
            end
        end
        alltrade["inprogress"][xPlayer.TradeID][xPlayer.idunique]["kcoin"] = lamoney
        
        
        if xTarget then
        	TriggerClientEvent("MP:ChangeKcoinTrader", xTarget.source, lamoney)
        end
            
end)

RegisterServerEvent("MP:CancelTrade")
AddEventHandler("MP:CancelTrade", function()
        local xPlayer = MP.Player[source]
        if not xPlayer.InTrade then return end
        if xPlayer.TradeID == 0 then return end
        CancelTradeInProgress(xPlayer.TradeID)
end)