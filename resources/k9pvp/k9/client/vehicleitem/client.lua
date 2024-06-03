DecorRegister("vehicleId", 3)

RegisterNetEvent("MP:usevehicle")
AddEventHandler("MP:usevehicle", function(model, custom, id)
    if GetInvokingResource() then
         TriggerServerEvent("MP:K9ONTOP", "ANTI SPAWN VEHICLE (CL)")
    end
    local ped = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(ped))
    local h = GetEntityHeading(ped)
    MP.RequestModel(model)
    local vel = GetEntityVelocity(PlayerPedId()) * 2.5
    ClearPedTasksImmediately(PlayerPedId())
    local vehicle = CreateVehicle(GetHashKey(model), x, y, z, h, true, true)
    SetVehicleNumberPlateText(vehicle, "K9PVP")
    if IsPedFalling(PlayerPedId()) then
        local coords = GetEntityCoords(PlayerPedId())
        local worked, groundZ, normal = GetGroundZAndNormalFor_3dCoord(coords.x, coords.y, coords.z)
        SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z - groundZ)
        ClearPedTasksImmediately(PlayerPedId())
        TaskWarpPedIntoVehicle(ped, vehicle, -1)
        SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z)
    end
    TaskWarpPedIntoVehicle(ped, vehicle, -1)
    SetVehicleEngineOn(vehicle, true, true, false)
    SetPedIntoVehicle(PlayerPedId(), veh, seat)
    SetVehicleEngineOn(vehicle, true, true, false)
    SetVehicleForwardSpeed(vehicle, 20)
    SetEntityVelocity(vehicle, vel)
    SetVehicleOnGroundProperly(vehicle)


    DecorSetInt(vehicle, "vehicleId", id)
    
    if custom then
    	MP.SetVehicleProperties(vehicle, custom.props)
    end
end)

--[[local vehiclecoldown = nil

RegisterNetEvent("MP:RangeVehicle")
AddEventHandler("MP:RangeVehicle", function()
    if vehiclecoldown then
        API_ProgressBar.remove(vehiclecoldown._id)
        vehiclecoldown = nil
    end
    vehiclecoldown = API_ProgressBar.add("PlayerTimerBar", "Vehicle Cooldown", "0:05")
    for i = 5, 1, -1 do
        Citizen.Wait(1000)
        vehiclecoldown.Func.lib.TextTimerBar.setText("0:0" ..i - 1)
    end
    API_ProgressBar.remove(vehiclecoldown._id)
    vehiclecoldown = nil
end)]]

RegisterCommand("test", function()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    if MP.IsDead then return end
    if GetPedInVehicleSeat(vehicle, -1) ~= PlayerPedId() then return end
    local vehicleId = DecorGetInt(vehicle, "vehicleId")
    local speed = GetEntitySpeed(vehicle) * 3.6
    if speed >= 45 then
        MP.ShowNotification("~r~You are too fast to store vehicle!")
        return
    end
    local id = DecorGetInt(vehicle, "vehicleId")
    local networkid = NetworkGetNetworkIdFromEntity(vehicle)
    DeleteEntity(vehicle)
    MP.TriggerServerEvent("MP:RangerVehicle", id, networkid)
end)

RegisterKeyMapping("test", 'Store Vehicle', 'keyboard', "K")