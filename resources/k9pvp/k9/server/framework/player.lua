function CreatePlayer(info)
    local self = {}
    self.identifier = info.identifier
    self.license = info.license
    self.idunique = info.idunique
    self.source = info.source
    self.name = GetPlayerName(info.source)
    self.account = info.account
    self.position = info.position
    self.group = info.group
    self.coin = info.coin
    self.ip = info.ip
    self.stats = info.stats
    self.infoip = {}
    self.infoipready = false
    self.ischeckvpn = false
    self.ischeckrpf = false
    self.istp = false
    self.isvip = info.isvip
    self.vip = info.vip
    self.player = {}
    self.inventory = {}
    self.cuff = {}
    self.variable = {}
    self.reasondead = ""
    self.ModeDeJeu = "lobby"
    self.inSafezone = false
    self.defi = info.defi
    self.kit = info.kit
    self.combokill = 0
    self.ppsteam = ""
    self.ppsteamcache = ""
    self.InTrade = false
    self.TradeID = 0
    self.parameter = info.parameter
    self.anciencoords = vector3(0,0,0)
    self.timevip = info.timevip
    self.xp = info.xp
    self.pays = "Inconnu"
    self.isspawnvehicle = false
    self.deathmessage = info.deathmessage
    self.cheatermonde = info.cheatermonde
    
    self.setPays = function(pays)
        self.pays = pays
        TriggerClientEvent("MP:SetPlayerData", self.source, self)
    end
    
    self.addXp = function(xp)
        self.xp = self.xp + xp
        TriggerClientEvent("XNL_NET:AddPlayerXP", self.source, xp)
    end
    
    self.refreshMyClient = function()
        TriggerClientEvent("MP:SetPlayerData", self.source, self)
    end
    self.AddStats = function(mode, name)
        self.stats = AddStatsPlayer(self.identifier, mode, name)
        TriggerClientEvent("MP:SetPlayerData", self.source, self)
    end
    
    self.RefreshKit = function()
        TriggerClientEvent("MP:RefreshKit", self.source, self.kit)
        TriggerClientEvent("MP:SetPlayerData", self.source, self)
    end
    
    self.RefreshDefi = function(def, name)
        if name == nil then
            self.defi = def
        else
            self.defi[name] = def
        end
        TriggerClientEvent("MP:RefreshDefi", self.source, self.defi)
    end
    
    self.CompleteDefi = function(id, value)
        for k, v in pairs(MP.AllDefi) do
            for i = 1, #self.defi[k] do
                if self.defi[k][i].id == id and not self.defi[k][i].bool then
                    if (self.defi[k][i].value + value) >= self.defi[k][i].maxvalue then
                        self.defi[k][i].value = self.defi[k][i].maxvalue
                        self.defi[k][i].bool = true
                    else
                        self.defi[k][i].value = self.defi[k][i].value + value
                    end
                    TriggerClientEvent("MP:RefreshDefi", self.source, self.defi)
                    TriggerClientEvent("MP:ShowDefi", self.source, {id = id, text = self.defi[k][i].label, value = self.defi[k][i].value, maxvalue = self.defi[k][i].maxvalue})
                end
            end
        end
    end
    self.HasDefi = function(id)
        for k, v in pairs(MP.AllDefi) do
            for i = 1, #self.defi[k] do
                if self.defi[k][i].id == id and not self.defi[k][i].bool then
                    return true
                end
            end
        end
        return false
    end
    
    self.setReasonDead = function(name, raison)
        self.reasondead = "Tué par : " ..name.. " \nArme : " ..raison
        UpdateNbPlayer()
    end
    
    self.setPlayer = function(nb)
        --self.player = nb
        --TriggerClientEvent("MP:SetPlayerData", self.source, self)
    end
    
    self.setVip = function(bool)
        self.isvip = bool
        if not bool then
            self.vip = 0
        end
        TriggerClientEvent("MP:SetPlayerData", self.source, self)
    end
    
    self.addVip = function(int, time)
        self.isvip = true
        self.vip = int
        self.timevip = time
        TriggerClientEvent("MP:SetPlayerData", self.source, self)
    end
    
    self.showAdvancedNotification = function(sender, subject, msg, textureDict, iconType, flash, saveToBrief, hudColorIndex)
		TriggerClientEvent('MP:showAdvancedNotification', self.source, sender, subject, msg, textureDict, iconType, flash, saveToBrief, hudColorIndex)
	end
    
    self.setCoin = function(coin)
        self.coin = coin
        TriggerClientEvent("MP:SetPlayerData", self.source, self)
        return self.coin
    end
    self.removeCoin = function(coin)
        self.coin = self.coin - coin
        TriggerClientEvent("MP:SetPlayerData", self.source, self)
        return self.coin
    end
    self.addCoin = function(coin)
        self.coin = self.coin + coin
        TriggerClientEvent("MP:SetPlayerData", self.source, self)
        return self.coin
    end
    
    self.set = function(var, value)
        self.variable[var] = value
        TriggerClientEvent("MP:SetPlayerData", self.source, self)
    end
    
    self.get = function(var)
        return self.variable[var]
    end
    
    self.getGroup = function()
        return self.group
    end
    
    self.setGroup = function(name)
        self.group = name
        TriggerClientEvent("MP:SetPlayerData", self.source, self)
    end
    
    
    self.getAccount = function(acc)
        if acc then
            return self.account[acc]
        end
        return self.account
    end
    
    self.addAccountMoney = function(acc, money)
        self.account[acc] = self.account[acc] + money
        if acc == "bank" then
            if self.HasDefi(4) then
                self.CompleteDefi(4, money)
            end
        end
        TriggerClientEvent("MP:SetPlayerData", self.source, self)
        return self.account[acc]
    end
    
    self.removeAccountMoney = function(acc, money)
        self.account[acc] = self.account[acc] - money
        if acc == "bank" then
            if self.HasDefi(3) then
                self.CompleteDefi(3, money)
            end
        end
        TriggerClientEvent("MP:SetPlayerData", self.source, self)
        return self.account[acc]
    end
    
    self.isAssezArgent = function(acc, money)
        return (self.account[acc] - money >= 0)
    end
    
    self.showNotification = function(msg)
        TriggerClientEvent("MP:showNotification", self.source, msg)
    end

    self.addInventoryItem = function(name, count)
        --exports["av_inventory"]:addInventoryItem(self.license, name, count, "")
    end

    self.removeInventoryItem = function(name, count)
        --exports["av_inventory"]:removeInventoryItem(self.license, name, count)
    end

    self.getInventoryItem = function(name)
        --return exports["av_inventory"]:getInventoryItem(self.license, name)
    end
    
    self.getInventory = function()
        --return exports["av_inventory"]:getInventory(self.license)
    end
    
    self.getItemCount = function(item)
        --return exports["av_inventory"]:getItemCount(self.license, item)
    end
    
    self.canCarryItem = function(name, count)
        --return exports["av_inventory"]:canCarryItem(self.license, name, count)
    end
    
    self.canSwapItem = function(iteme, counte, item, count)
        --return exports["av_inventory"]:canSwapItem(self.license, iteme, counte, item, count)
    end
    
    self.hasWeapon = function(name)
        return (self.getItemCount(string.upper(name)) ~= 0)
    end
    self.addWeapon = function(name)
        self.addInventoryItem(string.upper(name), 1)
    end

    
    self.getName = function()
        return self.firstname.. " " ..self.name
    end

    self.setName = function(name)
        self.name = name
    end
    
    self.getIdentifier = function()
        return self.identifier
    end

    self.getLicense = function()
        return self.license
    end

    self.getIdUnique = function()
        return self.idunique
    end

    self.getId = function()
        return self.source
    end

    self.getMoney = function()
        return self.account["cash"]
    end
    self.addMoney = function(money)
        if type(money) == "number" then
            self.account["cash"] = self.account["cash"] + money
            TriggerClientEvent("MP:SetPlayerData", self.source, self)
        end
    end
    self.removeMoney = function(money)
        if type(money) == "number" then
            self.account["cash"] = self.account["cash"] - money
            TriggerClientEvent("MP:SetPlayerData", self.source, self)
        end
    end
    self.setMoney = function(money)
        if type(money) == "number" then
            self.account["cash"] = money
            TriggerClientEvent("MP:SetPlayerData", self.source, self)
        end
    end

    self.triggerEvent = function(name, ...)
        TriggerClientEvent(name, self.source, ...)
    end

    return self
end