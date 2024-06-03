Citizen.CreateThread(function()
        while true do
            Citizen.Wait((MP.DvAllTime - 15) * 1000)
            for k, v in pairs(MP.Player) do
                if v.ModeDeJeu == "pvp" then
                    TriggerClientEvent("MP:ShowMessageDeleteVehicle", v.source)
                end
            end
            Citizen.Wait(15000)
            for i = 1, #GetAllVehicles() do
                local vehicle = GetAllVehicles()[i]
                if GetPedInVehicleSeat(vehicle, -1) == 0 then
                    DeleteEntity(vehicle)
                end
            end
        end
end)