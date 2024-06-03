local function searchStuff(id)
    for i = 1, #MP.StuffParTerre do
        if MP.StuffParTerre[i].id == id then
            return true, MP.StuffParTerre[i], i
        end
    end
    return false
end

local function DeleteAllStuff()
    for i = 1, #MP.StuffParTerre do
        if DoesEntityExist(MP.StuffParTerre[i].entity) then
            DeleteEntity(MP.StuffParTerre[i].entity)
        end
    end
    MP.StuffParTerre = {}
end

RegisterNetEvent("MP:RefreshStuffParTerre")
AddEventHandler("MP:RefreshStuffParTerre", function(stuff)
    for i = 1, #stuff do
        local foundGround, zpos = GetGroundZFor_3dCoord(stuff[i].coords.x, stuff[i].coords.y, stuff[i].coords.z)
        if foundGround then
            stuff[i].coords = vector3(stuff[i].coords.x, stuff[i].coords.y, zpos + 1.0)
        end
        local bool = searchStuff(stuff[i].id)
        if not bool then
            if stuff[i].type == "weapon" then
                MP.RequestWeaponAsset(GetHashKey(stuff[i].name))
                local entity = CreateWeaponObject(GetHashKey(stuff[i].name), 250, stuff[i].coords.x, stuff[i].coords.y, stuff[i].coords.z, false, 1.0, 0)
                SetEntityAsMissionEntity(entity, true, false)
    			FreezeEntityPosition(entity, true)
    			SetEntityCollision(entity, false, true)
    			SetEntityDrawOutline(entity, true)
    			--[[if stuff[i].rarity == "commun" then
    			    SetEntityDrawOutlineColor(169,169,169, 255)
    			elseif stuff[i].rarity == "rare" then
    			    SetEntityDrawOutlineColor(8, 155, 234, 255)
    			elseif stuff[i].rarity == "epic" then
    			    SetEntityDrawOutlineColor(138, 43, 226, 255)
    			elseif stuff[i].rarity == "legendary" then
    			    SetEntityDrawOutlineColor(255,255,0, 255)
    			end]]
    			SetEntityDrawOutlineColor(255,255,255, 255)
                stuff[i].entity = entity
                table.insert(MP.StuffParTerre, {id = stuff[i].id, name = stuff[i].name, label = stuff[i].label, count = stuff[i].count, type = stuff[i].type, rarity = stuff[i].rarity, coords = stuff[i].coords, dispo = stuff[i].dispo, entity = stuff[i].entity})
            end
        end
    end
end)
RegisterNetEvent("MP:DeleteStuffParTerre")
AddEventHandler("MP:DeleteStuffParTerre", function(id)
    local bool, stuff, i = searchStuff(id)
    if bool then
        DeleteEntity(stuff.entity)
        print("c'est delete " ..i)
        table.remove(MP.StuffParTerre, i)
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        DeleteAllStuff()
    end
end)