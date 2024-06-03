local function CreateDrawDefi(info)
    MP.DrawDefi = {
        bool = true,
        id = info.id,
        text = info.text,
        value = info.value,
        maxvalue = info.maxvalue,
        times = 2000
    }
    Citizen.CreateThread(function()
        while MP.DrawDefi.bool and MP.DrawDefi.times > 0 do
            Citizen.Wait(500)
            MP.DrawDefi.times = MP.DrawDefi.times - 500
        end
        MP.DrawDefi = {
            bool = false,
            id = 0,
            text = "",
            value = 0,
            maxvalue = 0,
            times = 0,
        }
    end)
end

local id = 0

RegisterCommand("showdefi", function(source, args)
    if tonumber(args[1]) == nil or tonumber(args[2]) == nil then return end
    if not MP.DrawDefi.bool then
        id = id + 1
        CreateDrawDefi({id = id, text = "Shotgun Eliminations", value = tonumber(args[1]), maxvalue = tonumber(args[2])})
    elseif MP.DrawDefi.id == id then
        MP.DrawDefi.value = tonumber(args[1])
        MP.DrawDefi.maxvalue = tonumber(args[2])
        MP.DrawDefi.times = 2000
    end
end)

RegisterNetEvent("MP:ShowDefi")
AddEventHandler("MP:ShowDefi", function(info)
    if not MP.DrawDefi.bool then
        CreateDrawDefi(info)
    elseif MP.DrawDefi.id == info.id then
        MP.DrawDefi.value = info.value
        MP.DrawDefi.maxvalue = info.maxvalue
        MP.DrawDefi.times = 2000
    end
end)