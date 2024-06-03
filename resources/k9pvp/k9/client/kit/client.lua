RegisterNUICallback("closekit", function()
        SetNuiFocus(false, false)
end)

RegisterNUICallback("claimkit", function(data)
        if data == nil then return end
        if data["name"] == nil then return end
        TriggerServerEvent("MP:TakeKit", data["name"])
end)

RegisterCommand("kit", function()
        SetNuiFocus(true, true)
        SendNUIMessage({
                type = "kit"
            })
end)
RegisterKeyMapping("kit", "Open the kit menu", "keyboard", "F6")