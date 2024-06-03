MP = exports["k9pvp"]:getSharedObject()
local ModeDeJeu = "pvp"

AddEventHandler('onClientResourceStop', function(resource)
    if resource == "k9pvp" then
        TriggerServerEvent("MP:goat", resource)
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == "k9pvp" then
        MP = exports["k9pvp"]:getSharedObject()
    end
end)

RegisterNUICallback("GoArena", function(data)
        if data == nil then return end
        if data["name"] == nil then return end
        TriggerServerEvent("MP:GoArena", data["name"])
end)

local url = ""
local aaaa = false
lancienbool = false
checkrpf = false

exports("CheckRpf", function(bool)
      checkrpf = bool
        if bool then
            Display({
                bool = false
            })
        end
end)

exports("ModeDeJeu", function(str)
        ModeDeJeu = str
        SendNUIMessage({
                type = "setmodedejeu",
                value = str
       })
end)

RegisterNetEvent("MP:UpdatePPSteam")
AddEventHandler("MP:UpdatePPSteam", function(url)
    SendNUIMessage({
        type = "ppsteam",
        urlpp = url,
    })
end)

RegisterNetEvent("gfx-inventory:OpenInventory")
AddEventHandler("gfx-inventory:OpenInventory", function(data, page)
    if checkrpf then return end
    data.bool = true
    Display(data, page)
    local xPlayer = MP.GetPlayerData()
    local level, _, pourcentage = GetLevel()
    SendNUIMessage({
        type = "dowlylapute",
        stats = xPlayer.stats,
        name = xPlayer.name,
        idunique = xPlayer.idunique,
        money = MP.GroupDigits(xPlayer.account["bank"]),
        transaction = {},
        level = {level, pourcentage},
        pays = xPlayer.pays,
        kcoin = xPlayer.coin,
       	crew = lecrew,
    })
    --end)
end)

RegisterNetEvent("MP:RefreshKit")
AddEventHandler("MP:RefreshKit", function(kit)
    SendNUIMessage({
        type = "refreshkit",
        kit = kit
    })
end)

local function searchLePlayerInLeaderboard(data, identifier)
    for i = 1, #data do
        if data[i].identifier == identifier then
            data[i].placement = i
            return data[i]
        end
    end
    return false
end

RegisterNetEvent("MP:RefreshLeaderbord")
AddEventHandler("MP:RefreshLeaderbord", function(data)
    SendNUIMessage({
        type = "leaderboard",
        leaderboard = data,
        myplacement = searchLePlayerInLeaderboard(data, MP.GetPlayerData().identifier)
    })
end)

RegisterNetEvent("MP:RefreshLeaderbordCrew")
AddEventHandler("MP:RefreshLeaderbordCrew", function(data)
    print("refresh")
    SendNUIMessage({
        type = "leaderboardcrew",
        leaderboardcrew = data,
    })
end)

RegisterNetEvent("MP:updateppsteam")
AddEventHandler("MP:updateppsteam", function(urls)
    url = urls
    SendNUIMessage({
        type = "ppsteam",
        url = urls,
    })
end)

RegisterNetEvent("MP:PlayerLoad")
AddEventHandler("MP:PlayerLoad", function(player)
    SendNUIMessage({
        type = "defi",
        action = "refresh",
        data = player["defi"],
    })
    SendNUIMessage({
          type = "initialisation",
          data = player["parameter"]
   	})
end)

RegisterNetEvent("MP:RefreshDefi")
AddEventHandler("MP:RefreshDefi", function(info)
    SendNUIMessage({
        type = "defi",
        action = "refresh",
        data = info,
    })
end)

RegisterNUICallback("takekit", function(data)
    TriggerServerEvent("MP:TakeKit", data.kit)
end)

local incombatmode = false

exports("combatmode", function(bool)
        incombatmode = bool
        SendNUIMessage({
                type = "setcombatmode",
                bool = bool
       })
end)

