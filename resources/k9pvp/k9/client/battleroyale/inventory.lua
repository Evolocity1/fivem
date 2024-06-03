MP.InventoryOpen = false
MP.Inventory = {
}
MP.PositionItemUse = 0
local function searchItemFromPosition(position)
    for i = 1, #inventory do
        if tonumber(inventory[i].position) == tonumber(position) then
            return true, inventory[i]
        end
    end
    return false
end

local function AddImage()
    for i = 1, #MP.Inventory do
        MP.Inventory[i].img = "assets/" ..string.lower(MP.Inventory[i].name) .. ".png"
    end
end

local function searchSlots(slot)
    for i = 1, #MP.Inventory do
        if MP.Inventory[i].position == slot then
            return true, MP.Inventory[i]
        end
    end
end

for i = 1, 6 do
    RegisterKeyMapping("battleroyale" ..tostring(i), i == 1 and "Pioche Battle Royale" or "Inventaire Battle Royale slot #" ..i, "keyboard", tostring(i))
    RegisterCommand("battleroyale" ..tostring(i), function()
        print("exec")
        --if MP.ModeDeJeu == "battleroyale" then
        if (i - 1) ~= 0 then
            print("item")
            local bool, item = searchSlots(i - 1)
            if bool then
                TriggerServerEvent("MP:UseItemBattleRoyale", item.position)
            end
        else
            print("pioche")
            TriggerServerEvent("MP:UseItemBattleRoyale", 0)
        end
        --end
    end)
end
local isactive = false
RegisterCommand("OpenInventoryBattleRoyale", function()
    if not isactive then return end
    MP.InventoryOpen = not MP.InventoryOpen
    ArrangeControls(MP.InventoryOpen)
    if MP.InventoryOpen then
        SendNUIMessage({
            type = "inventory",
            action = "open",
            inventory = MP.Inventory,
            itemuse = MP.PositionItemUse,
        })
    else
        SendNUIMessage({
            type = "inventory",
            action = "close"
        })
    end
end)

RegisterKeyMapping("OpenInventoryBattleRoyale", "Ouvrir l'inventaire battle royale", "keyboard", "L")

RegisterNuiCallback("ItemDrag", function(data)
    local result = json.decode(data.item)
    -- local bool, inv = searchItemFromPosition(result.position, "position")
    -- if bool then
    --     local boolee, leinv = searchItemFromPosition(data.gotos, "position")
    --     if boolee then
    --         leinv.position = result.position
    --     end
    --     inv.position = data.gotos
    --     print(inv.position)
    --     SendNUIMessage({
    --         type = "inventory",
    --         action = "update",
    --         inventory = inventory
    --     })
    -- end
    TriggerServerEvent("MP:ItemDragBattleRoyale", result.position, data.gotos)
end)

RegisterNetEvent("MP:RefreshInventoryBattleRoyale")
AddEventHandler("MP:RefreshInventoryBattleRoyale", function(inv)
    MP.Inventory = inv["inventory"]
    MP.PositionItemUse = inv["ItemActuel"]
    AddImage(inv["inventory"])
    SendNUIMessage({
        type = "inventory",
        action = "update",
        inventory = MP.Inventory,
        itemuse = MP.PositionItemUse,
    })
end)

function ArrangeControls(bool)
    SetNuiFocus(bool, bool)
    SetNuiFocusKeepInput(bool)
    if bool then
        Citizen.CreateThread(function()
            while MP.InventoryOpen do
                Citizen.Wait(0)
                DisableControlAction(0, 1, true) -- disable mouse look
                DisableControlAction(0, 2, true) -- disable mouse look
                DisableControlAction(0, 3, true) -- disable mouse look
                DisableControlAction(0, 4, true) -- disable mouse look
                DisableControlAction(0, 5, true) -- disable mouse look
                DisableControlAction(0, 6, true) -- disable mouse look

                DisableControlAction(0, 1, true) -- disable aim
                DisableControlAction(0, 2, true)
                DisableControlAction(0, 156, true) -- disable aim
                DisableControlAction(0, 25, true) -- disable aim
                DisableControlAction(0, 26, true)
                DisableControlAction(0, 79, true)
                DisableControlAction(0, 80, true)
                DisableControlAction(0, 263, true) -- disable melee
                DisableControlAction(0, 264, true) -- disable melee
                DisableControlAction(0, 257, true) -- disable melee
                DisableControlAction(0, 140, true) -- disable melee
                DisableControlAction(0, 141, true) -- disable melee
                DisableControlAction(0, 142, true) -- disable melee
                DisableControlAction(0, 143, true) -- disable melee
                DisableControlAction(0, 24, true) -- disable attack
                DisableControlAction(0, 25, true) -- disable aim
                DisableControlAction(0, 47, true) -- disable weapon
                DisableControlAction(0, 58, true) -- disable weapon
                DisableControlAction(0, 245, true) -- chat
                DisableControlAction(0, 303, true) -- U

                DisableControlAction(0, 36, true) -- ctrl
                DisableControlAction(0, 29, true) -- b
                DisableControlAction(0, 73, true) -- X
                DisableControlAction(0, 85, true) -- Q
                DisableControlAction(0, 18, true) -- left click
                DisableControlAction(0, 69, true) -- left click
                DisableControlAction(0, 122, true) -- left click
                DisableControlAction(0, 229, true) -- left click
                DisableControlAction(0, 237, true) -- left click
                DisableControlAction(0, 329, true) -- left click
                DisableControlAction(0, 346, true) -- left click
                DisableControlAction(0, 92, true) -- left click
                DisableControlAction(0, 106, true) -- left click
                DisableControlAction(0, 135, true) -- left click
                DisableControlAction(0, 144, true) -- left click
                DisableControlAction(0, 176, true) -- left click
                DisableControlAction(0, 223, true) -- left click
                -- DisablePlayerFiring(PlayerId(), true)

                DisableControlAction(0, 199, true) -- P
                DisableControlAction(0, 200, true) -- esc
                DisableControlAction(0, 177, true) -- esc
                DisableControlAction(0, 202, true) -- esc
                DisableControlAction(0, 322, true) -- esc
            end
        end)
    end
end