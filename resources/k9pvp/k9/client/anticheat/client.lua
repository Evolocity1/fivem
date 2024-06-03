Anticheat = {}

AddEventHandler('onClientResourceStop', function(resource)
    if resource == "k9-inventory" then
        TriggerServerEvent("MP:goat", resource)
    end
end)

local function DetectionSpawnSafe()
    for i = 1, #MP.GetVehicles() do
        if not NetworkGetEntityIsNetworked(MP.GetVehicles()[i]) and MP.GetVehicles()[i] then
            MP.ShowNotification("Detect : Spawn Vehicle Safe")
            DeleteEntity(MP.GetVehicles()[i])
        end
    end
end

local function IsNuiFocus()
    return (IsNuiFocused() or IsNuiFocusKeepingInput())
end

local function IsScriptAllowed(name)
    for i = 1, #Anticheat.ResourcesWL do
        if Anticheat.ResourcesWL[i] == name then
            return true
        end
    end
    return false
end

local function DetectionGodmod()
end

--[[local function DetectionRevive()
    if MP.IsDead and not IsEntityDead(PlayerPedId()) then
        --MP.ShowNotification("T'es detect : Anti Revive")
        TriggerServerEvent("MP:K9ONTOP", "Anti Revive")
        --print("Anti revive")
    end
end]]

local function DetectionInvisible()
    if MP.Visible and not IsEntityVisible(PlayerPedId()) and not MP.IsDead and not MP.InModeStaff then
        --MP.ShowNotification("T'es detect : Invisible")
        TriggerServerEvent("MP:K9ONTOP", "Anti Invisible")
        --print("Anti Invisible")
    end
end

local function DetectionTexture()
    for i = 1, #Anticheat.Texture.TextureList do
        if HasStreamedTextureDictLoaded(Anticheat.Texture.TextureList[i]) then
            --MP.ShowNotification("T'es detect : Anti Texture")
            TriggerServerEvent("MP:K9ONTOP", "Anti Texture", "Texture : " ..Anticheat.Texture.TextureList[i])
            --print("Anti Texture")
        end
    end
end

local isweaponheavy = function(wea)
    if wea == GetHashKey("WEAPON_RPG") or wea == GetHashKey("weapon_grenadelauncher") or wea == GetHashKey("weapon_grenadelauncher_smoke") or wea == GetHashKey("weapon_minigun") or wea == GetHashKey("weapon_railgun") or wea == GetHashKey("weapon_hominglauncher") or wea == GetHashKey("weapon_compactlauncher") or wea == GetHashKey("weapon_rayminigun") or wea == GetHashKey("weapon_emplauncher") or wea == GetHashKey("weapon_grenade") or wea == GetHashKey("weapon_molotov") or wea == GetHashKey("weapon_stickybomb") or wea == GetHashKey("weapon_proxmine") or wea == GetHashKey("weapon_pipebomb") then
        return true
    end
    return false
end

local function DetectionExplosiveAmmo()
    if GetWeaponDamageType(GetSelectedPedWeapon(PlayerPedId())) == 5 and not isweaponheavy(GetSelectedPedWeapon(PlayerPedId())) then
        local leweapon = ""
        local items = exports["k9-inventory"]:Items()
        for k, v in pairs(items) do
            if GetHashKey(v.name) == GetSelectedPedWeapon(PlayerPedId()) then
                leweapon = v.label
            end
        end
        --MP.ShowNotification("T'es detect : Anti Explosive Ammo")
        TriggerServerEvent("MP:K9ONTOP", "Anti Explosive Ammo", "Weapon : " ..leweapon)
        --print("Anti Explosive Ammo")
    end
end

local function DetectionDamageMultiplier()
    if GetPlayerWeaponDamageModifier(PlayerId()) > 1.0 then
        				TriggerServerEvent("MP:K9ONTOP", "Anti Damage Boost", "Multiplier : " ..GetPlayerWeaponDamageModifier(PlayerId()))
    end

   if GetPlayerMeleeWeaponDamageModifier(PlayerId()) > 1.0 then
        				TriggerServerEvent("MP:K9ONTOP", "Anti Damage Boost", "Multiplier : " ..GetPlayerMeleeWeaponDamageModifier(PlayerId()))
    end

    if GetPlayerVehicleDamageModifier(PlayerId()) > 1.0 then
        				TriggerServerEvent("MP:K9ONTOP", "Anti Damage Boost", "Multiplier : " ..GetPlayerVehicleDamageModifier(PlayerId()))
    end

    if GetSelectedPedWeapon(PlayerPedId()) ~= GetHashKey("weapon_unarmed") and GetSelectedPedWeapon(PlayerPedId()) ~= 966099553 and GetSelectedPedWeapon(PlayerPedId()) ~= 0 and GetWeaponDamageModifier(GetSelectedPedWeapon(PlayerPedId())) > 1.0 then
        				TriggerServerEvent("MP:K9ONTOP", "Anti Damage Boost", "Multiplier : " ..GetWeaponDamageModifier(GetSelectedPedWeapon(PlayerPedId())))
    end