local function searchItem(inventaire, item)
    for i = 1, #PlayerItems[inventaire] do
        if PlayerItems[inventaire][i] then
            if PlayerItems[inventaire][i].name == item then
                return true, PlayerItems[inventaire][i], i
            end
        end
    end
    return false
end

RegisterNUICallback("ItemDrag", function(data)
    --if (incombatmode or IsPedShooting(PlayerPedId())) and data.toType == "protected" then MP.ShowNotification("You can't put an item while in combat mode.") return end
    --if ModeDeJeu == "deluxotricks" or ModeDeJeu == "gungame" or ModeDeJeu == "deathmatch" then return end
    --if isarena then ESX.ShowNotification("You are in the arena") return end

local bool, litem, i = searchItem(data.fromType, data.itemName)
    if bool then
        if litem.count >= data.count then
            local bool2, litem2 = searchItem(data.toType, data.itemName)
            if bool2 then
                    litem2.count = litem2.count + data.count
            else
                    local aaa = {
                        {name = litem.name, count = data.count, rarity = "rare"}
                    }
                    local aa = FormatItems(aaa)
                    table.insert(PlayerItems[data.toType], aa[1])
            end
            litem.count = litem.count - data.count
            if litem.count <= 0 then
                 table.remove(PlayerItems[data.fromType], i)
            end
        end
    end
    		TriggerServerEvent("gfx-inventory:ItemDrag", data)
 
end)

RegisterNUICallback("leavea", function(data)
    ExecuteCommand("leave")
end)

RegisterNUICallback("SetHotbar", function(data)
    TriggerServerEvent("gfx-inventory:UpdateHotbar", data)
end)

RegisterNUICallback("Close", function(data)
    Display({
        bool = false
    })
end)

RegisterNUICallback("RemoveItem", function(data)
    TriggerServerEvent("gfx-inventory:RemoveItem", data)
end)

RegisterNetEvent("gfx-inventory:UpdateInventory", function(value, inventoryType, index, key)
    if inventoryType then
        if index then
            if key then
                PlayerItems[inventoryType][index][key] = value
            else
                if value == nil then
                    table.remove(PlayerItems[inventoryType], index)
                else
                    PlayerItems[inventoryType][index] = value
                end
            end
        else
            PlayerItems[inventoryType] = value
        end
    else
        PlayerItems = value
    end
    if isOpened then
        UpdateInventory(openedInventoryType)
    end
end)

RegisterNetEvent("gfx-inventory:SetHotbar", function(value, key, index)
    if key then
        if not index then
            HotbarData[key] = value
        else
            HotbarData[key][index] = value
        end
    else
        HotbarData = value
    end
    for k,v in pairs(HotbarData) do
        if v and v.name and v.hasItem then
            v.image = Items[v.name].image
            v.label = Items[v.name].label
            v.rarity = Items[v.name].rarity
        end
    end
    SetHotbar()
end)




RegisterNetEvent("gfx-inventory:client:OnItemUsed", function(itemName, info)
    -- if Items[itemName].type == "weapon" then
    --     UseWeapon(itemName, info)
    --     local armes = exports["k9-heal"]:GetLabel(GetHashKey(itemName))
    --     if armes ~= nil then
    --         ESX.ShowNotification("~b~Equipping~w~ your ~w~" ..armes)
    --     end
    -- end 
end)

RegisterNetEvent("gfx-inventory:client:RemoveWeapon", function(itemName)
    -- local ped = PlayerPedId()
    -- local weaponHash = GetHashKey(itemName)
    -- if weaponHash == GetSelectedPedWeapon(PlayerPedId()) then
    --     RemoveWeaponFromPed(ped, weaponHash)
    -- end
    -- if GetVehiclePedIsIn(PlayerPedId(), false) ~= 0 then
    --     RemoveAllPedWeapons(ped)
    -- end
end)

RegisterNUICallback("SetParameter", function(data)
        if data["categorie"] == "fpsboost" then
            exports["k9pvp"]:fpsbooster(data["value"])
        end
        TriggerServerEvent("MP:SetParameter", data)
end)