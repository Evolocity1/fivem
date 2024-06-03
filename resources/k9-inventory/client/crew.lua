RegisterNetEvent("MP:PlayerLoad")
AddEventHandler("MP:PlayerLoad", function(player)
    SendNUIMessage({
        type = "updateinvitecrew",
        invitecrew = player.invitecrew,
    })
end)

RegisterNetEvent("MP:UpdateInviteCrew")
AddEventHandler("MP:UpdateInviteCrew", function(invite)
    SendNUIMessage({
        type = "updateinvitecrew",
        invitecrew = invite,
    })
end)

RegisterNetEvent("MP:UpdateMyCrew")
AddEventHandler("MP:UpdateMyCrew", function(allmembercrew, crew, myperm)
    lecrew = {
                allmembercrew = allmembercrew,
                crew = crew,
                myperm = myperm,
            }
    if isOpened then
    SendNUIMessage({
        type = "refreshcrew",
            crew = {
                allmembercrew = allmembercrew,
                crew = crew,
                myperm = myperm,
            }
    })
    end
end)

RegisterNetEvent("MP:KickCrew")
AddEventHandler("MP:KickCrew", function()
    lecrew = {
            crew = {
                name = ""
            }
        }
    SendNUIMessage({
        type = "kickcrew"
    })
end)

RegisterNUICallback("CreateCrew", function(data)
    TriggerServerEvent("MP:CreateCrew", data)
end)

RegisterNUICallback("RefuseInvite", function(data)
    TriggerServerEvent("MP:RefuseInviteCrew", data.crewname)
end)

RegisterNUICallback("AccepteInvite", function(data)
    TriggerServerEvent("MP:AccepteInviteCrew", data.crewname)
end)
RegisterNUICallback("ActionPlayer", function(data)
    TriggerServerEvent("MP:ActionPlayer", data)
end)
RegisterNUICallback("LeaveCrew", function()
    TriggerServerEvent("MP:LeaveCrew")
end)