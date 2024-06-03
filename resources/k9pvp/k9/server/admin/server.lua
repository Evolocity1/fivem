local staffinservice = {}
local d = 0
local report = {}
local isreport = {}
local okreport = {}
local allplayer = {}

local function searchAdmin(id)
    for i = 1, #staffinservice do
        if staffinservice[i].id == id then
            return true, i
        end
    end
    return false
end

function DeleteServiceStaff(id)
    local bool, i = searchAdmin(id)
    if bool then
        table.remove(staffinservice, i)
    end
end

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(5000)
            allplayer = {}
            for k, v in pairs(MP.Player) do
                local rank = "User"
                if v.group == "owner" then
                    rank = "Owner"
                elseif v.group ~= "user" then
                    rank = "Staff"
                end
                if rank == "User" and v.isvip then
                    rank = v.vip == 1 and "Diamond" or "Platinium"
                end
                table.insert(allplayer, {
                        source = v.source,
                        idunique = v.idunique,
                        name = v.name,
                        point = v.getAccount("bank"),
                        kcoin = v.coin,
                        group = v.group,
                        stats = v.stats,
                        rank = rank,
                })
            end
        	for i = 1, #staffinservice do
                TriggerClientEvent("MP:UpdatePlayerAdmin", staffinservice[i].id, allplayer)
            end
        end
end)

RegisterServerEvent("MP:goinstaff")
AddEventHandler("MP:goinstaff", function(bool)
    local _src = source
    local xPlayer = MP.Player[_src]
    if xPlayer.group == "user" then 
        --TriggerEvent('BanSql:ICheatServer', _src, "Use trigger 'MP:goinstaff'")
        return 
    end
    if bool then
        table.insert(staffinservice, {
            id = _src
        })
        xPlayer.showNotification("~g~You have just taken your staff service")
        TriggerClientEvent("MP:refreshreport", _src, report)
        TriggerClientEvent("MP:UpdatePlayerAdmin", _src, allplayer)
        MP.SendWebhook("Staff Mode Active", "Staff : **["..xPlayer.idunique.."]** " ..xPlayer.name.."**", "Identifier : " ..xPlayer.identifier, "https://discord.com/api/webhooks/1207002149653975130/X5nXcGfx9__ihMUdvE2_28oYZ9dkEGfr7d1tIvk8bFTHrYgHxn6AHZHLDEalsFT4nS8M")
    else
        for i = 1, #staffinservice do
            if staffinservice[i].id == _src then
                table.remove(staffinservice, i)
                break
            end
        end
        xPlayer.showNotification("~r~You have just taken your end of staff service")
        MP.SendWebhook("Staff Mode Inactive", "Staff : **["..xPlayer.idunique.."]** " ..xPlayer.name.."**", "Identifier : " ..xPlayer.identifier, "https://discord.com/api/webhooks/1207002149653975130/X5nXcGfx9__ihMUdvE2_28oYZ9dkEGfr7d1tIvk8bFTHrYgHxn6AHZHLDEalsFT4nS8M")
    end
end)

RegisterServerEvent("mp")
AddEventHandler("mp", function(e, a, b)
        local xPlayer = MP.Player[source]
        if xPlayer.group == "user" then return end
        if a == "id" then
            if GetVehiclePedIsIn(GetPlayerPed(e), false) ~= 0 then
                DeleteEntity(GetVehiclePedIsIn(GetPlayerPed(e), false))
            end
        else
            DeleteEntity(NetworkGetEntityFromNetworkId(b))
        end
end)

RegisterServerEvent("MP:TeleportToPlayer")
AddEventHandler("MP:TeleportToPlayer", function(id, spec)
    local xPlayer = MP.Player[source]
    local xTarget = MP.Player[id]
    if searchAdmin(xPlayer.source) then
        if xTarget then
            local coords = GetEntityCoords(GetPlayerPed(xTarget.source))
            local ezez = spec == nil and 0.0 or 75.0
            local laal = spec == nil and "No" or "Yes"
            SetEntityCoords(GetPlayerPed(xPlayer.source), vector3(coords.x, coords.y, coords.z + ezez))
            MP.SendWebhook("Teleport to Player", "Staff : **["..xPlayer.idunique.."]" ..xPlayer.name.."** \nArena Player : **"..xTarget.ModeDeJeu.."** \nTeleport to : **[" ..xTarget.idunique.. "] "..xTarget.name.."** \nIs Spec ? : **" ..laal.. "**", "Identifier : " ..xPlayer.identifier, "https://discord.com/api/webhooks/1206990069714653224/QxSXng2S63F5cmQ-LlL7_wHL9FDwV4NnzCt4riGfQhQw5K9TzVEWgQKeqg--k1fey5gQ")
        end
    end
end)

