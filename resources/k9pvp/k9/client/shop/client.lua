

Citizen.CreateThread(function()
        for i = 1, #Config.PedShop do
            local ped = MP.SpawnPed({name = "mp_m_fibsec_01", coords = vector3(Config.PedShop[i].coords.x, Config.PedShop[i].coords.y, Config.PedShop[i].coords.z - 1.0), heading = Config.PedShop[i].heading}, true)
            MP.CreateBlips({coords = Config.PedShop[i].coords, sprite = 59, display = 5, scale = 0.75, color = 5})
        end
end)