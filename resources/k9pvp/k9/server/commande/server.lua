RegisterCommand("tp", function(source, args)
    local xPlayer = MP.Player[source]
    if xPlayer.group ~= "user" then
        local xTarget = MP.Player[tonumber(args[1])]
        if xTarget then
            SetEntityCoords(GetPlayerPed(xTarget.source), GetEntityCoords(GetPlayerPed(source)))
            xTarget.istp = true
        end
    end
end)

--RegisterCommand("guid", function(source, args)
        --local guid = GetPlayerGuid(source)
        --print(guid)
--end)

RegisterCommand("setgroup", function(source, args)
    if source ~= 0 then
        if tonumber(args[1]) and args[2] then
            local xPlayer = MP.Player[source]
            if IsPerm(xPlayer.group, "owner") then
                local xTarget = MP.GetPlayerFromIdUnique(tonumber(args[1]))
                if xTarget then
                    xTarget.setGroup(args[2])
                else
                    xPlayer.showNotification("~r~The player is not online")
                end
            else
                xPlayer.showNotification("~r~You do not have the necessary permissions to perform this command")
            end
        end
    else
        local xTarget = MP.GetPlayerFromIdUnique(tonumber(args[1]))
                if xTarget then
                    xTarget.setGroup(args[2])
                else
                    print("~r~The player is not online")
                end
    end
end)

RegisterCommand("id", function(source)
        if source == 0 then return end
        local xPlayer = MP.Player[source]
        xPlayer.showNotification("ID Unique : " ..xPlayer.idunique)
end)