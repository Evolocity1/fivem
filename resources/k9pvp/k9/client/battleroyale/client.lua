local issauter = false

local function CreateZoneBattleRoyale()
    Citizen.CreateThread(function()
        while MP.InGameBattleRoyale do
            if #(MP.LaZone.coords-GetEntityCoords(PlayerPedId())) >= MP.LaZone.radius then
                if not MP.InZone then
                    MP.ShowNotification("~r~Vous êtes dans la tempête")
                    MP.InZone = true
                end
                SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) - MP.Round(MP.LaZone.degat))
            elseif MP.InZone then
                MP.ShowNotification("~g~Vous venez de sortir de la tempête")
                MP.InZone = false
            end
            Citizen.Wait(1000)
        end
    end)
end

local function InitialiseBattleRoyale()
    CreateTimerBattleRoyale("zone")
    MP.NbConstruction = 0
    MP.InBuild = {
        active = false,
        build = ""
    }
    MP.MyKill["battleroyale"] = 0
    MP.InZone = false
    MP.LaZone = {
        coords = vector3(61.672771453857, -1679.6567382813, 29.298700332642),
        radius = 300.0,
        degat = 1,
    }
    CreateZoneBattleRoyale()
end

RegisterNetEvent("MP:UpdateZone")
AddEventHandler("MP:UpdateZone", function(zone)
    MP.LaZone = zone
end)

RegisterNetEvent("MP:GoLancerBattleRoyale")
AddEventHandler("MP:GoLancerBattleRoyale", function(netid, got)
    while not NetworkDoesEntityExistWithNetworkId(netid) do
        Wait(0)
    end
    local veh = NetworkGetEntityFromNetworkId(netid)
    SetEntityHealth(PlayerPedId(), 200)
    SetPedArmour(PlayerPedId(), 0)
    SetVehicleDoorsLocked(veh, 2) -- lock the doors so pirates don't get in
    SetEntityDynamic(veh, true)
    ActivatePhysics(veh)
    SetVehicleForwardSpeed(veh, 60.0)
    SetHeliBladesFullSpeed(veh) -- works for planes I guess
    SetVehicleEngineOn(veh, true, true, false)
    ControlLandingGear(veh, 3) -- retract the landing gear
    OpenBombBayDoors(veh) -- opens the hatch below the plane for added realism
    SetEntityProofs(veh, true, false, true, false, false, false, false, false)
    SetEntityVisible(PlayerPedId(), false, 0)
    SetEntityCoords(PlayerPedId(), got.coords)
    pilot = CreatePedInsideVehicle(veh, 1, GetHashKey("s_m_m_pilot_02"), -1, false, false)
    SetBlockingOfNonTemporaryEvents(pilot, true) -- ignore explosions and other shocking events
    SetPedRandomComponentVariation(pilot, false)
    SetPedKeepTask(pilot, true)
    SetPlaneMinHeightAboveTerrain(veh, 50) -- the plane shouldn't dip below the defined altitude
    TaskVehicleDriveToCoord(pilot, veh, got.gotos + vector3(0.0, 0.0, 150.0), got.heading, 0, GetHashKey("bombushka"), 262144, 15.0, -1.0) -- to the dropsite, could be replaced with a task sequenc
    issauter = false
    MP.InGameBattleRoyale = true
    InitialiseBattleRoyale()
    Citizen.CreateThread(function()
        while DoesEntityExist(veh) and not issauter do
            SetEntityVisible(PlayerPedId(), false, 0)
            AttachEntityToEntity(PlayerPedId(), veh, 0, 0.0, -20.0, -2.6, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            DisableControlAction(0, 24, true)
            if IsControlJustPressed(0, 22) then
                issauter = true
            end
            Citizen.Wait(1)
        end
        DetachEntity(veh, true, true)
        DetachEntity(PlayerPedId(), true, true)
        DeleteEntity(pilot)
        SetEntityVisible(PlayerPedId(), true, 0)
        TaskParachute(PlayerPedId())
        Wait(100)
        while IsPedInParachuteFreeFall(PlayerPedId()) do
            local foundGround, zpos = GetGroundZFor_3dCoord(GetEntityCoords(PlayerPedId()).x, GetEntityCoords(PlayerPedId()).y, GetEntityCoords(PlayerPedId()).z)
            if #(GetEntityCoords(PlayerPedId())-vector3(GetEntityCoords(PlayerPedId()).x, GetEntityCoords(PlayerPedId()).y, zpos)) <= 75 then
                ForcePedToOpenParachute(PlayerPedId())
                print("open")
            end
            Citizen.Wait(1)
        end
        while IsEntityInAir(PlayerPedId()) do
            DisableControlAction(0,145, true)
            Citizen.Wait(1)
        end
        print("Ok c bon je suis au sol")
    end)
end)