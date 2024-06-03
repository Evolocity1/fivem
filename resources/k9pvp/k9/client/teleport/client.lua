RegisterNUICallback("teleport", function(data)
       MP.Teleport(PlayerPedId(), Config.Teleport.Teleport[data.teleport])
       SetNuiFocus(false, false)
end)

RegisterNUICallback("teleportclose", function()
      SetNuiFocus(false, false)
end)

Citizen.CreateThread(function()
        for i = 1, #Config.Teleport.Pos do
            local ped = MP.SpawnPed({name = "g_f_importexport_01", coords = vector3(Config.Teleport.Pos[i].coordsped.x, Config.Teleport.Pos[i].coordsped.y, Config.Teleport.Pos[i].coordsped.z - 1.0), heading = Config.Teleport.Pos[i].headingped}, true)
            MP.CreateBlips({coords = Config.Teleport.Pos[i].coordsped, sprite = 43, display = 5, scale = 0.75, color = 5})
        end
end)