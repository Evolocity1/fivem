PlayerData = {}
Zombies = {}
playerSpawned = true
local sound = false

DrawText3DD = function(x, y, z, alpha, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    if onScreen then
        SetTextScale(0.25, 0.25)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, alpha)
        SetTextDropshadow(0)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

ShowNotification = function(message, flash)
	BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(message)
	EndTextCommandThefeedPostTicker(flash, 1)
end

RequestAndWaitModel = function(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(1)
    end
end

RequestAndWaitAnim = function(animDict)
    while not HasAnimDictLoaded(animDict) do
        RequestAnimDict(animDict)
        Citizen.Wait(1)
    end
end

PlayZombieSound = function()
    if sound then
        return
    end
    sound = true
    local sound = Config.Zombie.ZombieSounds[math.random(1, #Config.Zombie.ZombieSounds)]
    TriggerServerEvent("InteractSound_SV:PlayOnSource", sound, 0.03)
    Citizen.CreateThread(function()
        Citizen.Wait(3000)
        sound = false
    end)
end

GetPlayerZone = function(pCoords)
    local zone = "normal"
    
    for i = 1, #Config.Zombie.Darkzone do
        if #(Config.Zombie.Darkzone[i].coords-GetEntityCoords(PlayerPedId())) <= Config.Zombie.Darkzone[i].radius then
            zone = "darkzone"
        end
    end

    return zone
end

RegisterCommand("zombie", function()
        MP.ZombieEnable = not MP.ZombieEnable
        if MP.ZombieEnable then
            MP.ShowNotification("~g~Zombie Enabled")
        else
            MP.ShowNotification("~r~Zombie Disabled")
        end
end)


CanCreateZombie = function()
    local ped = PlayerPedId()
    if not MP.ZombieEnable and not (#(GetEntityCoords(PlayerPedId())-vector3(4840.571, -5174.425, 2.0)) < 2000) then
        RemoveAllZombie()
        return false
    end
    if IsEntityDead(ped) or IsPedDeadOrDying(ped) then
        return false
    end
    
    if MP.InModeStaff then
        RemoveAllZombie()
        return false
    end
    
    if MP.ModeDeJeu ~= "pvp" then
        RemoveAllZombie()
        return false
    end
    
    if MP.InSafezone then
        RemoveAllZombie()
        return false
    end
    
    if GetVehiclePedIsIn(PlayerPedId(), -1) ~= 0 then
        return false
    end

    if #Zombies > Config.Zombie.SpawnSettings.maxZombie then
        return false
    end

    if IsEntityInWater(ped) then
        RemoveAllZombie()
        return false
    end

    if IsPedInAnyBoat(ped) or IsPedInAnyHeli(ped) or IsPedInAnyPlane(ped) then
        RemoveAllZombie()
        return false
    end

    if not playerSpawned then
        return false
    end
    
    if MP.Antizin then
        return false
    end

    return true
end