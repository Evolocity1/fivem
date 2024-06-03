local parameter = {
    ["botspeed"] = "easy",
    ["botcount"] = 1,
    ["botmoove"] = false,
    ["botmoovee"] = false,
}

local isstart = false

local stats = {
    ["win"] = 0,
	["loose"] = 0,
}

local function ResetStats()
    stats = {
        ["win"] = 0,
        ["loose"] = 0,
	}
end
local function AddStats(arg)
    stats[arg] = stats[arg] + 1
end
local function returnWait()
    if parameter["botspeed"] == "easy" then
        return 2000
    elseif parameter["botspeed"] == "medium" then
        return 1500
    elseif parameter["botspeed"] == "hard" then
        return 1000
    end
end

local inentrainement = false
local allped = {}
local function GenerateBot()
    local ped = CreatePed(7, GetHashKey("a_f_y_fitness_02"), Config.Entrainement.PedCoords[math.random(1, #Config.Entrainement.PedCoords)], 164.20471191406, false, false)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedDiesWhenInjured(ped, false)
    SetPedCanPlayAmbientAnims(ped, true) 
    SetPedCanRagdollFromPlayerImpact(ped, false) 
    FreezeEntityPosition(ped, true)
    SetEntityCollision(ped, false, false)
    SetEntityHealth(ped, 150)
    table.insert(allped, ped)
    return ped
end

local function searchBot(ped)
    for i = 1, #allped do
        if allped[i] == ped then
            return true, i
        end
    end
    return false
end

local function DeleteBot(ped)
    local bool, i = searchBot(ped)
    if bool then
        local isdead = IsEntityDead(ped)
        DeleteEntity(ped)
        table.remove(allped, i)
        return isdead == 1 and true or false
    end
    return false
end

local lex = 0.04
local lez = 0.025
function LanceEntrainement(bool)
    inentrainement = bool
    if inentrainement then
        isstart = false
        ResetStats()
        MP.RequestModel(GetHashKey("a_f_y_fitness_02"))
        SendNUIMessage({
                type = "entrainement",
                action = "showtouch"
            })
        Citizen.CreateThread(function()
                while inentrainement do
                    local text = isstart and "PRESS R TO RESTART" or "PRESS R TO START"
                    MP.DrawText(0.5, 0.1, {255, 255, 255, 255}, fontCairo, 1, "KILLED: ~g~" ..stats["win"].. " \n~s~MISSED: ~r~" ..stats["loose"].. " \n~s~" ..text, true, true)
                    if IsControlJustPressed(0,45) then
                        isstart = true
                        ResetStats()
                    end
                    if (stats["win"] + stats["loose"]) >= 100 and isstart then
                        isstart = false
                    end
                    for i = 1, #allped do
                        if not IsEntityDead(allped[i]) then
                            
                            if parameter["botmoove"] then
                                local coords = GetEntityCoords(allped[i])

                                if IsCollisionMarkedOutside(vector3(coords.x + lex, coords.y, coords.z - 1.0)) then
                                    lex = lex == 0.04 and -0.04 or 0.04
                                end
                                if parameter["botmoovee"] then
                                    local aadd = 0.0
                                    if lez >= 0 then
                                        aadd = 0.90
                                    end
                                    if IsCollisionMarkedOutside(vector3(coords.x, coords.y, coords.z - 1.0 + lez + aadd)) then
                                        lez = lez == 0.025 and -0.025 or 0.025
                                    end
                                    SetEntityCoords(allped[i], vector3(coords.x + lex, coords.y, coords.z - 1.0 + lez))
                                else
                                    SetEntityCoords(allped[i], vector3(coords.x + lex, coords.y, coords.z - 1.0))
                                end

                            end
                        end
                    end
                    Citizen.Wait(1)
                end
        end)
        Citizen.CreateThread(function()
                while inentrainement do
                    Citizen.Wait(returnWait())
                    if isstart then
                        for i = 1, parameter["botcount"] do
                            local ped = GenerateBot()
                            SetTimeout(returnWait() - 100, function()
                                  if DeleteBot(ped) then
                                        AddStats("win")
                                  else
                                        AddStats("loose")
                                  end
                            end)
                            Citizen.Wait(50)
                        end
                    end
                end
        end)
    else
        SendNUIMessage({
             type = "entrainement",
             action = "hideall"
        })
    end
end

RegisterNetEvent("MP:ChangeModeDeJeu")
AddEventHandler("MP:ChangeModeDeJeu", function(mode)
      if mode == "entrainement" and not inentrainement then
            LanceEntrainement(true)
      elseif mode ~= "entrainement" and inentrainement then
            LanceEntrainement(false)
      end
end)

RegisterCommand("parameter", function()
        if not inentrainement then return end
        SetNuiFocus(true, true)
        SendNUIMessage({
                type = "entrainement",
                action = "showparameter"
        })
end)

RegisterKeyMapping("parameter", "Open settings in training", "keyboard", "F3")

RegisterNUICallback("botspeed", function(data)
        parameter["botspeed"] = data["difficult"]
end)

RegisterNUICallback("botcount", function(data)
        parameter["botcount"] = tonumber(data["difficult"])
end)

RegisterNUICallback("botmoove", function(data)
        if (tonumber(data["difficult"]) == 1) then
            parameter["botmoove"] = false
            parameter["botmoovee"] = false
        elseif (tonumber(data["difficult"]) == 2) then
            parameter["botmoove"] = true
            parameter["botmoovee"] = false
        else
            parameter["botmoove"] = true
            parameter["botmoovee"] = true
        end
end)

RegisterNUICallback("closeentrainement", function(data)
        SetNuiFocus(false, false)
end)

Citizen.CreateThread(function()
        for i = 1, #Config.Entrainement.Coords do
            local ped = MP.SpawnPed({name = "u_m_y_babyd", coords = vector3(Config.Entrainement.Coords[i].coords.x, Config.Entrainement.Coords[i].coords.y, Config.Entrainement.Coords[i].coords.z - 1.0), heading = Config.Entrainement.Coords[i].heading}, true)
            MP.CreateBlips({coords = Config.Entrainement.Coords[i].coords, sprite = 567, display = 5, scale = 0.75, color = 5})
        end
end)