local function AddBags(contenu)
    table.insert(MP.Bags, contenu)
end

local function GetBags(id)
    for i = 1, #MP.Bags do
        if MP.Bags[i].id == id then
            return true, MP.Bags[i], i
        end
    end
    return false
end

RegisterNetEvent("MP:AddBag")
AddEventHandler("MP:AddBag", function(bags)
    local foundGround, zpos = GetGroundZFor_3dCoord(bags["coords"].x, bags["coords"].y, bags["coords"].z)
    RequestModel("prop_big_bag_01")
	while (not HasModelLoaded("prop_big_bag_01")) do
		Citizen.Wait(1)
	end
    local object = CreateObject("prop_big_bag_01", bags["coords"].x, bags["coords"].y, zpos, false, false, false)
    SetEntityCollision(object, false, true)
	FreezeEntityPosition(object, true)
    AddBags({entity = object, id = bags.id, inventory = bags.inventory, coords = vector3(bags["coords"].x, bags["coords"].y, zpos), claimed = false, name = bags.name, nameclaimed = ""})
end)

RegisterNetEvent("MP:ClaimBags")
AddEventHandler("MP:ClaimBags", function(id, name)
    local bool, lebags, i = GetBags(id)
    if bool then
        DeleteObject(lebags.entity)
        table.remove(MP.Bags, i)
    end
end)