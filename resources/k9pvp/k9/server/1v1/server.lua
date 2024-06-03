local all1v1list = {
    ["inattente"] = {
        
    },
    ["inprogress"] = {
        
    }
}

local function foundPlayerInAttente1v1(id)
    for i = 1, #all1v1list["inattente"] do
        if all1v1list["inattente"][i]["id"] == id then
            return true, all1v1list["inattente"][i], i
        end
   	end
    return false
end


RegisterCommand("1v1", function(source, args)
        local idunique, mise = tonumber(args[1]), tonumber(args[2])
        if idunique == nil then return end
        if mise == nil then return end
        local xPlayer = MP.Player[source]
        local xTarget = MP.Player[idunique]
        local bool = foundPlayerInAttente1v1(xPlayer.source)
        if bool then xPlayer.showNotification("~r~") return end
        if xPlayer.ModeDeJeu ~= "pvp" then xPlayer.showNotification("~r~You are not in pvp") return end
        if xTarget == nil then xPlayer.showNotification("~r~The player is not online") return end
        if xTarget.ModeDeJeu ~= "pvp" then xPlayer.showNotification("~r~The player are not in pvp") return end
        if xPlayer.getAccount("bank") < mise then xPlayer.showNotification("") return end
        if xTarget.getAccount("bank") < mise then xPlayer.showNotification("") return end
        table.insert(all1v1list["inattente"], {
                id = xPlayer.source,
                target = xTarget.source,
                mise = mise,     
        })
        xTarget.showNotification("")
end)

RegisterCommand("accept", function(source, args)
        local idunique, mise = tonumber(args[1])
        if src == nil then return end
        local xPlayer = MP.Player[source]
        local xTarget = MP.GetPlayerFromIdUnique(idunique)
        if xTarget == nil then return end
        local bool = foundPlayerInAttente1v1(src)
        if not bool then return end
end)