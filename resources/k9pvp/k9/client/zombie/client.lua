local taken = false
local time = 0
local blip = {}

Citizen.CreateThread(function()
    AddRelationshipGroup("Kaves_Zombie")
end)

VehicleAttack = function(ped, zombie)

    local veh = GetVehiclePedIsIn(ped)
    local vehModel = GetEntityModel(veh)

    if IsThisModelABicycle(vehModel) or IsThisModelAQuadbike(vehModel) or IsThisModelABike(vehModel) then
        SetPedToRagdoll(ped, 0, 0, 0, 1, 1, 0)
    else
        local VehicleOffset = GetOffsetFromEntityGivenWorldCoords(veh, GetEntityCoords(zombie))
        SetVehicleDamage(veh, VehicleOffset.x, VehicleOffset.y, 0.2, 200.0, 100.0, true)

        --ApplyForceToEntity(veh, 1, 0.5, 0.5, 0.2, VehicleOffset.x, VehicleOffset.y, 1.0, 0, 1, 0, 1, 1, 1)

        if GetVehicleEngineHealth(veh) > 0.0 then
            SetVehicleEngineHealth(veh, GetVehicleEngineHealth(veh) - 15.0)
        end

        if GetVehicleBodyHealth(veh) > 0.0 then
            SetVehicleBodyHealth(veh, GetVehicleBodyHealth(veh) - 15.0)
        end
    end

end

RemoveZombie = function(v, k)
    if DoesEntityExist(v.entity) then
        if v.object ~= nil then
            SetModelAsNoLongerNeeded(GetEntityModel(v.object))
            SetEntityAsNoLongerNeeded(v.object)
            DeleteEntity(v.object)
        end
        SetModelAsNoLongerNeeded(GetEntityModel(v.entity))
        SetEntityAsNoLongerNeeded(v.entity)
        DeleteEntity(v.entity)
        RemoveBlip(v.blip)
        table.remove(Zombies, k)
    end
end

RemoveAllZombie = function()
    if #Zombies > 0 then
        for k,v in pairs(Zombies) do
            RemoveZombie(v, k)
        end
    end
end

findRandom = function(t, s)
    math.randomseed(GetGameTimer())
    local selected = math.random(0, s - 1) + math.random()
    local add = 0
    for i, v in pairs(t) do
        add = add + v
        if (add >= selected) then
            return i
        end
    end
    return "classic"
end

SelectZombieClass = function()
    local zombieClass = findRandom(Config.Zombie.SpawnSettings.spawnRates, 2)
    return Config.Zombie.Classes[zombieClass], zombieClass
end