end

local function DetectionVehiclePlate()
    if GetVehiclePedIsIn(PlayerPedId()) ~= 0 then
        SetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId()), "K9PVP")
    end
end

local function DetectionNoRecoil()
    if GetWeaponRecoilShakeAmplitude(GetSelectedPedWeapon(PlayerPedId())) <= 0.0 and not IsNuiFocus() and GetVehiclePedIsIn(PlayerPedId(), false) == 0 and IsPedShooting(PlayerPedId()) then
        --MP.ShowNotification("T'es detect : Anti No Recoil")
        TriggerServerEvent("MP:K9ONTOP", "Anti No Recoil", "Recoil : " ..GetWeaponRecoilShakeAmplitude(GetSelectedPedWeapon(PlayerPedId())))
        --print("Anti norecoil")
    end
end

local function returnGiveWeapon()
    local items = exports["k9-inventory"]:PlayerItems()
    if items["inventory"] then
        for i = 1, #items["inventory"] do
            if GetHashKey(items["inventory"][i].name) == GetSelectedPedWeapon(PlayerPedId()) then
                return true
            end
        end
        return false
    end
    return false
end

local function DetectionGiveWeapon()
    if GetSelectedPedWeapon(PlayerPedId()) ~= GetHashKey("weapon_unarmed") then
        if not returnGiveWeapon() then
            RemoveAllPedWeapons(PlayerPedId())
            MP.ShowNotification("~r~Weapon not sync")
        end
    end
end

local function DetectionSilentAim()
    local model = GetEntityModel(PlayerPedId())
    local min, max 	= GetModelDimensions(model)
    if min.y < -0.29 or max.z > 0.98 then
        TriggerServerEvent("MP:K9ONTOP", "Anti Silent Aim")
    end
end

Citizen.CreateThread(function()
    while not NetworkIsPlayerActive(PlayerId()) do Citizen.Wait(1) end
    while GetEntitySpeed(PlayerPedId()) == 0.0 do Citizen.Wait(1) end
    while not MP.Loaded do Citizen.Wait(1) end
    Citizen.Wait(5000)
    print("load")
    while true do
        Citizen.Wait(1000)
        DetectionSpawnSafe()
        DetectionGodmod()
        --DetectionRevive()
        DetectionInvisible()
        DetectionTexture()
        DetectionExplosiveAmmo()
        DetectionDamageMultiplier()
        DetectionVehiclePlate()
        DetectionNoRecoil()
        DetectionGiveWeapon()
        DetectionSilentAim()
    end
end)

