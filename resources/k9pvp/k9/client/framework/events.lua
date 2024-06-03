RegisterNetEvent("MP:showNotification")
AddEventHandler("MP:showNotification", function(msg)
    MP.ShowNotification(msg)
end)

RegisterNetEvent("MP:showAdvancedNotification")
AddEventHandler("MP:showAdvancedNotification", function(sender, subject, msg, textureDict, iconType, flash, saveToBrief, hudColorIndex)
    MP.ShowAdvancedNotification(sender, subject, msg, textureDict, iconType, flash, saveToBrief, hudColorIndex)
end)

RegisterNetEvent("MP:RefreshPlayerBucket")
AddEventHandler("MP:RefreshPlayerBucket", function(data)
    MP.AllPlayerBucket = data
end)