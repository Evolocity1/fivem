RegisterNetEvent("MP:RefreshEntity")
AddEventHandler("MP:RefreshEntity", function(constru)
    MP.Construction = constru
end)

RegisterNetEvent("MP:RefreshNbConstru")
AddEventHandler("MP:RefreshNbConstru", function(nbconstru)
    MP.NbConstruction = tonumber(nbconstru)
end)

local function searchConstru(netid)
    for i = 1, #MP.Construction do
        if MP.Construction[i].netid == netid then
            return true, MP.Construction[i]
        end
    end
    return false
end

RegisterNetEvent("gameEventTriggered", function(eventName, args)
    if MP.ModeDeJeu ~= "battleroyale" then return end
    if eventName == "CEventNetworkEntityDamage" then
        local victimEntity, attackEntity, isFatal, damage, weaponUsed, isMelee = args[1], args[2], args[6] == 1, args[3], args[7], args[10]
        if attackEntity == PlayerPedId() then
            local bool, constru = searchConstru(NetworkGetNetworkIdFromEntity(victimEntity))
            if bool then
                TriggerServerEvent("MP:DegatConstru", constru.id, weaponUsed)
            end
        end
    end
end)

function RotationToDirection(rotation)
	local adjustedRotation = { 
		x = (math.pi / 180) * rotation.x, 
		y = (math.pi / 180) * rotation.y, 
		z = (math.pi / 180) * rotation.z 
	}
	local direction = {
		x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
		y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
		z = math.sin(adjustedRotation.x)
	}
	return direction
end

function RayCastGamePlayCamera(distance)
	local cameraRotation = GetGameplayCamRot()
	local cameraCoord = GetGameplayCamCoord()
	local direction = RotationToDirection(cameraRotation)
	local destination = { 
		x = cameraCoord.x + direction.x * distance, 
		y = cameraCoord.y + direction.y * distance, 
		z = cameraCoord.z + direction.z * distance 
	}
	local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, -1, 1))
	return b, c, e
end

local function ReturnHeading(nb)
    if nb < 44.99 and nb > -44.99 then
        return 0.0
    elseif nb < 134.99 and nb > 44.99 then
        return 90.0
    elseif nb > -134.99 and nb < -44.99 then
        return -90.0
    end
    return 180.0
end

local function getClosestCoordsCadrillage(nbe)
 local nb = nbe
 if nb < 0 then
  nb = (nb * -1)
 end
 local dist, coords = 1000000.0, 0
 for i = 1, 5000 do
  local calc = ((i * (1.999996)) - nb)
  if calc < 0 then
   calc = (calc * -1)
  end
  if calc < dist then
   dist, coords = calc, (i * (1.999996))
   if nbe < 0 then
    coords = -coords
   end
  end
 end
 return coords
end

local tables = {}

local function checkIsNotConstru(coords)
    for i = 1, #tables do
        if tables[i].x == coords.x and tables[i].y == coords.y then
            return true
        end
    end
    return false
end
    
local function ConstruireMur()
    if MP.ModeDeJeu ~= "battleroyale" then return end
    if not (MP.InBuild.active and MP.InBuild.build == "escalier") then
        MP.InBuild.active = not MP.InBuild.active
    end
    if MP.InBuild.active then
        MP.InBuild.build = "mur"
        local cameraRotation = GetGameplayCamRot()
        local direction = RotationToDirection(cameraRotation)
        local p = GetEntityCoords(PlayerPedId())
        local obj = CreateObjectNoOffset(GetHashKey("prop_const_fence01a"), p.x + (direction.x * 2), p.y + (direction.y * 2), p.z - 1.75, false, true, true)
        SetEntityCollision(obj, false, false)
	    SetEntityAlpha(obj, 150, false)
        Citizen.CreateThread(function()
            while MP.InBuild.active and MP.InBuild.build == "mur" do
                if MP.IsDead then MP.InBuild.active = false end
                if MP.ModeDeJeu ~= "battleroyale" then MP.InBuild.active = false end
                cameraRotation = GetGameplayCamRot()
                direction = RotationToDirection(cameraRotation)
                p = GetEntityCoords(PlayerPedId())
                --print(MP.Round(p.x + (direction.x * 2)), MP.Round(p.y + (direction.y * 2)), p.x + (direction.x * 2), p.y + (direction.y * 2))
                
                local c = vector3(p.x + (direction.x * 2), p.y + (direction.y * 2), p.z - 1.5)
                local lescoords = {x = getClosestCoordsCadrillage(p.x + (direction.x * 2)), y = getClosestCoordsCadrillage(p.y + (direction.y * 2))}
                print(lescoords.x, lescoords.y)
                if not checkIsNotConstru(lescoords) then
                    SetEntityCoords(obj, vector3(lescoords.x, lescoords.y, p.z - 1.5))
                    --SetEntityRotation(PlayerPedId(), vector3(0.0, 0.0, cameraRotation.z))
                    SetEntityRotation(obj, vector3(0.0, 0.0, ReturnHeading(cameraRotation.z)))
                else
                    SetEntityCoords(obj, vector3(0,0,0))
                end
                SetEntityNoCollisionEntity(obj, PlayerPedId(), true)
                if IsControlJustPressed(0,51) and not checkIsNotConstru(lescoords) then
                    if MP.NbConstruction >= 10 then
                        if not IsPedFalling(PlayerPedId()) then
                            if GetVehiclePedIsIn(PlayerPedId(), false) == 0 then
                                local leobj = CreateObjectNoOffset(GetHashKey("prop_const_fence01a"), lescoords.x, lescoords.y, p.z - 1.5, true, true, true)
                                SetEntityRotation(leobj, vector3(0.0, 0.0, ReturnHeading(cameraRotation.z)))
                                FreezeEntityPosition(leobj, true)
                                table.insert(tables, lescoords)
                            else
                                MP.ShowNotification("~r~Tu ne peux pas construire dans un véhicule")
                            end
                        else
                            MP.ShowNotification("~r~Tu ne peux pas construire en tombant")
                        end
                    else
                        MP.ShowNotification("~r~Tu n'a pas assez de construction")
                    end
                end
                Citizen.Wait(1)
            end
            DeleteEntity(obj)
        end)
    end
