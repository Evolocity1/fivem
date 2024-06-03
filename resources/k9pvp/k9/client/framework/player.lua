function MP.GetPlayerData()
    return MP.PlayerData
end

function MP.SetPlayerData(data)
    MP.Loaded = true
    MP.PlayerData = data
end

RegisterNetEvent("MP:SetPlayerData")
AddEventHandler("MP:SetPlayerData", function(data)
    MP.SetPlayerData(data)
end)