RegisterNetEvent("MP:RefreshRedzone")
AddEventHandler("MP:RefreshRedzone", function(redzone)
    local blip, zone = nil, nil
    RemoveBlip(MP.Redzone.blips)
    RemoveBlip(MP.Redzone.zone)

        blip = AddBlipForCoord(redzone.pos.coords.x, redzone.pos.coords.y, redzone.pos.coords.z)
    	SetBlipSprite(blip, 303)
    	SetBlipAsShortRange(blip, true)
    	BeginTextCommandSetBlipName("STRING")
    	AddTextComponentString("Redzones")
    	EndTextCommandSetBlipName(blip)
        zone = AddBlipForRadius(redzone.pos.coords.x, redzone.pos.coords.y, redzone.pos.coords.z, redzone.pos.radius)
    	SetBlipSprite(zone, 9)
    	SetBlipAlpha(zone, 100)
    	SetBlipColour(zone, 1)

    MP.Redzone = redzone
    MP.Redzone.blips = blip
    MP.Redzone.zone = zone
end)