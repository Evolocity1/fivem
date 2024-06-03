RegisterServerEvent("MP:EnterEntrainement")
AddEventHandler("MP:EnterEntrainement", function()
        local xPlayer = MP.Player[source]
        if xPlayer.ModeDeJeu == "entrainement" then return end
        if MP.IsInSafezone(GetEntityCoords(GetPlayerPed(xPlayer.source))) then
            if xPlayer.ModeDeJeu == "pvp" then
                MP.ChangeModeDeJeu(xPlayer.source, "entrainement")
                SetEntityCoords(GetPlayerPed(xPlayer.source), vector3(13.913798332214, -1097.4729003906, 29.834749221802))
            else
                MP.ShowNotification("You are not in pvp")
            end
        else
            MP.ShowNotification("You are not in safezone")
        end
end)