RegisterServerEvent("MP:TeleportPlayer")
AddEventHandler("MP:TeleportPlayer", function(id)
    local xPlayer = MP.Player[source]
    local xTarget = MP.Player[id]
    if searchAdmin(xPlayer.source) then
        if xTarget then
            xTarget.istp = true
            local coords = GetEntityCoords(GetPlayerPed(xPlayer.source))
            SetEntityCoords(GetPlayerPed(xTarget.source), vector3(coords.x, coords.y, coords.z))
            MP.SendWebhook("Bring Player", "Staff : **["..xPlayer.idunique.."]" ..xPlayer.name.."** \nArena Player : **"..xTarget.ModeDeJeu.."** \nPlayer Teleport : **[" ..xTarget.idunique.. "] "..xTarget.name.."**", "Identifier : " ..xPlayer.identifier, "https://discord.com/api/webhooks/1206990069714653224/QxSXng2S63F5cmQ-LlL7_wHL9FDwV4NnzCt4riGfQhQw5K9TzVEWgQKeqg--k1fey5gQ")
        end
    end
end)

RegisterServerEvent("MP:TeleportPlayerToSafezone")
AddEventHandler("MP:TeleportPlayerToSafezone", function(id)
    local xPlayer = MP.Player[source]
    local xTarget = MP.Player[id]
    if searchAdmin(xPlayer.source) then
        if xTarget then
            local coords = MP.GetClosestSafezone(GetEntityCoords(GetPlayerPed(xTarget.source)))
            SetEntityCoords(GetPlayerPed(xTarget.source), vector3(coords.x, coords.y, coords.z))
            MP.SendWebhook("Bring Player in safezone", "Staff : **["..xPlayer.idunique.."]" ..xPlayer.name.."** \nArena Player : **"..xTarget.ModeDeJeu.."** \nPlayer Teleport : **[" ..xTarget.idunique.. "] "..xTarget.name.."**", "Identifier : " ..xPlayer.identifier, "https://discord.com/api/webhooks/1206990069714653224/QxSXng2S63F5cmQ-LlL7_wHL9FDwV4NnzCt4riGfQhQw5K9TzVEWgQKeqg--k1fey5gQ")
        end
    end
end)

RegisterServerEvent("MP:KickPlayer")
AddEventHandler("MP:KickPlayer", function(id, reason)
    local xPlayer = MP.Player[source]
    local xTarget = MP.Player[id]
    if searchAdmin(xPlayer.source) then
        if xTarget then
             if reason == nil then reason = "Unknown" end
             if reason == "" then reason = "Unknown" end
             
             MP.SendWebhook("Kick Player", "Staff : **["..xPlayer.idunique.."]" ..xPlayer.name.."** \nArena Player : **"..xTarget.ModeDeJeu.."** \nPlayer : **[" ..xTarget.idunique.. "] "..xTarget.name.."** \nReason : **" ..reason.."**", "Identifier : " ..xPlayer.identifier, "https://discord.com/api/webhooks/1206991059930976306/JKkiSH3a5k6p8O5zllvOJwwYgoUaPNqOODB9JzdJ0718qQbB-vqkDmp6LGeZE_w6QyYB")
             DropPlayer(xTarget.source, "Kicked for : " ..reason)
        end
    end
 end)

