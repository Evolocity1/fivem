local function ReturnJesusGoat(vid, aid)
    if vid == GetPlayerServerId(PlayerId()) then
        return "death"
    elseif aid == GetPlayerServerId(PlayerId()) then
        return "kill"
    else
        return false
    end
end

RegisterNetEvent("MP:AddKillfeed")
AddEventHandler("MP:AddKillfeed", function(data)
    SendNUIMessage({
        type = "killfeed",
        action = "add",
        data = data,
        typekill = ReturnJesusGoat(data.victimId, data.attackerId),
        id = GetPlayerServerId(PlayerId()),
    })
end)