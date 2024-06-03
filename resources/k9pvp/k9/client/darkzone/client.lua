local peddarkzone = {}


local function DeletePedDarkzone()
    for i = 1, #peddarkzone do
        DeleteEntity(peddarkzone[i])
    end
    peddarkzone = {}
end

local function CreatePedDarkzone()
    DeletePedDarkzone()
    MP.RequestModel("u_m_y_juggernaut_01")
    for i = 1, #Config.Darkzone do
        local ped = CreatePed(1, "u_m_y_juggernaut_01", Config.Darkzone[i].coords.x, Config.Darkzone[i].coords.y, Config.Darkzone[i].coords.z - 0.98, Config.Darkzone[i].heading, false, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetPedDiesWhenInjured(ped, false)
        SetPedCanPlayAmbientAnims(ped, true) 
        SetPedCanRagdollFromPlayerImpact(ped, false) 
        SetEntityInvincible(ped, true)	
        FreezeEntityPosition(ped, true)
        SetEntityCollision(ped, false, false)
        table.insert(peddarkzone, ped)
        MP.CreateBlips({coords = Config.Darkzone[i].coords, sprite = 310, display = 5, scale = 0.75, color = 5})
    end
end


Citizen.CreateThread(function()
    RequestModel("u_m_y_juggernaut_01")
end)

--[[RegisterNetEvent("MP:ChangeModeDeJeu")
AddEventHandler("MP:ChangeModeDeJeu", function(name)
    print(name)
    if name ~= "pvp" then
        DeletePedDarkzone()
    else
        CreatePedDarkzone()
    end
end)]]

Citizen.CreateThread(function()
        CreatePedDarkzone()
end)


AddEventHandler("onResourceStop", function(name)
    if name == GetCurrentResourceName() then
        DeletePedDarkzone()
    end
end)