local abc = false

local function DrawTxt(text, scale)
    local text = text
    local scale = scale
    Citizen.CreateThread(function()
        while abc do
            Citizen.Wait(1)
            SetTextCentre(true)
            SetTextScale(0.0 * scale, 0.55 * scale)
        	SetTextFont(fontCairo)
        	SetTextProportional(true)
        	SetTextColour(255, 255, 255, 255)
        	SetTextEntry('STRING')
        	--SetTextCentre(true)
        	AddTextComponentString(text)
        	DrawText(0.5, 0.55)
        end
    end)
end

local randomtext = {
    {name = "~b~", random = 6},
    {name = "~g~", random = 6},
    {name = "~y~", random = 6},
    {name = "~r~", random = 50},
    {name = "~p~", random = 6},
    {name = "~l~", random = 6},
    {name = "~q~", random = 6},
    {name = "~o~", random = 6},
}

local latable = {}

Citizen.CreateThread(function()
     for i = 1, #randomtext do
            for j = 1, randomtext[i].random do
                table.insert(latable, randomtext[i].name)
            end
     end
end)


function showDeathCam(attackEntity)
    local scaleform = MP.RequestScaleformMovie('MP_BIG_MESSAGE_FREEMODE')

 	
    
    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    AttachCamToEntity(cam, attackEntity, 0.0, 5.0, 0.8, true)
    SetCamFov(cam, 50.0)
    PointCamAtEntity(cam, attackEntity, 0.0, 0.0, 0.0, true)
    RenderScriptCams(true, true, 350, true, true)
    CreateThread(function()
        while cam and IsEntityDead(PlayerPedId()) do
            if not DoesEntityExist(attackEntity) then 
                break
            end
            BeginScaleformMovieMethod(scaleform, 'SHOW_SHARD_WASTED_MP_MESSAGE')
            ScaleformMovieMethodAddParamTextureNameString("~r~" ..MP.DeathMessage.message)
            ScaleformMovieMethodAddParamTextureNameString(MP.DeathMessage.nameplayer)
            EndScaleformMovieMethod()
            DrawScaleformMovie(scaleform, 0.5, 0.2, 0.75, 0.75, 255,255,255,255)
            Wait(1)
        end
        DestroyCam(cam, false)
        cam = nil
        RenderScriptCams(false, false, 0, true, true)
        SetScaleformMovieAsNoLongerNeeded(scaleform)
    end)
    
end

RegisterNetEvent("gameEventTriggered", function(eventName, args)
    if eventName == "CEventNetworkEntityDamage" then
        local victimEntity, attackEntity, isFatal, damage, weaponUsed, isMelee = args[1], args[2], args[6] == 1, args[3], args[7], args[10]
        if victimEntity == PlayerPedId() and isFatal and IsPedAPlayer(attackEntity) and MP.ModeDeJeu == "pvp" then
            MP.DeathMessage = {
                message = "",
                nameplayer = "",
            }
            TriggerServerEvent("MP:Killcam", {id = GetPlayerServerId(NetworkGetPlayerIndexFromPed(attackEntity)), health = GetEntityHealth(attackEntity) - 100, armor = GetPedArmour(attackEntity), weaponHash = weaponUsed})
                showDeathCam(attackEntity)
        end
        if attackEntity == PlayerPedId() and IsEntityAPed(victimEntity) then
            if isFatal then
                if victimEntity ~= attackEntity then
                    if not abc then
                        abc = true
                        x = 0
                        Citizen.CreateThread(function()
                            for i = 1, 3 do
                                Citizen.Wait(1000)
                            end
                            abc = false
                        end)
                        
                        DrawTxt("KILLED " ..latable[math.random(1, #latable)].. "" ..GetPlayerName(NetworkGetPlayerIndexFromPed(victimEntity)), 0.6)
                        
                    end
                    MP.MyKill[MP.ModeDeJeu] = MP.MyKill[MP.ModeDeJeu] + 1
                    SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
                    SetPedArmour(PlayerPedId(), 100)
                end
            end
        end
    end
end)

local dance = {
    ["crossbounce"] = {"custom@crossbounce", "crossbounce", "Cross bounce(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},

    ["dontstart"] = {"custom@dont_start", "dont_start", "Dont Start(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},

    ["floss"] = {"custom@floss", "floss", "Floss(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},

    ["orangejustice"] = {"custom@orangejustice", "orangejustice", "Orange Justice(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},

    ["renegade"] = {"custom@renegade", "renegade", "Renegade(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},

    ["rickroll"] = {"custom@rickroll", "rickroll", "Rick Roll(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},

    ["savage"] = {"custom@savage", "savage", "Savage(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},

    ["sayso"] = {"custom@sayso", "sayso", "Say So(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},

    ["takel"] = {"custom@take_l", "take_l", "Take the L(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},

    ["tslide"] = {"custom@toosie_slide", "toosie_slide", "Tootsie Slide", AnimationOptions =
    {
       EmoteMoving = false,
       EmoteLoop = true,
    }},
    ["woahdance"] = {"divined@tdances@new", "dtdance22", "Woah", AnimationOptions =
    {
       EmoteLoop = true,
    }},
 
    ["clock"] = {"custom@around_the_clock", "around_the_clock", "Around the clock(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    
    ["dancemoves"] = {"custom@dancemoves", "dancemoves", "Dance moves(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    
    ["discodance"] = {"custom@disco_dance", "disco_dance", "Disco Dance(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    
    ["electroshuffle"] = {"custom@electroshuffle_original", "electroshuffle_original", "Electro Shuffle(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    
    ["electroshuffle2"] = {"custom@electroshuffle", "electroshuffle", "Electro Shuffle 2(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    
    ["fresh"] = {"custom@fresh_fortnite", "fresh_fortnite", "Fresh(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    
    ["gylphic"] = {"custom@gylphic", "gylphic", "Glyphic(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    
    ["hitit"] = {"custom@hitit", "hitit", "Hit It(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    
    ["inparty"] = {"custom@in_da_party", "in_da_party", "In Da Party(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    
    ["robotdance"] = {"custom@robotdance_fortnite", "robotdance_fortnite", "Robot Dance(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    
    ["frightfunk"] = {"custom@frightfunk", "frightfunk", "Fright Funk(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    
    ["gloss"] = {"custom@gloss", "gloss", "Gloss(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    
    ["lastforever"] = {"custom@last_forever", "last_forever", "Last Forever(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    
    ["smoothmoves"] = {"custom@smooth_moves", "smooth_moves", "Smooth moves(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    
    ["introducing"] = {"custom@introducing", "introducing", "Introducing...(Fortnite)", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
}

local function searchDance(name)
    for k, v in pairs(dance) do
        if k == name then
            return true, v[1], v[2]
        end
    end
    return false
end

--[[RegisterCommand("emote", function(source, args)
    local bool, k, l = searchDance(args[1])
    if bool then
        RequestAnimDict(k)
            while not HasAnimDictLoaded(k) do
                Citizen.Wait(0)
            end
        TaskPlayAnim(PlayerPedId(), k, l, 2.0, 2.0, -1, 0, 0, false, false, false)
    end
end)]]