Citizen.CreateThread(function()
    while not NetworkIsPlayerActive(PlayerId()) do Citizen.Wait(1) end
    while GetEntitySpeed(PlayerPedId()) == 0.0 do Citizen.Wait(1) end
    while not MP.Loaded do Citizen.Wait(1) end
    Citizen.Wait(5000)
    print("load 2")
    while true do 
        Citizen.Wait(1000)
        --if ((IsEntityStatic(PlayerPedId()) or GetEntitySpeed(PlayerPedId()) == 0.0) and not IsPedStill(PlayerPedId()) and GetVehiclePedIsIn(PlayerPedId(), false) == 0 and GetEntityCoords(PlayerPedId()) ~= vector3(0.0, 0.0, 0.0) and #(vector3(202.589, -922.9978, 30.67834)-GetEntityCoords(PlayerPedId())) >= 10) or ((IsEntityStatic(GetVehiclePedIsIn(PlayerPedId(), false)) or GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false)) == 0) and GetVehiclePedIsIn(PlayerPedId(), false) ~= 0) then
            local player = PlayerPedId()
            local prevPos = GetEntityCoords(player)
            local vehicle = GetVehiclePedIsIn(player, false)
            local isstaff = MP.InModeStaff
            Citizen.Wait(1000)
            local currPos = GetEntityCoords(player)
            local distance = math.sqrt((prevPos.x - currPos.x)^2 + (prevPos.y - currPos.y)^2)
            local speed =  distance / 1
            local posmdr = GetClosestSafezone()
            local vehiclee = GetVehiclePedIsIn(PlayerPedId(), false)
            if ((IsEntityStatic(player) or GetEntitySpeed(PlayerPedId()) <= 0.5) and not IsPedStill(player) and speed > 15 and GetVehiclePedIsIn(player, false) == 0 and currPos ~= vector3(0.0, 0.0, 0.0) and #(posmdr-GetEntityCoords(PlayerPedId())) >= 10 and not MP.InModeStaff and not IsNuiFocus() and (vehicle == vehiclee) and not isPlyInBennys and not isstaff) or ((IsEntityStatic(GetVehiclePedIsIn(player, false)) or GetEntitySpeed(GetVehiclePedIsIn(player, false)) == 0) and GetVehiclePedIsIn(player, false) ~= 0 and speed > 15 and not MP.InModeStaff and not IsNuiFocus() and (vehicle == vehiclee) and not isPlyInBennys and not isstaff)  then
                --print("noclip detect")
                --MP.ShowNotification("T'es detect : Anti NoClip")
                TriggerServerEvent("MP:AntiNoclip", "Speed : " ..speed.. " \nDistance : " ..MP.Round(distance, 2).. "m \nVehicle : " ..GetVehiclePedIsIn(player, false).. " \nCoords 1 : " ..tostring(prevPos).. " \nCoords 2 : " ..tostring(currPos))
            end
        --end
    end
end)

local ancienvehe = 0
    local ancienposition
    local coordsveh = {}
local conducteurveh = {}
    Citizen.CreateThread(function()
        ancienposition = GetEntityCoords(PlayerPedId())
        while true do
            Citizen.Wait(1)
            for k, v in pairs(coordsveh) do
                if not DoesEntityExist(tonumber(k)) then
                    print("not exist nil")
                    coordsveh[k] = nil
                end
            end
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            if ancienvehe ~= vehicle and vehicle ~= 0 then
                if coordsveh[tostring(vehicle)] then
                    local distance = math.sqrt((ancienposition.x - coordsveh[tostring(vehicle)].x)^2 + (ancienposition.y - coordsveh[tostring(vehicle)].y)^2)
                    if distance >= 10 then
                        TriggerServerEvent("MP:K9ONTOP", "Anti Warp Vehicle", "Entity : " ..vehicle.." \nVehicle : "..GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false))).." \nDistance : " ..#(ancienposition-coordsveh[tostring(vehicle)]))
                    end
                end
                if vehicle ~= 0 and conducteurveh[tostring(vehicle)] ~= 0 and conducteurveh[tostring(vehicle)] ~= PlayerPedId() and conducteurveh[tostring(vehicle)] ~= nil and conducteurveh[tostring(vehicle)] ~= GetPedInVehicleSeat(allveh[i], -1) then
                    local isplayer = IsPedAPlayer(conducteurveh[tostring(vehicle)]) and "Yes" or "No"
                    --MP.ShowNotification("T'es detect : Anti Steal Vehicle")
                    TriggerServerEvent("MP:K9ONTOP", "Anti Steal Vehicle", "Vehicle : " ..vehicle.." \nConducteur : " ..conducteurveh[tostring(vehicle)].. " \nIs Player ? : " ..isplayer.. " \nStealer : " ..PlayerPedId())
                end
            end
            
            ancienvehe = vehicle
            ancienposition = GetEntityCoords(PlayerPedId())
            local allveh = MP.GetVehicles()
            for i = 1, #allveh do
                coordsveh[tostring(allveh[i])] = GetEntityCoords(allveh[i])
                conducteurveh[tostring(allveh[i])] = GetPedInVehicleSeat(allveh[i], -1)
            end
      end
   end)


RegisterNetEvent("MP:usevehicle")
AddEventHandler("MP:usevehicle", function(model, custom, id)
        if GetInvokingResource() then
         return
    	end
        SetTimeout(100, function()
                if GetVehiclePedIsIn(PlayerPedId(), false) ~= 0 and GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false)) ~= GetHashKey(model) then
                    TriggerServerEvent("MP:K9ONTOP", "Anti Replace Vehicle", "Model : " ..model.." \nReplace : " ..GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false))).. "")
                end
        end)
end)