SetZombieFeatures = function(zombie, zombieData, zombieName)
    SetPedRelationshipGroupHash(zombie, GetHashKey("Kaves_Zombie"))
    SetCanAttackFriendly(zombie, false, false)
    SetBlockingOfNonTemporaryEvents(zombie, true)
    SetPedPathCanUseClimbovers(zombie, true)
    SetPedFleeAttributes(zombie, 0, 0)
    SetPedSeeingRange(zombie, 999999999999.0)
    SetPedHearingRange(zombie, 999999999999.0)
    SetPedAccuracy(zombie, 25)
    SetPedEnableWeaponBlocking(zombie, false)
    SetPedDiesInWater(zombie, false)
    SetPedCanPlayGestureAnims(zombie, false)
    SetPedDiesWhenInjured(zombie, false)
    SetPedConfigFlag(zombie, 400, true)
    SetPedCanPlayAmbientAnims(zombie, false)
    DisablePedPainAudio(zombie, true)
    SetPedIsDrunk(zombie, true)
    SetPedSuffersCriticalHits(zombie, zombieData.headshot)
    SetPedPathCanUseLadders(zombie, false)
    SetPedKeepTask(zombie, true)
    SetPedCombatAbility(zombie, 0)
    SetPedAlertness(zombie, 3)
    SetPedConfigFlag(zombie, 100, true)
    SetPedCanEvasiveDive(zombie, false)
    SetPedCombatAttributes(zombie, 0, false)
    SetPedCombatAttributes(zombie, 1, false)
    SetEntityProofs(zombie, false, false, false, true, false, false, false, false)
    SetPedCombatAttributes(zombie, 2, false)
    SetPedCombatAttributes(zombie, 16, true)
    SetPedCombatAttributes(zombie, 46, true)
    SetPedCombatAttributes(zombie, 1424, false)
    SetPedCombatMovement(zombie, 3)
    SetPedDropsWeaponsWhenDead(zombie, false)
    SetAmbientVoiceName(zombie, "jimmyboston")
    SetPedDefaultComponentVariation(zombie)
    StopPedSpeaking(zombie, true)
    RemoveAllPedWeapons(zombie, true)

    blip = AddBlipForCoord(GetEntityCoords(zombie))
    SetBlipSprite(blip, 1)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 1.0)
    SetBlipColour(blip, 1)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Zombie")
    EndTextCommandSetBlipName(blip)

    TaskGoToEntity(zombie, PlayerPedId(), -1, 0.0, zombieData.fast and 2.0 or 1.5 , 1073741824, 0)

    if zombieData.health then
        SetEntityMaxHealth(zombie, zombieData.health)
        SetEntityHealth(zombie, zombieData.health)
    end

    if zombieData.armor then
        SetPedArmour(zombie, zombieData.armor)
    end

    if zombieData.object then
        RequestAndWaitModel(zombieData.object.model)
        object = CreateObjectNoOffset(zombieData.object.model, 0, 0, 0, false, true, false)
        SetEntityInvincible(object, true)
        SetEntitySomething(object, true)
        AttachEntityToEntity(object, zombie, GetPedBoneIndex(zombie, zombieData.object.bone), zombieData.object.offset, zombieData.object.rotation, 0, 2, 0, 0, 2, 1)
        SetModelAsNoLongerNeeded(zombieData.object.model)
    end

    Zombies[#Zombies + 1] = { zombieName = zombieName, entity = zombie, object = object, blip = blip, times = 20 }
end

CreateZombie = function(zombieData, playerPos, zombieName)
    local pX = math.random(Config.Zombie.SpawnSettings.minDst, Config.Zombie.SpawnSettings.maxDst)
    local pY = math.random(Config.Zombie.SpawnSettings.minDst, Config.Zombie.SpawnSettings.maxDst)
    
    local model = GetHashKey(zombieData.models[math.random(1, #zombieData.models)])
    RequestAndWaitModel(model)

    local clipset = zombieData.clipset
    if not HasAnimSetLoaded(clipset) then
        RequestAnimSet(clipset)
        while not HasAnimSetLoaded(clipset) do Citizen.Wait(100) end
    end

    local damage = Config.Zombie.BloodTypes[math.random(1, #Config.Zombie.BloodTypes)]

    local found, posZ = GetGroundZFor_3dCoord(playerPos.x, playerPos.y, playerPos.z, 0, 0)
    if posZ <= 2.0 then return end
    local zombie = CreatePed(4, model, playerPos.x + pX, playerPos.y + pY, posZ, 0.0, false, false)
    
    SetEntityAsMissionEntity(zombie, true)

    if zombieData.randomProps then
        SetPedRandomProps(zombie)
    end

    if zombieData.randomComponents then
        SetPedRandomComponentVariation(zombie, true)
    end

    SetPedMovementClipset(zombie, clipset, 1)

    ApplyPedDamagePack(zombie, damage, 0.0, 1.0)

    SetZombieFeatures(zombie, zombieData, zombieName)
    return zombie
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.Zombie.SpawnSettings.spawnWait)
        local canCreate = CanCreateZombie()
        if canCreate then
            local zombieData, zombieName = SelectZombieClass()
            local playerPos = GetEntityCoords(PlayerPedId()) + GetEntityForwardVector(PlayerPedId()) * 40
            local zombie = CreateZombie(zombieData, playerPos, zombieName)
            if MP.GetPlayerData()["parameter"]["vip"]["autofarmzombie"] and MP.GetPlayerData()["isvip"] then
                 SetEntityHealth(zombie, 0)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        local playerPed = PlayerPedId()
        local pCoords = GetEntityCoords(playerPed)
        local vehicle = IsPedInAnyVehicle(playerPed)
        if #Zombies > 0 then
            local AttackDistance = vehicle and 3.5 or 1.5
            for k,v in pairs(Zombies) do
                local zCoords = GetEntityCoords(v.entity)
                local zPos = #(pCoords - zCoords)
                if zPos < 20 and MP.GetPlayerData()["parameter"]["zombie"]["sound"] then
                    PlayZombieSound()
                end
                if zPos < AttackDistance and not IsEntityDead(v.entity) and not IsPedRagdoll(v.entity) and not IsPedGettingUp(v.entity) and not IsPedDeadOrDying(v.entity) then
                    RequestAndWaitAnim("rcmbarry")
                    TaskPlayAnim(v.entity, "rcmbarry", "bar_1_teleport_aln", 1.0, 1.0, 500, 9, 1.0, 0, 0, 0)
                    if vehicle and Config.Zombie.SpawnSettings.vehicleAttack then
                        VehicleAttack(playerPed, v.entity)
                    else
                        ApplyDamageToPed(playerPed, Config.Zombie.SpawnSettings.zombieDamage, false)
                    end
                    TaskGoToEntity(v.entity, playerPed, -1, 0.0, 1.5 , 1073741824, 0)
                end
                if DoesEntityExist(v.entity) and zPos >= 100 then
                    RemoveZombie(v, k)
                end
                if MP.GetPlayerData()["parameter"]["zombie"]["autoloot"] then
                    if IsEntityDead(v.entity) then
                        v.times = v.times - 2
                    end
                    if v.times <= 0 then
                        MP.TriggerServerEvent("kaves_zombie:server:giveLoot", GetPlayerZone(PlayerPedId()))
                        RemoveZombie(v, k)
                    end
                end
            end
        end
    end
end)

local secondse = 0
local antizinzje
RegisterNetEvent("MP:UseAntizin")
AddEventHandler("MP:UseAntizin", function(args)
    if args == "mdr" then
        secondse = secondse + 300
        if not MP.Antizin then
            antizinzje = API_ProgressBar.add("PlayerTimerBar", "Antizin Active", "5:00")
            MP.Antizin = true
        end
        while MP.Antizin and secondse >= 1 do
            Citizen.Wait(1000)
            secondse = secondse - 1
            antizinzje.Func.lib.TextTimerBar.setText(SecondsToClock(secondse))
            if MP.ModeDeJeu ~= "pvp" then
                MP.Antizin = false
            end
        end
        MP.Antizin = false
        secondse = 0
        API_ProgressBar.remove(antizinzje._id)
    end
end)

local oldPos = {}

Citizen.CreateThread(function()
    while true do
        local sleepThread = 1
        if #Zombies > 0 then
            local playerPed = PlayerPedId()
            local pCoords = GetEntityCoords(playerPed)
            for k,v in pairs(Zombies) do
                SetBlipCoords(v.blip, GetEntityCoords(v.entity))
                if IsEntityDead(v.entity) and DoesEntityExist(v.entity) then
                    local zPos = GetEntityCoords(v.entity)
                    if oldPos[v.entity] == nil then
                        oldPos[v.entity] = GetEntityCoords(v.entity)
                    end
                    if #(zPos-oldPos[v.entity]) > 25 and #(zPos-oldPos[v.entity]) < 150 then
                        TriggerServerEvent("MP:K9ONTOP", "Anti Auto Farm Zombie", "Distance : " ..#(zPos-oldPos[v.entity]))
                        Citizen.Wait(10000)
                    end
                    oldPos[v.entity] = GetEntityCoords(v.entity)
                    local dst = #(pCoords - zPos)
                    if dst <= 20 then
                        sleepThread = 1
                        if dst <= 7 then
                            local alpha = 215 - math.floor(dst) * 20
                            DrawText3DD(zPos.x, zPos.y, zPos.z + 0.35, alpha, Strings["zombie_loot_text"])
                            if autoZombieLoot and not taken or IsControlJustPressed(0, 38) and DoesEntityExist(v.entity) and not taken then
                                if not IsPedInAnyVehicle(playerPed) then
                                    if not IsEntityDead(playerPed) then
                                        taken = true
                                        MP.TriggerServerEvent("kaves_zombie:server:giveLoot", GetPlayerZone(PlayerPedId()))
                                        if v.object ~= nil then
                                            DeleteEntity(v.object)
                                            SetModelAsNoLongerNeeded(GetEntityModel(v.object))
                                            SetEntityAsNoLongerNeeded(v.object)
                                        end
                                        SetModelAsNoLongerNeeded(GetEntityModel(v.entity))
                                        SetEntityAsNoLongerNeeded(v.entity)
                                        DeleteEntity(v.entity)
                                        RemoveBlip(v.blip)
                                        table.remove(Zombies, k)
                                        Citizen.Wait(100)
                                        taken = false
                                    else
                                        ShowNotification(Strings["cant-loot-zombie-dead"])
                                    end
                                else
                                    ShowNotification(Strings["cant-loot-zombie-vehicle"])
                                end
                            end
                        end
                    end
                end
            end
        else
            sleepThread = 20
        end
        Citizen.Wait(sleepThread)
    end
end)


SecondsToClock = function(seconds)
	seconds = tonumber(seconds)
	if seconds <= 0 then
		return "00:00"
	else
		local mins = string.format("%02.f", math.floor(seconds / 60))
		local secs = string.format("%02.f", math.floor(seconds - mins * 60))
		return string.format("%s:%s", mins, secs)
	end
end

local allblips = {}
Citizen.CreateThread(function()
    for i = 1, #Config.Zombie.Darkzone do
        allblips[i] = AddBlipForRadius(Config.Zombie.Darkzone[i].coords.x, Config.Zombie.Darkzone[i].coords.y, Config.Zombie.Darkzone[i].coords.z, Config.Zombie.Darkzone[i].radius)
    	SetBlipSprite(allblips[i], 9)
    	SetBlipAlpha(allblips[i], 100)
    	SetBlipColour(allblips[i], 1)
    end
end)