end

RegisterCommand("ConstruireMur", ConstruireMur)

RegisterKeyMapping("ConstruireMur", "Construire un mur", "keyboard", "F1")

local function ConstruireEscalier()
    if MP.ModeDeJeu ~= "battleroyale" then return end
    if not (MP.InBuild.active and MP.InBuild.build == "mur") then
        MP.InBuild.active = not MP.InBuild.active
    end
    if MP.InBuild.active then
        MP.InBuild.build = "escalier"
        local cameraRotation = GetGameplayCamRot()
        local direction = RotationToDirection(cameraRotation)
        local p = GetEntityCoords(PlayerPedId())
        local obj = CreateObjectNoOffset(GetHashKey("prop_mp_ramp_03"), p.x + (direction.x * 2), p.y + (direction.y * 2), p.z - 1.0, false, true, true)
        SetEntityCollision(obj, false, false)
	    SetEntityAlpha(obj, 150, false)
        Citizen.CreateThread(function()
            while MP.InBuild.active and MP.InBuild.build == "escalier" do
                if MP.IsDead then MP.InBuild.active = false end
                if MP.ModeDeJeu ~= "battleroyale" then MP.InBuild.active = false end
                cameraRotation = GetGameplayCamRot()
                direction = RotationToDirection(cameraRotation)
                p = GetEntityCoords(PlayerPedId())
                --print(MP.Round(p.x + (direction.x * 2)), MP.Round(p.y + (direction.y * 2)), p.x + (direction.x * 2), p.y + (direction.y * 2))
                local c = vector3(p.x + (direction.x * 2), p.y + (direction.y * 2), p.z - 1.0)
                SetEntityCoords(obj, c)
                --SetEntityRotation(PlayerPedId(), vector3(0.0, 0.0, cameraRotation.z))
                SetEntityRotation(obj, vector3(0.0, 0.0, cameraRotation.z))
                SetEntityNoCollisionEntity(obj, PlayerPedId(), true)
                if IsControlJustPressed(0,51) then
                    if MP.NbConstruction >= 10 then
                        if not IsPedFalling(PlayerPedId()) then
                            if GetVehiclePedIsIn(PlayerPedId(), false) == 0 then
                                local leobj = CreateObjectNoOffset(GetHashKey("prop_mp_ramp_03"), p.x + (direction.x * 2), p.y + (direction.y * 2), p.z - 1.0, true, true, true)
                                SetEntityRotation(leobj, vector3(0.0, 0.0, cameraRotation.z))
                                FreezeEntityPosition(leobj, true)
                            else
                                MP.ShowNotification("~r~Tu ne peux pas construire dans un véhicule")
                            end
                        else
                            MP.ShowNotification("~r~Tu ne peux pas construire en tombant")
                        end
                    else
                        MP.ShowNotification("~r~Tu n'a pas assez de construction")
                    end
                end
                Citizen.Wait(1)
            end
            DeleteEntity(obj)
        end)
    end
end

RegisterCommand("ConstruireEscalier", ConstruireEscalier)

RegisterKeyMapping("ConstruireEscalier", "Construire un mur", "keyboard", "F2")