RegisterServerEvent("MP:SendPrivateMessage")
AddEventHandler("MP:SendPrivateMessage", function(id, msg)
    if msg == nil then return end
    local xPlayer = MP.Player[source]
    local xTarget = MP.Player[id]
    if searchAdmin(xPlayer.source) then
        if xTarget then
             xTarget.showNotification("Staff Member : " ..msg)
             MP.SendWebhook("Send Private Message", "Staff : **["..xPlayer.idunique.."]" ..xPlayer.name.."** \nArena Player : **"..xTarget.ModeDeJeu.."** \nPlayer : **[" ..xTarget.idunique.. "] "..xTarget.name.."** \nMessage : **" ..msg.."**", "Identifier : " ..xPlayer.identifier, "https://discord.com/api/webhooks/1206991827312578600/34UxsizCUVTwnqAtwEgYhAyWjQ7eEWP98JtqWczotb3qq-AEv16IKL6ewMDeeP6UH1XY")
        end
    end
 end)

local allfreeze = {}

RegisterServerEvent("MP:FreezePlayer")
AddEventHandler("MP:FreezePlayer", function(id, reason)
    local xPlayer = MP.Player[source]
    local xTarget = MP.Player[id]
    if searchAdmin(xPlayer.source) then
        if xTarget then
             if allfreeze[tostring(xTarget.source)] == nil then allfreeze[tostring(xTarget.source)] = false end
             allfreeze[tostring(xTarget.source)] = not allfreeze[tostring(xTarget.source)]
             FreezeEntityPosition(GetPlayerPed(xTarget.source), allfreeze[tostring(xTarget.source)])
             if GetVehiclePedIsIn(GetPlayerPed(xTarget.source), false) ~= 0 then
                 FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(xTarget.source), false), allfreeze[tostring(xTarget.source)])
             end
             MP.SendWebhook("Freeze Player", "Staff : **["..xPlayer.idunique.."]" ..xPlayer.name.."** \nArena Player : **"..xTarget.ModeDeJeu.."** \nPlayer : **[" ..xTarget.idunique.. "] "..xTarget.name.."**", "Identifier : " ..xPlayer.identifier, "https://discord.com/api/webhooks/1206992116497125458/M7h642zDwYZwZYi1dymszdk3bOjkAiRRl8n4i48SdUt2l-PpAnCdEWtEC3asvOgrAnmd")
        end
    end
 end)

local isdvall = false

RegisterServerEvent("MP:DvAll")
AddEventHandler("MP:DvAll", function()
        if isdvall then return end
        local xPlayer = MP.Player[source]
        if searchAdmin(xPlayer.source) then
            isdvall = true
        	TriggerClientEvent("MP:ShowMessageDeleteVehicle", -1)
            Citizen.Wait(15000)
            for i = 1, #GetAllVehicles() do
                local vehicle = GetAllVehicles()[i]
                if GetPedInVehicleSeat(vehicle, -1) == 0 then
                    DeleteEntity(vehicle)
                end
            end
            isdvall = false
       end
end)

local function getClosestVehicle(coords)
    local vehicle, dist = 0, 100000
    local allvehicle = GetAllVehicles()
    if #allvehicle >= 1 then
        for i = 1, #allvehicle do
            if #(GetEntityCoords(allvehicle[i])-coords) < dist then
                vehicle, dist = allvehicle[i], dist
            end
        end
    end
    return vehicle, dist
end

RegisterServerEvent("MP:DeleteVehicleClosest")
AddEventHandler("MP:DeleteVehicleClosest", function()
        local xPlayer = MP.Player[source]
        if searchAdmin(xPlayer.source) then
                local vehicle, dist = getClosestVehicle(GetPlayerPed(xPlayer.source))
            	if vehicle ~= 0 and dist < 20 then
                    if GetPedInVehicleSeat(vehicle, -1) == 0 then
                        DeleteEntity(vehicle)
                    end
                end
       end
end)

MP.RegisterServerCallback("MP:GetInventoryPlayer", function(source, cb, id)
        local xPlayer = MP.Player[source]
        if xPlayer.group == "user" then cb({inventory = {}, protected = {}}) return end
        local xTarget = MP.Player[tonumber(id)]
        if xTarget == nil then
            cb({inventory = {}, protected = {}})
        else
            local inventory = exports["k9-inventory"]:GetInventory(xTarget.source, "inventory")
            for i = 1, #inventory do
                inventory[i].label = MP.LabelItem[inventory[i].name]
            end
            local protected = exports["k9-inventory"]:GetInventory(xTarget.source, "protected")
            for i = 1, #protected do
                protected[i].label = MP.LabelItem[protected[i].name]
            end
            cb({inventory = inventory, protected = protected})
        end
end)