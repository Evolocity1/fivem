RegisterNUICallback("nuidetect", function()
        print("nui dev tools detect")
	TriggerServerEvent("MP:K9ONTOP", "Anti NUI DEV TOOLS")
end)

RegisterNetEvent("MP:ShowMessageDeleteVehicle")
AddEventHandler("MP:ShowMessageDeleteVehicle", function()
        SendNUIMessage({
                type = "showmessagevehicle"
        })
end)

local aa = false

--[[RegisterCommand("testrpf", function()
        aa = not aa
        if aa then
            local pedHash = GetHashKey("a_f_m_bevhills_01")
            RequestModel(pedHash)
            local cameraRotation = GetGameplayCamRot()
            local direction = RotationToDirection(cameraRotation)
            local p = GetEntityCoords(PlayerPedId())
            local lescoords = {x = p.x + (direction.x * 5), y = p.y + (direction.y * 5)}
            local ped = CreatePed(7, pedHash, vector3(lescoords.x + 0.75, lescoords.y + 0.75, p.z - 1.0), 90.0, false, false)
            SetBlockingOfNonTemporaryEvents(ped, true)
            FreezeEntityPosition(ped, true)
            GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_PISTOL"), 250, false, true)
            FreezeEntityPosition(PlayerPedId(), true)
            SetTimeout(3000, function()
                    aa = false
                    Citizen.Wait(1)
                    SetPlayerForcedAim(PlayerId(), false)
                    RemoveAllPedWeapons(PlayerPedId())
                    DeletePed(ped)
                    FreezeEntityPosition(PlayerPedId(), false)
            end)
            Citizen.CreateThread(function()
                  while aa do
                        Citizen.Wait(1000)
                        cameraRotation = GetGameplayCamRot()
                        direction = RotationToDirection(cameraRotation)
                        p = GetEntityCoords(PlayerPedId())
                        lescoords = {x = p.x + (direction.x * 10), y = p.y + (direction.y * 10), z = p.z}
                        SetEntityHeading(PlayerPedId(), 90.0)
                		FreezePedCameraRotation(PlayerPedId())
                        SetPlayerForcedAim(PlayerId(), true)
                        
                        TaskShootAtCoord(PlayerPedId(), lescoords.x, lescoords.y, lescoords.z, 1000, GetHashKey("FIRING_PATTERN_FULL_AUTO"))
                        
                  end
            end)
            Citizen.CreateThread(function()
                    while aa do
                        Citizen.Wait(1)
                        cameraRotation = GetGameplayCamRot()
                        direction = RotationToDirection(cameraRotation)
                        p = GetEntityCoords(PlayerPedId())
                        lescoords = {x = p.x + (direction.x * 10), y = p.y + (direction.y * 10), z = p.z}
                        DrawLine(p.x, p.y, p.z, lescoords.x, lescoords.y, lescoords.z, 255, 255, 255, 255)
                    end
            end)
            
        end
end)]]

--[[RegisterCommand("particle", function(source, args)
    if args[1] == nil or args[2] == nil then return end
    local coords = GetEntityCoords(PlayerPedId())
    if not HasNamedPtfxAssetLoaded(args[1]) then
        RequestNamedPtfxAsset(args[1])
        while not HasNamedPtfxAssetLoaded(args[1]) do
            Wait(1)
        end
    end
    SetPtfxAssetNextCall(args[1])
    local ptfx = StartParticleFxLoopedAtCoord(args[2], coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 2.0, false, false, false, false)
    RemoveNamedPtfxAsset(args[1])
    Citizen.CreateThread(function()
        Citizen.Wait(2000)
        StopParticleFxLooped(ptfx, 0)    
    end)
end)

RegisterCommand("balais", function()
    --local prop = CreateObject(GetHashKey("prop_tool_broom"), GetEntityCoords(PlayerPedId()), true, true, true)
	--local boneIndex = GetPedBoneIndex(PlayerPedId(), 11816)
	--AttachEntityToEntity(prop, PlayerPedId(), boneIndex, 0.20, 0.0, 0.0, 100.0, 100.0, 1.0, true, true, false, true, 1, true)
	local mavelocity = GetEntityVelocity(PlayerPedId())
	SetEntityVelocity(PlayerPedId(), vector3(mavelocity.x,mavelocity.y,75.0))
	TaskParachute(PlayerPedId())
    Wait(1000)
    --while GetEntityVelocity(PlayerPedId()).z >= 
        while IsPedInParachuteFreeFall(PlayerPedId()) do
            local foundGround, zpos = GetGroundZFor_3dCoord(GetEntityCoords(PlayerPedId()).x, GetEntityCoords(PlayerPedId()).y, GetEntityCoords(PlayerPedId()).z)
            if #(GetEntityCoords(PlayerPedId())-vector3(GetEntityCoords(PlayerPedId()).x, GetEntityCoords(PlayerPedId()).y, zpos)) <= 50 then
                ForcePedToOpenParachute(PlayerPedId())
                print("open")
            end
            Citizen.Wait(1)
        end
	Citizen.CreateThread(function()
	    Wait(5000)
	    DeleteEntity(prop)
	    print("props delete")
	end)
end)

RegisterCommand("progressbar", function(source, args)
    if tonumber(args[1]) == nil then return end
    SendNUIMessage({
        type = "progressbar",
        action = "setTime",
        time = tonumber(args[1]),
    })
end)]]

WeaponNames = {
	[tostring(GetHashKey('WEAPON_UNARMED'))] = 'Unarmed',
	[tostring(GetHashKey('GADGET_PARACHUTE'))] = 'Parachute',
	[tostring(GetHashKey('WEAPON_KNIFE'))] = 'Knife',
	[tostring(GetHashKey('WEAPON_NIGHTSTICK'))] = 'Nightstick',
	[tostring(GetHashKey('WEAPON_HAMMER'))] = 'Hammer',
	[tostring(GetHashKey('WEAPON_BAT'))] = 'Baseball Bat',
	[tostring(GetHashKey('WEAPON_CROWBAR'))] = 'Crowbar',
	[tostring(GetHashKey('WEAPON_GOLFCLUB'))] = 'Golf Club',
	[tostring(GetHashKey('WEAPON_BOTTLE'))] = 'Bottle',
	[tostring(GetHashKey('WEAPON_DAGGER'))] = 'Antique Cavalry Dagger',
	[tostring(GetHashKey('WEAPON_HATCHET'))] = 'Hatchet',
	[tostring(GetHashKey('WEAPON_KNUCKLE'))] = 'Knuckle Duster',
	[tostring(GetHashKey('WEAPON_MACHETE'))] = 'Machete',
	[tostring(GetHashKey('WEAPON_FLASHLIGHT'))] = 'Flashlight',
	[tostring(GetHashKey('WEAPON_SWITCHBLADE'))] = 'Switchblade',
	[tostring(GetHashKey('WEAPON_BATTLEAXE'))] = 'Battleaxe',
	[tostring(GetHashKey('WEAPON_POOLCUE'))] = 'Poolcue',
	[tostring(GetHashKey('WEAPON_PIPEWRENCH'))] = 'Wrench',
	[tostring(GetHashKey('WEAPON_STONE_HATCHET'))] = 'Stone Hatchet',

	[tostring(GetHashKey('WEAPON_PISTOL'))] = 'Pistol',
	[tostring(GetHashKey('WEAPON_PISTOL_MK2'))] = 'Pistol Mk2',
	[tostring(GetHashKey('WEAPON_COMBATPISTOL'))] = 'Combat Pistol',
	[tostring(GetHashKey('WEAPON_PISTOL50'))] = 'Pistol .50	',
	[tostring(GetHashKey('WEAPON_SNSPISTOL'))] = 'SNS Pistol',
	[tostring(GetHashKey('WEAPON_SNSPISTOL_MK2'))] = 'SNS Pistol Mk2',
	[tostring(GetHashKey('WEAPON_HEAVYPISTOL'))] = 'Heavy Pistol',
	[tostring(GetHashKey('WEAPON_VINTAGEPISTOL'))] = 'Vintage Pistol',
	[tostring(GetHashKey('WEAPON_MARKSMANPISTOL'))] = 'Marksman Pistol',
	[tostring(GetHashKey('WEAPON_REVOLVER'))] = 'Heavy Revolver',
	[tostring(GetHashKey('WEAPON_REVOLVER_MK2'))] = 'Heavy Revolver Mk2',
	[tostring(GetHashKey('WEAPON_DOUBLEACTION'))] = 'Double-Action Revolver',
	[tostring(GetHashKey('WEAPON_APPISTOL'))] = 'AP Pistol',
	[tostring(GetHashKey('WEAPON_STUNGUN'))] = 'Stun Gun',
	[tostring(GetHashKey('WEAPON_FLAREGUN'))] = 'Flare Gun',
	[tostring(GetHashKey('WEAPON_RAYPISTOL'))] = 'Up-n-Atomizer',

	[tostring(GetHashKey('WEAPON_MICROSMG'))] = 'Micro SMG',
	[tostring(GetHashKey('WEAPON_MACHINEPISTOL'))] = 'Machine Pistol',
	[tostring(GetHashKey('WEAPON_MINISMG'))] = 'Mini SMG',
	[tostring(GetHashKey('WEAPON_SMG'))] = 'SMG',
	[tostring(GetHashKey('WEAPON_SMG_MK2'))] = 'SMG Mk2	',
	[tostring(GetHashKey('WEAPON_ASSAULTSMG'))] = 'Assault SMG',
	[tostring(GetHashKey('WEAPON_COMBATPDW'))] = 'Combat PDW',
	[tostring(GetHashKey('WEAPON_MG'))] = 'MG',
	[tostring(GetHashKey('WEAPON_COMBATMG'))] = 'M60',
	[tostring(GetHashKey('WEAPON_COMBATMG_MK2'))] = 'M60 MK2',
	[tostring(GetHashKey('WEAPON_GUSENBERG'))] = 'Gusenberg Sweeper',
	[tostring(GetHashKey('WEAPON_RAYCARBINE'))] = 'Unholy Deathbringer',

	[tostring(GetHashKey('WEAPON_ASSAULTRIFLE'))] = 'Assault Rifle',
	[tostring(GetHashKey('WEAPON_ASSAULTRIFLE_MK2'))] = 'Assault Rifle Mk2',
	[tostring(GetHashKey('WEAPON_CARBINERIFLE'))] = 'Carbine Rifle',
	[tostring(GetHashKey('WEAPON_CARBINERIFLE_MK2'))] = 'Carbine Rifle Mk2',
	[tostring(GetHashKey('WEAPON_ADVANCEDRIFLE'))] = 'Advanced Rifle',
	[tostring(GetHashKey('WEAPON_SPECIALCARBINE'))] = 'Special Carbine',
	[tostring(GetHashKey('WEAPON_SPECIALCARBINE_MK2'))] = 'Special Carbine Mk2',
	[tostring(GetHashKey('WEAPON_BULLPUPRIFLE'))] = 'Bullpup Rifle',
	[tostring(GetHashKey('WEAPON_BULLPUPRIFLE_MK2'))] = 'Bullpup Rifle Mk2',
	[tostring(GetHashKey('WEAPON_COMPACTRIFLE'))] = 'Compact Rifle',

	[tostring(GetHashKey('WEAPON_SNIPERRIFLE'))] = 'Sniper Rifle',
	[tostring(GetHashKey('WEAPON_HEAVYSNIPER'))] = 'AWP',
	[tostring(GetHashKey('WEAPON_HEAVYSNIPER_MK2'))] = 'AWP MK2',
	[tostring(GetHashKey('WEAPON_MARKSMANRIFLE'))] = 'Marksman Rifle',
	[tostring(GetHashKey('WEAPON_MARKSMANRIFLE_MK2'))] = 'Marksman Rifle Mk2',

	[tostring(GetHashKey('WEAPON_GRENADE'))] = 'Grenade',
	[tostring(GetHashKey('WEAPON_STICKYBOMB'))] = 'Sticky Bomb',
	[tostring(GetHashKey('WEAPON_PROXMINE'))] = 'Proximity Mine',
    [tostring(GetHashKey('WEAPON_PIPEBOMB'))] = 'Pipe Bomb',
	[tostring(GetHashKey('WEAPON_SMOKEGRENADE'))] = 'Tear Gas',
	[tostring(GetHashKey('WEAPON_BZGAS'))] = 'BZ Gas',
	[tostring(GetHashKey('WEAPON_MOLOTOV'))] = 'Molotov',
	[tostring(GetHashKey('WEAPON_FIREEXTINGUISHER'))] = 'Fire Extinguisher',
	[tostring(GetHashKey('WEAPON_PETROLCAN'))] = 'Jerry Can',
	[tostring(GetHashKey('WEAPON_BALL'))] = 'Ball',
	[tostring(GetHashKey('WEAPON_SNOWBALL'))] = 'Snowball',
	[tostring(GetHashKey('WEAPON_FLARE'))] = 'Flare',

	[tostring(GetHashKey('WEAPON_GRENADELAUNCHER'))] = 'Grenade Launcher',
	[tostring(GetHashKey('WEAPON_RPG'))] = 'RPG',
	[tostring(GetHashKey('WEAPON_MINIGUN'))] = 'Minigun',
	[tostring(GetHashKey('WEAPON_FIREWORK'))] = 'Firework Launcher',
	[tostring(GetHashKey('WEAPON_RAILGUN'))] = 'Railgun',
	[tostring(GetHashKey('WEAPON_HOMINGLAUNCHER'))] = 'Homing Launcher',
	[tostring(GetHashKey('WEAPON_COMPACTLAUNCHER'))] = 'Compact Grenade Launcher',
	[tostring(GetHashKey('WEAPON_RAYMINIGUN'))] = 'Widowmaker',

	[tostring(GetHashKey('WEAPON_PUMPSHOTGUN'))] = 'Pump Shotgun',
	[tostring(GetHashKey('WEAPON_PUMPSHOTGUN_MK2'))] = 'Pump Shotgun Mk2',
	[tostring(GetHashKey('WEAPON_SAWNOFFSHOTGUN'))] = 'Sawed-off Shotgun',
	[tostring(GetHashKey('WEAPON_BULLPUPSHOTGUN'))] = 'Bullpup Shotgun',
	[tostring(GetHashKey('WEAPON_ASSAULTSHOTGUN'))] = 'Assault Shotgun',
	[tostring(GetHashKey('WEAPON_MUSKET'))] = 'Musket',
	[tostring(GetHashKey('WEAPON_HEAVYSHOTGUN'))] = 'Heavy Shotgun',
	[tostring(GetHashKey('WEAPON_DBSHOTGUN'))] = 'Double Barrel Shotgun',
	[tostring(GetHashKey('WEAPON_AUTOSHOTGUN'))] = 'Sweeper Shotgun',

	[tostring(GetHashKey('WEAPON_REMOTESNIPER'))] = 'Remote Sniper',
	[tostring(GetHashKey('WEAPON_GRENADELAUNCHER_SMOKE'))] = 'Smoke Grenade Launcher',
	[tostring(GetHashKey('WEAPON_PASSENGER_ROCKET'))] = 'Passenger Rocket',
	[tostring(GetHashKey('WEAPON_AIRSTRIKE_ROCKET'))] = 'Airstrike Rocket',
	[tostring(GetHashKey('VEHICLE_WEAPON_SPACE_ROCKET'))] = 'Orbital Canon',
	[tostring(GetHashKey('VEHICLE_WEAPON_PLANE_ROCKET'))] = 'Plane Rocket',
	[tostring(GetHashKey('WEAPON_STINGER'))] = 'Stinger [Vehicle]',
	[tostring(GetHashKey('VEHICLE_WEAPON_TANK'))] = 'Tank Cannon',
	[tostring(GetHashKey('VEHICLE_WEAPON_SPACE_ROCKET'))] = 'Rockets',
	[tostring(GetHashKey('VEHICLE_WEAPON_PLAYER_LASER'))] = 'Laser',
	[tostring(GetHashKey('VEHICLE_WEAPON_PLAYER_LAZER'))] = 'Lazer',
	[tostring(GetHashKey('VEHICLE_WEAPON_PLAYER_BUZZARD'))] = 'Buzzard',
	[tostring(GetHashKey('VEHICLE_WEAPON_PLAYER_HUNTER'))] = 'Hunter',
	[tostring(GetHashKey('VEHICLE_WEAPON_WATER_CANNON'))] = 'Water Cannon',

	[tostring(GetHashKey('AMMO_RPG'))] = 'Rocket',
	[tostring(GetHashKey('AMMO_TANK'))] = 'Tank',
	[tostring(GetHashKey('AMMO_SPACE_ROCKET'))] = 'Rocket',
	[tostring(GetHashKey('AMMO_PLAYER_LASER'))] = 'Laser',
	[tostring(GetHashKey('AMMO_ENEMY_LASER'))] = 'Laser',
	[tostring(GetHashKey('WEAPON_RAMMED_BY_CAR'))] = 'Rammed by Car',
	[tostring(GetHashKey('WEAPON_FIRE'))] = 'Fire',
	[tostring(GetHashKey('WEAPON_HELI_CRASH'))] = 'Heli Crash',
	[tostring(GetHashKey('WEAPON_RUN_OVER_BY_CAR'))] = 'Run over by Car',
	[tostring(GetHashKey('WEAPON_HIT_BY_WATER_CANNON'))] = 'Hit by Water Cannon',
	[tostring(GetHashKey('WEAPON_EXHAUSTION'))] = 'Exhaustion',
	[tostring(GetHashKey('WEAPON_EXPLOSION'))] = 'Explosion',
	[tostring(GetHashKey('WEAPON_ELECTRIC_FENCE'))] = 'Electric Fence',
	[tostring(GetHashKey('WEAPON_BLEEDING'))] = 'Bleeding',
	[tostring(GetHashKey('WEAPON_DROWNING_IN_VEHICLE'))] = 'Drowning in Vehicle',
	[tostring(GetHashKey('WEAPON_DROWNING'))] = 'Drowning',
	[tostring(GetHashKey('WEAPON_BARBED_WIRE'))] = 'Barbed Wire',
	[tostring(GetHashKey('WEAPON_VEHICLE_ROCKET'))] = 'Vehicle Rocket',
	[tostring(GetHashKey('VEHICLE_WEAPON_ROTORS'))] = 'Rotors',
	[tostring(GetHashKey('WEAPON_AIR_DEFENCE_GUN'))] = 'Air Defence Gun',
	[tostring(GetHashKey('WEAPON_ANIMAL'))] = 'Animal',
	[tostring(GetHashKey('WEAPON_COUGAR'))] = 'Cougar',
	["0"] = "Inconnu",
}


local scenarios = {
    'WORLD_VEHICLE_AMBULANCE',
    'WORLD_VEHICLE_BICYCLE_BMX',
    'WORLD_VEHICLE_BOAT_IDLE',
    'WORLD_VEHICLE_BOAT_IDLE_ALAMO',
    'WORLD_VEHICLE_BOAT_IDLE_MARQUIS',
    'WORLD_VEHICLE_BOAT_IDLE_MARQUIS',
    'WORLD_VEHICLE_BROKEN_DOWN',
    'WORLD_VEHICLE_BUSINESSMEN',
    'WORLD_VEHICLE_HELI_LIFEGUARD',
    'WORLD_VEHICLE_CLUCKIN_BELL_TRAILER',
    'WORLD_VEHICLE_CONSTRUCTION_SOLO',
    'WORLD_VEHICLE_CONSTRUCTION_PASSENGERS',
    'WORLD_VEHICLE_DRIVE_PASSENGERS',
    'WORLD_VEHICLE_DRIVE_PASSENGERS_LIMITED',
    'WORLD_VEHICLE_DRIVE_SOLO',
    'WORLD_VEHICLE_FARM_WORKER',
    'WORLD_VEHICLE_FIRE_TRUCK',
    'WORLD_VEHICLE_EMPTY',
    'WORLD_VEHICLE_MARIACHI',
    'WORLD_VEHICLE_MECHANIC',
    'WORLD_VEHICLE_MILITARY_PLANES_BIG',
    'WORLD_VEHICLE_MILITARY_PLANES_SMALL',
    'WORLD_VEHICLE_PARK_PARALLEL',
    'WORLD_VEHICLE_PARK_PERPENDICULAR_NOSE_IN',
    'WORLD_VEHICLE_POLICE_BIKE',
    'WORLD_VEHICLE_POLICE_CAR',
    'WORLD_VEHICLE_POLICE',
    'WORLD_VEHICLE_POLICE_NEXT_TO_CAR',
    'WORLD_VEHICLE_QUARRY',
    'WORLD_VEHICLE_SALTON',
    'WORLD_VEHICLE_SALTON_DIRT_BIKE',
    'WORLD_VEHICLE_SECURITY_CAR',
    'WORLD_VEHICLE_STREETRACE',
    'WORLD_VEHICLE_TOURBUS',
    'WORLD_VEHICLE_TOURIST',
    'WORLD_VEHICLE_TANDL',
    'WORLD_VEHICLE_TRUCK_LOGS',
    'WORLD_VEHICLE_TRUCKS_TRAILERS',
    'WORLD_VEHICLE_DISTANT_EMPTY_GROUND',
}

Citizen.CreateThread(function()
    SetMaxWantedLevel(0)
    ClearPlayerWantedLevel(PlayerId())
    for i = 1, 15 do
        EnableDispatchService(i, false)
    end
    for i, v in ipairs(scenarios) do
        SetScenarioTypeEnabled(v, false)
    end
end)

Citizen.CreateThread(function()
    while true do
        local startCount = GetFrameCount()
        Wait(1000)
        local endCount = GetFrameCount()
        MP.FPS = (endCount - startCount)
        for i = 1, #MP.GetVehicles() do
             local vehicle = MP.GetVehicles()[i]
             if GetVehicleBodyHealth(vehicle) == 0 and (GetEntityModel(vehicle) == GetHashKey("deluxo") or GetEntityModel(vehicle) == GetHashKey("oppressor") or GetEntityModel(vehicle) == GetHashKey("dukes2") or GetEntityModel(vehicle) == GetHashKey("scarab") or GetEntityModel(vehicle) == GetHashKey("nightshark")) then
                    SetVehicleFixed(vehicle)
                    SetVehicleDeformationFixed(vehicle)
                    SetVehicleUndriveable(vehicle, false)
                    SetVehicleEngineOn(vehicle, true, true)
             end
        end
        SetDiscordAppId(737582562259632139) 
        SetRichPresence( Config.LabelModeDeJeu[MP.ModeDeJeu].. " | " ..MP.NbPlayer.. "/1000") 

        SetDiscordRichPresenceAsset("k92") 
        SetDiscordRichPresenceAssetText(GetPlayerName(PlayerId())) 
 
        SetDiscordRichPresenceAction(0, "Play with me", "https://cfx.re/join/6xd9pd")
        SetDiscordRichPresenceAction(1, "Discord", "https://discord.gg/k9pvp")
    end
end)

local po = false

local disabledSafeZonesKeys = {
	--{group = 2, key = 37, message = '~r~Vous ne pouvez pas sortir d\'arme en SafeZone'},
	{group = 0, key = 24, message = '~r~Vous ne pouvez pas faire ceci en SafeZone'},
	{group = 0, key = 69, message = '~r~Vous ne pouvez pas faire ceci en SafeZone'},
	{group = 0, key = 92, message = '~r~Vous ne pouvez pas faire ceci en SafeZone'},
	{group = 0, key = 106, message = '~r~Vous ne pouvez pas faire ceci en SafeZone'},
	{group = 0, key = 168, message = '~r~Vous ne pouvez pas faire ceci en SafeZone'},
	{group = 0, key = 168, message = '~r~Vous ne pouvez pas faire ceci en SafeZone'},
	{group = 0, key = 140, message = '~r~Vous ne pouvez pas faire ceci en SafeZone'},
}

local notifOut = false

Citizen.CreateThread(function()
    for i = 1, #Config.Safezone do
        local zone = Config.Safezone[i]
        CreateBlipCircle(zone.coords, "Safezone", zone.dist, 3, 473)
    end
end)
local y = 0
function GetClosestSafezone()
    y = 0
    for i = 1, #Config.Safezone do
		local diste = #(GetEntityCoords(PlayerPedId())-vector3(Config.Safezone[i].coords.x, Config.Safezone[i].coords.y, Config.Safezone[i].coords.z))
		local distes = 1000000.0
		if y ~= 0 then
			distes = #(GetEntityCoords(PlayerPedId())-vector3(Config.Safezone[y].coords.x, Config.Safezone[y].coords.y, Config.Safezone[y].coords.z))
		end
		if diste < distes then
			y = i
			coords = vector3(Config.Safezone[i].coords.x, Config.Safezone[i].coords.y, Config.Safezone[i].coords.z)
		end
	end 
	return coords
end

function GetClosestSafezoneFromCoords(coordssz)
    y = 0
    for i = 1, #Config.Safezone do
		local diste = #(coordssz-vector3(Config.Safezone[i].coords.x, Config.Safezone[i].coords.y, Config.Safezone[i].coords.z))
		local distes = 1000000.0
		if y ~= 0 then
			distes = #(coordssz-vector3(Config.Safezone[y].coords.x, Config.Safezone[y].coords.y, Config.Safezone[y].coords.z))
		end
		if diste < distes then
			y = i
			coords = vector3(Config.Safezone[i].coords.x, Config.Safezone[i].coords.y, Config.Safezone[i].coords.z)
		end
	end 
	return coords
end

exports("inSafezone", function()
    return MP.InSafezone
end)

function MP.PedInSafezone(coords)
    local zeze = 10000000.0
        local zzedd = 0.0
        for i = 1, #Config.Safezone do
            if #(vector3(Config.Safezone[i].coords.x, Config.Safezone[i].coords.y, Config.Safezone[i].coords.z)-coords) < zeze then
                zeze = #(vector3(Config.Safezone[i].coords.x, Config.Safezone[i].coords.y, Config.Safezone[i].coords.z)-GetEntityCoords(PlayerPedId()))
                zzedd = Config.Safezone[i].dist
            end
        end
    return (zeze <= zzedd)
end

local ka = 0.025
local abcl = 1


local function DrawBag(position, value, color, size, linecount)
        -- checks if the timeout is true
        local positionOffset = {x=0, y=0}
        if math.random(2) == 1 then positionOffset.x = -math.random()/50 else positionOffset.x = math.random()/50 end
        if math.random(2) == 1 then positionOffset.y = -math.random()/50 else positionOffset.y = math.random()/50 end
        local currentAlpha = math.floor(math.random(127)) + 127
        local currentAlpha = 255
        local perspectiveScale = 2
        local scaleMultiplier = size or 1
        local font = 6
        local textOutline = true
        --while currentAlpha > 0 do
            local onScreen, _x, _y = World3dToScreen2d(position.x, position.y, position.z)
            local p = GetGameplayCamCoords()
            local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, position.x, position.y, position.xyz.z, 1)
            local scale = (1 / distance) * (perspectiveScale)
            local fov = (1 / GetGameplayCamFov()) * 75
            scale = scale * fov
            if onScreen then
                SetTextScale(tonumber(scaleMultiplier * 0.0), tonumber(0.50 * 0.5))
                SetTextFont(fontId)
                SetTextProportional(true)

                SetTextColour(color[1], color[2], color[3], currentAlpha)

                if (textOutline) == true then SetTextOutline() end;
                SetTextEntry("STRING")
                
                AddTextComponentString(value)
                DrawText(_x - 0.05, _y)
                local ley = 0
                for i = 1, linecount do
                    ley = ley + 0.033
                end
                DrawRect(_x, _y+(ley/2), 0.1, ley, 0, 0, 0, 100)
                -- DrawText(_x, _y)
            end
        --end
end

local function DrawProgressBar(position, value, color, size, maxvie, vie)
        -- checks if the timeout is true
        local positionOffset = {x=0, y=0}
        if math.random(2) == 1 then positionOffset.x = -math.random()/50 else positionOffset.x = math.random()/50 end
        if math.random(2) == 1 then positionOffset.y = -math.random()/50 else positionOffset.y = math.random()/50 end
        local currentAlpha = math.floor(math.random(127)) + 127
        local currentAlpha = 255
        local perspectiveScale = 2
        local scaleMultiplier = size or 1
        local font = 6
        local textOutline = true
        --while currentAlpha > 0 do
            local onScreen, _x, _y = World3dToScreen2d(position.x, position.y, position.z)
            local p = GetGameplayCamCoords()
            local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, position.x, position.y, position.xyz.z, 1)
            local scale = (1 / distance) * (perspectiveScale)
            local fov = (1 / GetGameplayCamFov()) * 75
            scale = scale * fov
            if onScreen then
                SetTextScale(tonumber(scaleMultiplier * 0.0), tonumber(0.50 * scaleMultiplier))
                SetTextFont(font)
                SetTextProportional(true)

                SetTextColour(color[1], color[2], color[3], currentAlpha)

                if (textOutline) == true then SetTextOutline() end;
                SetTextEntry("STRING")
                
                AddTextComponentString(value)
                local pourcent = ((vie * 100) / maxvie) / 1000
                DrawText(_x - 0.05, _y - 0.0175)
                DrawRect(_x, _y, 0.1, 0.025, 0, 0, 0, 200)
                DrawRect(_x - (((pourcent - 0.1) * -1) / 2), _y, pourcent, 0.025, 0, 255, 0, 255)
                --DrawRect(_x, _y, 0.1, 0.1, 0, 0, 0, 200)
                -- DrawText(_x, _y)
            end
        --end
end

API_ProgressBar = exports["k9pvp"]:GetAPI()
local killnameleaderredzone = nil
local killleaderredzone = nil
local mykillredzone = nil

local ancienredzone = {
    blips = nil,
    zone = nil,
    pos = {
        coords = vector3(0,0,0),
        radius = 0.0,
    },
    top = {
        name = "",
        kill = 0
    }
}

local killredzone = 0
local ancienkillredzone = 0

RegisterNetEvent("MP:RefreshMyKillRedzone")
AddEventHandler("MP:RefreshMyKillRedzone", function(mykill)
    killredzone = mykill
end)

local showAddConstru = false
local construAdd = 0
local timer = 0

RegisterNetEvent("MP:ShowAddConstruction")
AddEventHandler("MP:ShowAddConstruction", function(nb)
    if not showAddConstru then
        showAddConstru = true
        timer = 3
        construAdd = nb
        Citizen.CreateThread(function()
            while showAddConstru and timer > 0 do
                timer = timer - 1
                Citizen.Wait(1000)
            end
            showAddConstru = false
            construAdd = 0
        end)
    else
        timer = 3
        construAdd = construAdd + nb
    end
end)

timerzone = {
    ["zone"] = 60,
    ["zoneencours"] = 60,
}
zoneencours = "zone"

function CreateTimerBattleRoyale(type)
    timerzone[type] = 60
    zoneencours = type
    local letype = type
    Citizen.CreateThread(function()
        for i = 1, 60 do
            Citizen.Wait(1000)
            if letype ~= zoneencours then break end
            timerzone[letype] = timerzone[letype] - 1
        end
    end)
end

RegisterNetEvent("MP:StartTimer")
AddEventHandler("MP:StartTimer", function(type)
    CreateTimerBattleRoyale(type)
end)

local healthaenlever = 0
local armoraenelever = 0
local ancienhealth = 100
local ancienarmor = 0

local function GetIdModeDeJeu(name)
    for i = 1, #Config.ModeDeJeu do
        if Config.ModeDeJeu[i].mode == name then
            return true, Config.ModeDeJeu[i]
        end
    end
    return false
end
local function GetNbPlayerFromName(name)
    if name ~= "lobby" then
        local bool, eee = GetIdModeDeJeu(name)
        if bool then
            local nb = 0
            for i = 1, #MP.AllPlayerBucket do
                if MP.AllPlayerBucket[i].id == eee.id or (name == "pvp" and MP.AllPlayerBucket[i].id == 1) then
                    nb = nb + 1
                end
            end
            return nb
        end
    else
        local nbe = 0
        for i = 1, #MP.AllPlayerBucket do
            if MP.AllPlayerBucket[i].id == 0 then
                nbe = nbe + 1
            end
        end
        return nbe
    end
    return 0
end

local function DrawHelp3d(position, value, color, size, linecount)
        -- checks if the timeout is true
        local positionOffset = {x=0, y=0}
        if math.random(2) == 1 then positionOffset.x = -math.random()/50 else positionOffset.x = math.random()/50 end
        if math.random(2) == 1 then positionOffset.y = -math.random()/50 else positionOffset.y = math.random()/50 end
        local currentAlpha = math.floor(math.random(127)) + 127
        local currentAlpha = 255
        local perspectiveScale = 2
        local scaleMultiplier = size or 1
        local font = 6
        local textOutline = true
        --while currentAlpha > 0 do
            local onScreen, _x, _y = World3dToScreen2d(position.x, position.y, position.z)
            local p = GetGameplayCamCoords()
            local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, position.x, position.y, position.xyz.z, 1)
            local scale = (1 / distance) * (perspectiveScale)
            local fov = (1 / GetGameplayCamFov()) * 75
            scale = scale * fov
            if onScreen then
                SetTextScale(tonumber(scaleMultiplier * 0.0), tonumber(0.50 * scaleMultiplier))
                SetTextFont(font)
                SetTextProportional(true)

                SetTextColour(color[1], color[2], color[3], currentAlpha)

                if (textOutline) == true then SetTextOutline() end;
                SetTextEntry("STRING")
                
                AddTextComponentString(value)
                DrawText(_x - 0.05, _y)
                local ley = 0
                for i = 1, linecount do
                    ley = ley + 0.032
                end
                DrawRect(_x, _y+(ley/2), 0.1, ley, 0, 0, 0, 200)
            end
        --end
end

local coordsrandomdarkzone = {
    vector3(5207.51, -5455.59, 66.43),
    vector3(4505.03, -4715.62, 14.48),
    vector3(3904.13, -4706.64, 4.43),
    vector3(4275.2, -4366.6, 22.01),
    vector3(4743.78, -4297.72, 5.38),
    vector3(5234.05, -4611.92, 2.25),
    vector3(5230.6, -4967.89, 17.54),
    vector3(5600.28, -5658.62, 11.75),
    vector3(5451.67, -5936.79, 17.15),
    vector3(5009.4, -5749.12, 32.85),
    vector3(5230.6, -4967.89, 17.54),
    vector3(4830.3, -5996.19, 15.47),
    vector3(4821.16, -5026.55, 31.71),
    vector3(4912.05, -4909.2, 3.36),
    vector3(5016.51, -5185.33, 2.52),
    vector3(4654.48, -4859.73, 15.15),
    vector3(4606.1, -4777.04, 11.78),
    vector3(4651.91, -4663.42, 2.13),
    vector3(4367.57, -4577.3, 19.97),
    vector3(4210.15, -4489.67, 4.18),
    vector3(4612.35, -4411.91, 4.81),
    vector3(4998.38, -4403.97, 3.77),
    vector3(5104.77, -4862.09, 13.55),
    vector3(4957.34, -5287.95, 5.79),
    vector3(4898.77, -5461.52, 30.64),
}

local killcam = false
local allweapon = {}
Citizen.CreateThread(function()
        Wait(1000)
        local items = exports["k9-inventory"]:Items()
        for k, v in pairs(items) do
            allweapon[tostring(GetHashKey(k))] = string.lower(k)
        end
end)

RegisterNetEvent("MP:showKillcam")
AddEventHandler("MP:showKillcam", function(data, deathmessage, nameplayers)
        MP.DeathMessage = {
            message = deathmessage,
            nameplayer = nameplayers,
        }
        if allweapon[tostring(data.hashweapon)] then
            data.hashweapon = string.lower(allweapon[tostring(data.hashweapon)])
        end
        SendNUIMessage({
            type = "killcam",
            action = "show",
            data = data,
        })
        killcam = true
end)

RegisterNetEvent("MP:UpdateNbJoueur")
AddEventHandler("MP:UpdateNbJoueur", function(nb)
        MP.NbPlayer = nb
end)

local leancienhealth = 0
local leancienarmor = 0
local cooldown = false
local iscombat = false
local ancienweapon = GetHashKey("weapon_unarmed")

local pedcoords = {
    {coords = vector3(223.16738891602, -794.39080810547, 30.699443817139), heading = 247.18670654297},
    {coords = vector3(978.7802734375, -137.45655822754, 74.132331848145), heading = 64.151626586914},
    {coords = vector3(-758.81451416016, 5521.7563476562, 33.605934143066), heading = 36.416778564453},
    {coords = vector3(-1287.4183349609, 298.96286010742, 64.951835632324), heading = 29.125469207764},
}

Citizen.CreateThread(function()
        for i = 1, #pedcoords do
            local ped = MP.SpawnPed({name = "u_m_y_rsranger_01", coords = vector3(pedcoords[i].coords.x, pedcoords[i].coords.y, pedcoords[i].coords.z - 1.0), heading = pedcoords[i].heading}, true)
            MP.CreateBlips({coords = pedcoords[i].coords, sprite = 556, display = 5, scale = 0.75, color = 5})
        end
end)



RegisterNetEvent("MP:UpdateMyCrew")
AddEventHandler("MP:UpdateMyCrew", function(allmember)
        MP.Crew.member = allmember
        MP.Crew.bool = true
      
end)

RegisterNetEvent("MP:KickCrew")
AddEventHandler("MP:KickCrew", function()
        MP.Crew.member = {}
        MP.Crew.bool = false
end)


local gamerTags = {}
local gamerTagsCrew = {}

Citizen.CreateThread(function()
    local minimap = RequestScaleformMovie("minimap")
    RegisterFontFile('Montserrat')
    fontId = RegisterFontId('Montserrat')
    RegisterFontFile('Countach')
    fontCountach = RegisterFontId('Countach')
    RegisterFontFile('Cairo')
    fontCairo = RegisterFontId('Cairo')
    
    --local txd = CreateRuntimeTxd('img')
    --local w,h = GetActiveScreenResolution()
    --local duiObj = CreateDui('https://image.freepik.com/icones-gratuites/heraldique-bouclier_318-9090.jpg', 463,626)
    --local dui = GetDuiHandle(duiObj)
    --local tx = CreateRuntimeTextureFromDuiHandle(txd, 'test', dui)
    
    SetCanAttackFriendly(PlayerPedId(), true, false)
	NetworkSetFriendlyFireOption(true)
	SetDeepOceanScaler(0.0)
    local islandLoaded = false
    local islandCoords = vector3(4840.571, -5174.425, 2.0)
    RequestStreamedTextureDict("bois", true)
    RequestStreamedTextureDict("kill", true)
    RequestStreamedTextureDict("player", true)
    RequestStreamedTextureDict("minuteur", true)
    RequestStreamedTextureDict("banner", true)
	while not MP.Loaded do Citizen.Wait(1) end
	while not DoesEntityExist(PlayerPedId()) do Citizen.Wait(1) end
	while not HasScaleformMovieLoaded(minimap) do
      Wait(0)
	end
    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)
    AddTextEntry('PM_PANE_CFX', '~y~K9 PVP')
    while true do
        Citizen.Wait(1)
        HideHudComponentThisFrame(2)
        ScaleformMovieMethodAddParamInt(3)
        EndScaleformMovieMethod()
        HideHudComponentThisFrame(19)
        HideHudComponentThisFrame(20)
        BlockWeaponWheelThisFrame()
        SetPedCanSwitchWeapon(PlayerPedId(), false)
        BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
        ScaleformMovieMethodAddParamInt(3)
        EndScaleformMovieMethod()
        HideHudComponentThisFrame(7)
        HideHudComponentThisFrame(9)
        HideHudComponentThisFrame(3)
        HideHudComponentThisFrame(4)
        HideHudComponentThisFrame(13)
        SetEntityMaxHealth(PlayerPedId(), 200)
        local xPlayer = MP.GetPlayerData()
        local AmountofTraffic = 0.0
        local AmountPeds = 0.0
        local AmountParkedVehicles = 0.0
        local EnableBoats = false 
        local EnableTrains = false
        local EnableGarbageTrucks = false
        local EnablePolice = false
        --local _, _, _, hour, minute = GetUtcTime()
		NetworkOverrideClockTime(12, 0, 0)
		--SetWeatherTypeNowPersist('EXTRASUNNY')
        SetRandomBoats(EnableBoats)
        SetRandomTrains(EnableTrains)
        SetGarbageTrucks(EnableGarbageTrucks)
        SetCreateRandomCops(EnablePolice)
        SetCreateRandomCopsNotOnScenarios(EnablePolice)
        SetCreateRandomCopsOnScenarios(EnablePolice)
        SetDispatchCopsForPlayer(PlayerId(), EnablePolice)
        SetPedPopulationBudget(AmountPeds)
        SetVehiclePopulationBudget(AmountofTraffic)
        SetNumberOfParkedVehicles(AmountParkedVehicles)
        SetAudioFlag("PoliceScannerDisabled", true)
        DistantCopCarSirens(false)
        DisablePlayerVehicleRewards(PlayerId())
        SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
        -- Map perico
		SetRadarAsExteriorThisFrame()
        SetRadarAsInteriorThisFrame(`h4_fake_islandx`, vec(4700.0, -5145.0), 0, 0)
        SetPlayerTargetingMode(PlayerId(), 3)
        SetPedSuffersCriticalHits(PlayerPedId(), false)
        if MP.IhaveSquad then
            for i = 1, #MP.MySquad do
                    local coorzeds = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(MP.MySquad[i].id)))
                   	if tonumber(MP.MySquad[i].id) ~= tonumber(GetPlayerServerId(PlayerId())) and not DoesBlipExist(MP.MySquad[i].blip) and GetEntityCoords(PlayerPedId()) ~= GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(MP.MySquad[i].id))) then
                        MP.MySquad[i].blip = AddBlipForEntity(GetPlayerPed(GetPlayerFromServerId(MP.MySquad[i].id)))
            SetBlipSprite(blip, 1)
                        ShowFriendIndicatorOnBlip(MP.MySquad[i].blip, true)
                        SetBlipColour(MP.MySquad[i].blip, 37)
                        SetBlipScale(MP.MySquad[i].blip, 0.75)
                        ShowHeadingIndicatorOnBlip(MP.MySquad[i].blip, true)
                        SetBlipShowCone(MP.MySquad[i].blip, true)
                        BeginTextCommandSetBlipName("STRING")
                        AddTextComponentString(MP.MySquad[i].name)
                        EndTextCommandSetBlipName(MP.MySquad[i].blip)
                    end
                    if tonumber(MP.MySquad[i].id) ~= tonumber(GetPlayerServerId(PlayerId())) and GetEntityCoords(PlayerPedId()) ~= GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(MP.MySquad[i].id))) then
                          gamerTags[MP.MySquad[i].id] = CreateFakeMpGamerTag(GetPlayerPed(GetPlayerFromServerId(MP.MySquad[i].id)), ('%s'):format(GetPlayerName(GetPlayerFromServerId(MP.MySquad[i].id))), false, false, '', 0)
                                    SetMpGamerTagAlpha(gamerTags[MP.MySquad[i].id], 0, 255)
                                    SetMpGamerTagAlpha(gamerTags[MP.MySquad[i].id], 2, 255)
                                    SetMpGamerTagAlpha(gamerTags[MP.MySquad[i].id], 4, 255)
                                    SetMpGamerTagAlpha(gamerTags[MP.MySquad[i].id], 7, 255)
                                    SetMpGamerTagVisibility(gamerTags[MP.MySquad[i].id], 0, true)
                                    SetMpGamerTagVisibility(gamerTags[MP.MySquad[i].id], 2, true)
                                    SetMpGamerTagVisibility(gamerTags[MP.MySquad[i].id], 4, NetworkIsPlayerTalking(GetPlayerFromServerId(MP.MySquad[i].id)))
                                    SetMpGamerTagColour(gamerTags[MP.MySquad[i].id], 7, 55)
                                    if NetworkIsPlayerTalking(GetPlayerFromServerId(MP.MySquad[i].id)) then
                                        SetMpGamerTagHealthBarColour(gamerTags[MP.MySquad[i].id], 211)
                                        SetMpGamerTagColour(gamerTags[MP.MySquad[i].id], 4, 211)
                                        SetMpGamerTagColour(gamerTags[MP.MySquad[i].id], 0, 211)
                                    else
                                        SetMpGamerTagHealthBarColour(gamerTags[MP.MySquad[i].id], 0)
                                        SetMpGamerTagColour(gamerTags[MP.MySquad[i].id], 4, 18)
                                        SetMpGamerTagColour(gamerTags[MP.MySquad[i].id], 0, 18)
                                    end
                       else
                        RemoveMpGamerTag(gamerTags[MP.MySquad[i].id])
                        gamerTags[MP.MySquad[i].id] = nil
                       end
            end
        elseif gamerTags[GetPlayerServerId(PlayerId())] then
                for k,v in pairs(gamerTags) do
                        RemoveMpGamerTag(v)
                    end
                    gamerTags = {}
        end
        if MP.Crew.bool then
            for i = 1, #MP.Crew.member do
                    local coorzeds = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(MP.Crew.member[i].id)))
                    if tonumber(MP.Crew.member[i].id) ~= tonumber(GetPlayerServerId(PlayerId())) and GetEntityCoords(PlayerPedId()) ~= GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(MP.Crew.member[i].id))) then
                          gamerTagsCrew[MP.Crew.member[i].id] = CreateFakeMpGamerTag(GetPlayerPed(GetPlayerFromServerId(MP.Crew.member[i].id)), ('%s'):format(GetPlayerName(GetPlayerFromServerId(MP.Crew.member[i].id))), false, false, '', 0)
                                    SetMpGamerTagAlpha(gamerTagsCrew[MP.Crew.member[i].id], 0, 255)
                                    SetMpGamerTagAlpha(gamerTagsCrew[MP.Crew.member[i].id], 2, 255)
                                    SetMpGamerTagAlpha(gamerTagsCrew[MP.Crew.member[i].id], 4, 255)
                                    SetMpGamerTagAlpha(gamerTagsCrew[MP.Crew.member[i].id], 7, 255)
                                    SetMpGamerTagVisibility(gamerTagsCrew[MP.Crew.member[i].id], 0, true)
                                    SetMpGamerTagVisibility(gamerTagsCrew[MP.Crew.member[i].id], 2, true)
                                    SetMpGamerTagVisibility(gamerTagsCrew[MP.Crew.member[i].id], 4, NetworkIsPlayerTalking(GetPlayerFromServerId(MP.Crew.member[i].id)))
                                    SetMpGamerTagColour(gamerTagsCrew[MP.Crew.member[i].id], 7, 55)
                                    if NetworkIsPlayerTalking(GetPlayerFromServerId(MP.Crew.member[i].id)) then
                                        SetMpGamerTagHealthBarColour(gamerTagsCrew[MP.Crew.member[i].id], 211)
                                        SetMpGamerTagColour(gamerTagsCrew[MP.Crew.member[i].id], 4, 211)
                                        SetMpGamerTagColour(gamerTagsCrew[MP.Crew.member[i].id], 0, 211)
                                    else
                                        SetMpGamerTagHealthBarColour(gamerTagsCrew[MP.Crew.member[i].id], 0)
                                        SetMpGamerTagColour(gamerTagsCrew[MP.Crew.member[i].id], 4, 1)
                                        SetMpGamerTagColour(gamerTagsCrew[MP.Crew.member[i].id], 0, 1)
                                    end
                       else
                        RemoveMpGamerTag(gamerTagsCrew[MP.Crew.member[i].id])
                        gamerTagsCrew[MP.Crew.member[i].id] = nil
                       end
            end
        elseif gamerTagsCrew[GetPlayerServerId(PlayerId())] then
                for k,v in pairs(gamerTagsCrew) do
                        RemoveMpGamerTag(v)
                end
                gamerTagsCrew = {}
        end
            if xPlayer["parameter"]["fpsboost"]["enable"] then
                DisableOcclusionThisFrame()
                SetDisableDecalRenderingThisFrame()
                RemoveParticleFxInRange(GetEntityCoords(PlayerPedId()), 10.0)
            end
        --
        
        
            
        SetPlayerCanDoDriveBy(PlayerId(), false)
        if leancienhealth ~= GetEntityHealth(PlayerPedId()) then
            leancienhealth = GetEntityHealth(PlayerPedId())
            SendNUIMessage({
                type = "hud",
                action = "loop",
                health = GetEntityHealth(PlayerPedId()) - 100
            })
        end
        if leancienarmor ~= GetPedArmour(PlayerPedId()) then
            leancienarmor = GetPedArmour(PlayerPedId())
            SendNUIMessage({
                type = "hud",
                action = "loop",
                armor = GetPedArmour(PlayerPedId())
            })
        end
        for i = 1, #Config.vetement.coords do
				if #(GetEntityCoords(PlayerPedId())-Config.vetement.coords[i].coords) < 15 then
                    MP.DrawText3D(vector3(Config.vetement.coords[i].coords.x, Config.vetement.coords[i].coords.y, Config.vetement.coords[i].coords.z + 1.25), "[ ~y~CLOTHES~s~ ]", 1.2, fontId)
                end
	            if #(GetEntityCoords(PlayerPedId())-Config.vetement.coords[i].coords) < 2  then
	                MP.ShowHelpNotification("PRESS ~b~[E]~w~ Clothes")
	                if IsControlJustPressed(0,51) then
	                	
	                    inClothingShop = true
						local config = {
							ped = true,
							headBlend = true,
							faceFeatures = true,
							headOverlays = true,
							components = true,
							props = true,
							tattoos = true
						}
						exports['fivem-appearance']:startPlayerCustomization(function (appearance)
							if (appearance) then
								TriggerServerEvent('esx_skin:save', appearance)
								-- print(appearance)
							end
							--lib.showTextUI("[E] Change Hair/Face", {icon = "fa-solid fa-scissors"})
						end, config)
	        	    end
	            else
	                if inClothingShop then
	                    inClothingShop = false
	        		end
	            end
	        end
        if MP.ModeDeJeu == "pvp" then
            for i = 1, #pedcoords do
                    if #(pedcoords[i].coords-GetEntityCoords(PlayerPedId())) < 15 then
                        MP.DrawText3D(vector3(pedcoords[i].coords.x, pedcoords[i].coords.y, pedcoords[i].coords.z + 1.25), "[ ~y~CUSTOM WEAPON~s~ ]", 1.2, fontId)
                    end
                    if #(pedcoords[i].coords-GetEntityCoords(PlayerPedId())) < 2 then
                        MP.ShowHelpNotification("Press [E] to custom weapons")
                        if IsControlJustPressed(0,51) then
                            openmenu()
                        end
                    end
            end
            for i = 1, #Config.Darkzone do
                if #(Config.Darkzone[i].coords-GetEntityCoords(PlayerPedId())) < 15.0 then
                    MP.DrawText3D(vector3(Config.Darkzone[i].coords.x, Config.Darkzone[i].coords.y, Config.Darkzone[i].coords.z + 1.25), "[ ~y~DARKZONE~s~ ]", 1.2, fontId)
                end
                if #(Config.Darkzone[i].coords-GetEntityCoords(PlayerPedId())) < 2.0 then
                    MP.ShowHelpNotification("Press [E] to go to the darkzone")
                    if IsControlJustPressed(0,51) then
                        local lacoords = coordsrandomdarkzone[math.random(1,#coordsrandomdarkzone)]
                        SetEntityCoords(PlayerPedId(), lacoords.x, lacoords.y, lacoords.z + 250.0)
                        TaskParachute(PlayerPedId())
                    end
                end
            end
        end
        SetPlayerMaxStamina(PlayerId(), 3000000)
        SetPlayerStamina(PlayerId(), 3000000)
        
        --DrawHelp3d(vector3(115.71304321289, -1375.4136962891, 29.082576751709 + 2.0), "Bienvenue sur ~y~K9 PVP~s~ \n \n[~y~TAB~s~] Inventaire \n[~y~F1~s~] Heal \n[~y~F2~s~] Armor", {255,255,255,255}, 1.0, 5)
        
        local dist = 10000000.0
        local safezonedist = 0.0
        for i = 1, #Config.Safezone do
            if #(vector3(Config.Safezone[i].coords.x, Config.Safezone[i].coords.y, Config.Safezone[i].coords.z)-GetEntityCoords(PlayerPedId())) < dist then
                dist = #(vector3(Config.Safezone[i].coords.x, Config.Safezone[i].coords.y, Config.Safezone[i].coords.z)-GetEntityCoords(PlayerPedId()))
                safezonedist = Config.Safezone[i].dist
            end
        end
        if dist <= safezonedist then
				if not MP.InSafezone then
					NetworkSetFriendlyFireOption(false)
					SetCurrentPedWeapon(plyPed, `WEAPON_UNARMED`, true)
					MP.ShowNotification('~g~You are in SafeZone')
					SetEntityInvincible(PlayerPedId(), true)
				    SetPlayerInvincible(PlayerId(), true)
				    ResetEntityAlpha(PlayerPedId())
					MP.InSafezone = true
					notifOut = false
                    if xPlayer["parameter"]["vip"]["speedboost"] and MP.GetPlayerData()["isvip"] then
                        SetRunSprintMultiplierForPlayer(PlayerId(), 1.49)
                    end
				end
			else
				if not notifOut then
				    MP.ShowNotification("You are invincible for ~b~5 sec~w~.")
				    SetEntityAlpha(PlayerPedId(), 75, false)
				    Citizen.CreateThread(function()
				        Wait(5000)
				        ResetEntityAlpha(PlayerPedId())
				        NetworkSetFriendlyFireOption(true)
    					MP.ShowNotification("You are visible ~b~defend yourself~w~")
    					SetEntityInvincible(PlayerPedId(), false)
    				    SetPlayerInvincible(PlayerId(), false)
					    MP.InSafezone = false
                        SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
				    end)
					notifOut = true
				end
        end
        SetEntityInvincible(PlayerPedId(), MP.InSafezone)
		SetPlayerInvincible(PlayerId(), MP.InSafezone)
	    if MP.InSafezone then
				for i = 1, #MP.GetVehicles() do
					if not (GetEntityModel(MP.GetVehicles()[i]) == GetHashKey("deluxo")) then
						SetEntityNoCollisionEntity(PlayerPedId(), MP.GetVehicles()[i], true)
						SetEntityNoCollisionEntity(MP.GetVehicles()[i], PlayerPedId(), true)
					end
                    if GetVehiclePedIsIn(PlayerPedId()) ~= 0 then
                        SetEntityNoCollisionEntity(GetVehiclePedIsIn(PlayerPedId()), MP.GetVehicles()[i], true)
						SetEntityNoCollisionEntity(MP.GetVehicles()[i], GetVehiclePedIsIn(PlayerPedId()), true)
                    end
				end
                
        end
        
		if IsEntityDead(PlayerPedId()) then
		    if GetSelectedPedWeapon(PlayerPedId()) ~= 0 and GetSelectedPedWeapon(PlayerPedId()) ~= GetHashKey("weapon_unarmed") then
		        RemoveAllPedWeapons(PlayerPedId())
		    end
		end
        if IsEntityDead(PlayerPedId()) and not MP.IsDead then
            MP.IsDead = true
            local idkill, cause = ReturnIdPlayerKill()
            TriggerServerEvent("MP:kill", idkill, WeaponNames[tostring(cause)], cause)
            if MP.ModeDeJeu == "pvp" then
                Citizen.CreateThread(function()
                    Wait(5000)
                    local lescoords = GetClosestSafezone()
                    SetEntityCoordsNoOffset(PlayerPedId(), lescoords, false, false, false, true)
                    NetworkResurrectLocalPlayer(lescoords, 100.0, true, false)
                    SetEntityHeading(PlayerPedId(), 161.57438659668)
                    ClearPedBloodDamage(PlayerPedId())
                    AddArmourToPed(PlayerPedId(), 100)
                    RemoveAllPedWeapons(PlayerPedId())
                    MP.IsDead = false
                    if killcam then
                         killcam = false
                         SendNUIMessage({
                              type = "killcam",
                              action = "hide"
                          })
                    end
                end)
            elseif MP.ModeDeJeu == "battleroyale" then
                Citizen.CreateThread(function()
                    Wait(1000)
                    SetEntityCoordsNoOffset(PlayerPedId(), GetEntityCoords(PlayerPedId()), false, false, false, true)
                    NetworkResurrectLocalPlayer(GetEntityCoords(PlayerPedId()), 100.0, true, false)
                    SetEntityHeading(PlayerPedId(), 271.3544921875)
                    ClearPedBloodDamage(PlayerPedId())
                    AddArmourToPed(PlayerPedId(), 100)
                    RemoveAllPedWeapons(PlayerPedId())
                    MP.IsDead = false
                    if MP.InGameBattleRoyale then
                        MP.InGameBattleRoyale = false
                    end
                  if killcam then
                         killcam = false
                         SendNUIMessage({
                              type = "killcam",
                              action = "hide"
                          })
                    end
                end)
            elseif MP.ModeDeJeu == "deluxotricks" then
                Citizen.CreateThread(function()
                    Wait(1000)
                    local lescoords = GetClosestSafezone()
                    SetEntityCoordsNoOffset(PlayerPedId(), lescoords, false, false, false, true)
                    NetworkResurrectLocalPlayer(lescoords, 100.0, true, false)
                    SetEntityHeading(PlayerPedId(), 161.57438659668)
                    ClearPedBloodDamage(PlayerPedId())
                    AddArmourToPed(PlayerPedId(), 100)
                    RemoveAllPedWeapons(PlayerPedId())
                    MP.IsDead = false
                  if killcam then
                         killcam = false
                         SendNUIMessage({
                              type = "killcam",
                              action = "hide"
                          })
                    end
                end)
            else
                    SetEntityCoordsNoOffset(PlayerPedId(), GetEntityCoords(PlayerPedId()), false, false, false, true)
                    NetworkResurrectLocalPlayer(GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), true, false)
                    ClearPedBloodDamage(PlayerPedId())
                    AddArmourToPed(PlayerPedId(), 100)
                    RemoveAllPedWeapons(PlayerPedId())
                    MP.IsDead = false
            end
        end
        if MP.ModeDeJeu == "pvp" then 
            if #(MP.Redzone.pos.coords-GetEntityCoords(PlayerPedId())) < MP.Redzone.pos.radius then
                if not MP.InRedzone then
                    --mykillredzone = API_ProgressBar.add("PlayerTimerBar", "RedZone Kills", "0")
                    --mykillredzone.Func.setTitleColor({255, 0, 0, 255})
                    --mykillredzone.Func.lib.TextTimerBar.setTextColor({255, 0, 0, 255})
                    --killleaderredzone = API_ProgressBar.add("PlayerTimerBar", "RedZone Top Kills", tostring(MP.Redzone.top.kill))
                    --killnameleaderredzone = API_ProgressBar.add("PlayerTimerBar", "RedZone Kill Leader", MP.Redzone.top.name)
                    SendNUIMessage({
                    	type = "killleader",
                        action = "show",
                        name = MP.Redzone.top.name,
                       	kill = MP.Redzone.top.kill,
                    })
                end
                if MP.Redzone.top.kill ~= ancienredzone.top.kill then
                    --killnameleaderredzone.Func.lib.TextTimerBar.setText(MP.Redzone.top.name)
                    --killleaderredzone.Func.lib.TextTimerBar.setText(tostring(MP.Redzone.top.kill))
                    --ancienredzone = MP.Redzone
                    SendNUIMessage({
                    	type = "killleader",
                        action = "update",
                        name = MP.Redzone.top.name,
                       	kill = MP.Redzone.top.kill,
                    })
                end
                if killredzone ~= ancienkillredzone then
                    --mykillredzone.Func.lib.TextTimerBar.setText(tostring(killredzone))
                    --ancienkillredzone = killredzone
                end
                
                MP.InRedzone = true
                
            elseif MP.InRedzone then
                MP.InRedzone = false
                    --API_ProgressBar.remove(mykillredzone._id)
                    --API_ProgressBar.remove(killleaderredzone._id)
                    --API_ProgressBar.remove(killnameleaderredzone._id)
                    --killnameleaderredzone = nil
                    --killleaderredzone = nil
                    --mykillredzone = nil
                    SendNUIMessage({
                    	type = "killleader",
                        action = "hide",
                    })
            end
        	if not MP.IsDead then
                for i = 1, #MP.Bags do
                    local distance = math.sqrt((MP.Bags[i].coords.x - GetEntityCoords(PlayerPedId()).x)^2 + (MP.Bags[i].coords.y - GetEntityCoords(PlayerPedId()).y)^2)
                    if distance < 2 then
                        
                        xrot,yrot,zrot = table.unpack(GetEntityRotation(PlayerPedId(), 1))
                        local textbag = "Contenu du Bags : \n"
                        local linecount = #MP.Bags[i].inventory
                        for d = 1, #MP.Bags[i].inventory do
                            textbag = textbag .. "" .. MP.Bags[i].inventory[d].count.. "x " .. MP.Bags[i].inventory[d].label .. " \n"
                        end
                        if linecount == 0 then
                            textbag = "Contenu du Bags : \nAucun Item"
                            linecount = 1
                        end
                        DrawBag(vector3(MP.Bags[i].coords.x, MP.Bags[i].coords.y, MP.Bags[i].coords.z + 1.0), textbag, {255, 255, 255}, 1.0, linecount + 1)
                        MP.ShowHelpNotification("~g~[E]Search Lootbag")
                        if MP.GetPlayerData().isvip and not MP.Bags[i].claimed and not IsPedInAnyVehicle(PlayerPedId(), false) and IsEntityVisible(PlayerPedId()) then
                            MP.Bags[i].claimed = true
                            TriggerServerEvent("MP:ClaimBag", MP.Bags[i].id)
                        end
                        if IsControlJustPressed(0,51) and not MP.Bags[i].claimed then
                            if not IsPedInAnyVehicle(PlayerPedId(), false) then
                                if not MP.IsDead then
                                    if IsEntityVisible(PlayerPedId()) then
                                        if not MP.InSafezone then
                                            MP.Bags[i].claimed = true
                                            TriggerServerEvent("MP:ClaimBag", MP.Bags[i].id)
                                        else
                                            MP.ShowNotification("~r~You cannot collect a bag in a safezone")
                                        end
                                    else
                                        MP.ShowNotification("~r~You can't get a bag in noclip")
                                    end
                                else
                                    MP.ShowNotification("~r~You can't get a bag while dead")
                                end
                            else
                                MP.ShowNotification("~r~You cannot retrieve a bag from a vehicle")
                            end
                        end
                    end
                end
            end
                
             -- teleport
                
            for i = 1, #Config.Teleport.Pos do
                    if #(Config.Teleport.Pos[i].coordsped-GetEntityCoords(PlayerPedId())) < 15 then
                        MP.DrawText3D(vector3(Config.Teleport.Pos[i].coordsped.x, Config.Teleport.Pos[i].coordsped.y, Config.Teleport.Pos[i].coordsped.z + 1.25), "[ ~y~TELEPORT~s~ ]", 1.2, fontId)
                        if #(Config.Teleport.Pos[i].coordsped-GetEntityCoords(PlayerPedId())) < 4 then
                            MP.ShowHelpNotification("Press [E] to teleport")
                            if IsControlJustPressed(0,51) then
                                SendNUIMessage({
                                        type = "teleport",
                                        show = true,
                                })
                                SetNuiFocus(true, true)
                            end
                        end
                     end
           	end
            for i = 1, #Config.PedShop do
                    if #(Config.PedShop[i].coords-GetEntityCoords(PlayerPedId())) < 15 then
                        MP.DrawText3D(vector3(Config.PedShop[i].coords.x, Config.PedShop[i].coords.y, Config.PedShop[i].coords.z + 1.25), "[ ~y~SHOP~s~ ]", 1.2, fontId)
                    end
                    if #(Config.PedShop[i].coords-GetEntityCoords(PlayerPedId())) < 3 then
                        MP.ShowHelpNotification("Press [E] to open shop")
                        if IsControlJustPressed(0,51) then
                            exports["k9-inventory"]:OpenShop()
                        end
                    end
            end
            for i = 1, #Config.Entrainement.Coords do
                    if #(Config.Entrainement.Coords[i].coords-GetEntityCoords(PlayerPedId())) < 15 then
                        MP.DrawText3D(vector3(Config.Entrainement.Coords[i].coords.x, Config.Entrainement.Coords[i].coords.y, Config.Entrainement.Coords[i].coords.z + 1.25), "[ ~y~TRAINING~s~ ]", 1.2, fontId)
                    end
                    if #(Config.Entrainement.Coords[i].coords-GetEntityCoords(PlayerPedId())) < 2 then
                        MP.ShowHelpNotification("Press [E] to go to the training")
                        if IsControlJustPressed(0,51) then
                            TriggerServerEvent("MP:EnterEntrainement")
                        end
                    end
            end
        end
        
        if IsEntityOnFire(PlayerPedId()) then
            SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 1)
            StopEntityFire(PlayerPedId())
		end
        local vehss = GetVehiclePedIsTryingToEnter(PlayerPedId())
		
        if vehss ~= nil and DoesEntityExist(vehss) then

            local lockStatus = GetVehicleDoorLockStatus(vehss)
            if lockStatus == 7 then
                SetVehicleDoorsLocked(vehss, 2)
            end

            local pedsss = GetPedInVehicleSeat(vehss, -1)
            if pedsss then
                SetPedCanBeDraggedOut(pedsss, false)
            end

        end
        if GetVehiclePedIsIn(PlayerPedId(), false) ~= 0 then
            SetVehicleRadioEnabled(GetVehiclePedIsIn(PlayerPedId(), false), false)
        end
        if IsPedArmed(PlayerPedId(), 6) then
           DisableControlAction(1, 140, true)
              DisableControlAction(1, 141, true)
           DisableControlAction(1, 142, true)
        end
        SetPedCanRagdoll(PlayerPedId(), false)
        
        SetEntityProofs(PlayerPedId(), false, false, false, true, false, false, 1, false)
        abcl = 1
        for i = 1, #MP.Chat do 
            SetTextScale(0.0 * 0.8, 0.55 * 0.8)
        	SetTextFont(6)
        	SetTextProportional(true)
        	SetTextColour(255, 255, 255, 255)
        	SetTextOutline()
        	SetTextEntry('STRING')
        	--SetTextCentre(true)
        	AddTextComponentString(MP.Chat[i].msg)
        	DrawText(0.6275 - 0.62, 0.90 + (ka * abcl) - 0.25)
        	DrawRect(0.8 - 0.62, 0.916 + (ka * abcl) - 0.25, 0.35, 0.025, 0, 0, 0, 100)
        	abcl = abcl + 1
        end
        -- HUD
        
        --[[local health = (GetEntityHealth(PlayerPedId()) - 100)
        local armor = GetPedArmour(PlayerPedId())
        if MP.InSpec.bool then
            local booeel, lepedspec = GetLePlayer(MP.InSpec.source)
            if booeel then
                health = (GetEntityHealth(lepedspec) - 100)
                armor = GetPedArmour(lepedspec)
            end
        end
        if health < 0 then
            health = 0
        end
        if armor < 0 then
            armor = 0
        end
        local lehealth = (health / 100) / 5
        local learmor = (armor / 100) / 5
        if health < ancienhealth then
            StartEnleveHealth(MP.Round(ancienhealth - health))
        end
        if armor < ancienarmor then
            StartEnleveArmor(MP.Round(ancienarmor - armor))
        end
        ancienhealth = health
        ancienarmor = armor
        local stamina = (GetPlayerStamina(PlayerId()) / 100) / 5
        if not IsPedStill(PlayerPedId()) then
            if IsPedSprinting(PlayerPedId()) then
                DrawRect(0.14 + 0.725, 0.875 + 0.05, 0.2, 0.01, 0, 0, 0, 150)
                DrawRect(0.14 + 0.725 - (((stamina - 0.2) * -1) / 2), 0.875 + 0.05, stamina, 0.01, 255, 255, 255, 255)
            elseif (GetPlayerStamina(PlayerId())) ~= 100.0 then
                DrawRect(0.14 + 0.725, 0.875 + 0.05, 0.2, 0.01, 0, 0, 0, 150)
                DrawRect(0.14 + 0.725 - (((stamina - 0.2) * -1) / 2), 0.875 + 0.05, stamina, 0.01, 255, 255, 255, 255)
            end
        end
        -- la barre noir
        DrawRect(0.14 + 0.725, 0.92 + 0.05, 0.2, 0.025, 0, 26, 34, 255)
        DrawRect(0.14 + 0.725, 0.895 + 0.05, 0.2, 0.02, 0, 26, 34, 255)
        -- la barre verte et la barre bleu
        DrawRect(0.14 + 0.725 - (((lehealth - 0.2) * -1) / 2), 0.92 + 0.05, lehealth, 0.025, 124, 218, 91, 255)
        DrawRect(0.14 + 0.725 - (((learmor - 0.2) * -1) / 2), 0.895 + 0.05, learmor, 0.02, 80, 196, 255, 255)
        
        if healthaenlever > 0 then
            print("ouaisss rnnriznri")
            DrawRect(0.14 + 0.725 - (((((healthaenlever) / 100 / 5) - 0.2) * -1) / 2)  + lehealth, 0.92 + 0.05, ((healthaenlever) / 100 / 5), 0.025, 254, 113, 80, 255)
        end
        
        if armoraenelever > 0 then
            DrawRect(0.14 + 0.725 - (((((armoraenelever) / 100 / 5) - 0.2) * -1) / 2) + learmor, 0.895 + 0.05, ((armoraenelever) / 100 / 5), 0.02, 89, 160, 184, 255)
        end
        
        MP.DrawText(0.245 + 0.725, 0.9025 + 0.05, {255, 255, 255, 255}, 4, 0.9, tostring(health))
        MP.DrawText(0.245 + 0.725, 0.878 + 0.05, {255, 255, 255, 255}, 4, 0.9, tostring(armor))]]
        --DrawRect(0.19, 0.9075, 0.29, 0.075, 0,0,0,5)
        -- la bonne dimension rectangle avec un logo shield et vie
       -- DrawRect(0.18, 0.9075, 0.31, 0.075, 0,0,0,100)
       
        -- local ladist = string.len(tostring(health) == 0 and 1 or tostring(health)) * 0.0065
        -- local ladist2 = string.len(tostring(armor) == 0 and 1 or tostring(armor)) * 0.0065
        -- if armor == 0 or string.len(tostring(armor)) == 1 or string.len(tostring(armor)) == 2 then
        --     ladist2 = ladist2 + 0.0025
        -- end
        -- if health == 0 or string.len(tostring(health)) == 1 or string.len(tostring(health)) == 2 then
        --     ladist = ladist + 0.0025
        -- end
        -- MP.DrawText(0.385 + ladist + 0.0025, 0.9025, {255, 255, 255, 150}, 4, 0.9, "100")
        -- DrawRect(0.385 + ladist, 0.92, 0.003, 0.02, 255, 255, 255, 150)
        -- MP.DrawText(0.385 + ladist2 + 0.0025, 0.8725, {255, 255, 255, 150}, 4, 0.9, "100")
        -- DrawRect(0.385 + ladist2, 0.89, 0.003, 0.02, 255, 255, 255, 150)
        
        
        --DrawRect(0.3675, 0.92, 0.0035 - 0.0015, 0.02, 255, 255, 255, 255)
        --DrawRect(0.3675, 0.92, 0.01, 0.0065 - 0.0015, 255, 255, 255, 255)
        --DrawSprite("shieldee", "shieldee", 0.3675, 0.89, 0.03, 0.04, 0.0, 255, 255, 255, 255)
        
        --[[if MP.ProgressBar.bool then
            local leresultmdr = (MP.ProgressBar.pourcent / 100) / 5
            DrawRect(0.475, 0.875, 0.203, 0.05, 0, 0, 0, 255)
            DrawRect(0.475 - (((leresultmdr - 0.2) * -1) / 2), 0.875, leresultmdr, 0.0445, MP.ProgressBar.color[1], MP.ProgressBar.color[2], MP.ProgressBar.color[3], 255)
            MP.DrawText(0.475, 0.8575, {255, 255, 255, 255}, 4, 1.0, MP.ProgressBar.text, true)
        end]]
        if MP.DrawDefi.bool then
            local unresult = (MP.CalcPourcentage(MP.DrawDefi.value, MP.DrawDefi.maxvalue) / 100) * 0.11
            DrawRect(0.085, 0.3, 0.153, 0.055, 0, 0, 0, 100)
            DrawRect(0.085, 0.3, 0.15, 0.05, 255, 255,255, 10)
            MP.DrawText(0.014, 0.275, {255, 255, 255, 255}, 4, 0.75, MP.DrawDefi.text, false)
            DrawRect(0.07, 0.3125, 0.11, 0.0055, 0, 0, 0, 255)
            DrawRect(0.07 - (((unresult - 0.11) * -1) / 2), 0.3125, unresult, 0.0055, 255, 255, 255, 255)
            MP.DrawText(0.13, 0.2975, {255, 255, 255, 255}, 4, 0.75, MP.DrawDefi.value.. " / " ..MP.DrawDefi.maxvalue, false, true)
        end
        if MP.ModeDeJeu == "battleroyale" then
            for i = 1, #MP.Construction do
                if #(MP.Construction[i].coords-GetEntityCoords(PlayerPedId())) < 3 then
                    DrawProgressBar(MP.Construction[i].coords, MP.Construction[i].health .. " / " ..MP.Construction[i].maxhealth, {255, 255, 255}, 1.0,  MP.Construction[i].maxhealth, MP.Construction[i].health)
                end
                local leentity = NetworkGetEntityFromNetworkId(MP.Construction[i].netid)
                if DoesEntityExist(leentity) then
                    SetEntityCanBeDamaged(leentity, true)
                end
                if MP.Construction[i].type == "build" and #(MP.Construction[i].coords-GetEntityCoords(PlayerPedId())) < 175 then
                    local mini, maxe = GetModelDimensions(MP.Construction[i].model)
                    DrawMarker(2, MP.Construction[i].coords.x, MP.Construction[i].coords.y, MP.Construction[i].coords.z - 1.0 + maxe.z + 1.0, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, 255, 128, 0, 50, false, true, 2, nil, nil, false)
                end
            end
            local cameraRotation = GetGameplayCamRot()
            local direction = RotationToDirection(cameraRotation)
            local p = GetEntityCoords(PlayerPedId())
            if showAddConstru then
                DrawSprite("bois", "bois", 0.35, 0.7, 0.03, 0.04, 0.0, 239, 239, 231, 255)
                MP.DrawText(0.365, 0.68, {255, 255, 255, 255}, 6, 1.2, "+" ..tostring(MP.Round(construAdd)))
            end
            DrawRect(0.98, 0.65, 0.04, 0.1, 0, 0, 0, 25)
            DrawSprite("bois", "bois", 0.98, 0.63, 0.03, 0.04, 0.0, 239, 239, 231, 255)
            MP.DrawText(0.979, 0.65, {255, 255, 255, 255}, 6, 1.2, tostring(MP.Round(MP.NbConstruction)), true)
            local bool, stuff = searchEntityStuff(vector3(p.x + (direction.x * 1.25), p.y + (direction.y * 1.25), p.z))
            if bool then
                if #(stuff.coords-vector3(p.x + (direction.x * 1.25), p.y + (direction.y * 1.25), p.z)) < 1.0 then
                    local color = "~s~"
                    if stuff.rarity == "commun" then
                        color = "~c~"
                    elseif stuff.rarity == "rare" then
                        color = "~b~"
                    elseif stuff.rarity == "epic" then
                        color = "~p~"
                    elseif stuff.rarity == "legendary" then
                        color = "~y~"
                    end
                    DrawStuff(stuff.coords, string.upper(stuff.label).. "\n" ..color.. "(" ..string.upper(stuff.rarity).. ")", {255, 255, 255}, 1.0)
                    if IsControlJustPressed(0,51) and stuff.dispo then
                        stuff.dispo = false
                        Citizen.CreateThread(function()
                            local dict, anim = 'weapons@first_person@aim_rng@generic@projectile@sticky_bomb@', 'plant_floor'
    						MP.RequestAnimDict(dict)
    						TaskPlayAnim(PlayerPedId(), dict, anim, 32.0, 4.0, 250, 16, 0.0, false, false, false)
    						RemoveAnimDict(dict)
    						Wait(250)
    						TriggerServerEvent('MP:TakeStuff', stuff.id)
    						PlaySoundFrontend(-1, 'PICK_UP', 'HUD_FRONTEND_DEFAULT_SOUNDSET', false)
    					end)
                    end
                end
            end
            for i = 1, #MP.StuffParTerre do
                --local coordss = vector3(MP.StuffParTerre[i].coords.x, MP.StuffParTerre[i].coords.y, MP.StuffParTerre[i].coords.z - 1.0)
                --local coordsss = vector3(MP.StuffParTerre[i].coords.x, MP.StuffParTerre[i].coords.y, MP.StuffParTerre[i].coords.z)
                --local destination = coordss - coordsss
                DrawLightWithRange(MP.StuffParTerre[i].coords.x, MP.StuffParTerre[i].coords.y, MP.StuffParTerre[i].coords.z, 255, 0, 0, 0.1, 20.0)
            end
            
            --if searchEntityStuff(entitye) then
                --MP.ShowNotification("ouais")
           -- end
        end
        
        
        if MP.InGameBattleRoyale then
            local rgb = {255,255,255}
            if zoneencours == "zoneencours" then
                rgb = {138,43,226}
            end
            DrawSprite("minuteur", "minuteur", 0.8675, 0.265 - 0.1975, 0.02 - 0.0025, 0.035 - 0.0025, 0.0, rgb[1],rgb[2],rgb[3], 255)
            DrawSprite("kill", "kill", 0.95, 0.265 - 0.1975, 0.02 - 0.0025, 0.035 - 0.0025, 0.0, 239, 239, 231, 255)
            MP.DrawText(0.96, 0.2475 - 0.1975, {255, 255, 255, 255}, 4, 0.9, tostring(MP.MyKill[MP.ModeDeJeu]))
            DrawSprite("player", "player", 0.915, 0.265 - 0.1975, 0.02 - 0.0025, 0.035 - 0.0025, 0.0, 255,255,255, 255)
            MP.DrawText(0.925, 0.2475 - 0.1975, {255, 255, 255, 255}, 4, 0.9, tostring(GetNbPlayerFromName(MP.ModeDeJeu)))
            local tiktletime = timerzone[zoneencours] == 60 and "1:00" or "0:" ..timerzone[zoneencours]
            if timerzone[zoneencours] <= 9 then
                tiktletime = "0:0" ..timerzone[zoneencours]
            end
            MP.DrawText(0.8775, 0.2475 - 0.1975, {255, 255, 255, 255}, 4, 1.0, tiktletime)
            DrawSphere(MP.LaZone.coords.x, MP.LaZone.coords.y, MP.LaZone.coords.z, MP.LaZone.radius, 238,130,238,0.5)
        end
        if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_RPG") or GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_HOMINGLAUNCHER") or GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_COMPACTLAUNCHER") then
            if IsPedShooting(PlayerPedId()) then
                cooldown = true
                Citizen.CreateThread(function()
                    Citizen.Wait(3000)
                    cooldown = false
                end)
            end
        end

         if IsPedShooting(PlayerPedId()) and not iscombat then
            local _, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
            if (GetEntityType(entity) == 1 or (GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_RPG") or GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_HOMINGLAUNCHER") or GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_COMPACTLAUNCHER"))) and not MP.InSafezone then
                iscombat = true
                TriggerServerEvent("MP:InCombatMode", true)
                exports["k9-inventory"]:combatmode(true)
                Citizen.CreateThread(function()
                    
                    MP.ShowNotification("~r~You are in combat mode")
                    Citizen.Wait(5000)
                    --MP.ShowNotification("~g~You are not in combat mode anymore.")
                    iscombat = false
                    exports["k9-inventory"]:combatmode(false)
                    TriggerServerEvent("MP:InCombatMode", false)
                end)
            end
        end
        if GetSelectedPedWeapon(PlayerPedId()) ~= ancienweapon then
            ancienweapon = GetSelectedPedWeapon(PlayerPedId())
            if cooldown and (GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_RPG") or GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_HOMINGLAUNCHER") or GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_COMPACTLAUNCHER")) then
                    SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
             end
        end
        --MP.DrawText(0.775, 0.04, {255, 255, 255, 255}, 4, 1.0,  MP.FPS .." FPS")
        --MP.DrawText(0.86, 0.02, {255, 255, 255, 255}, 4, 0.8, "DISCORD.GG/~y~K9PVP")
    end
end)

function DeleteAllGamerTagsSquad()
    for k,v in pairs(gamerTags) do
                        RemoveMpGamerTag(v)
                    end
                    gamerTags = {}
end

RegisterKeyMapping('heal', 'MEDIKIT', 'keyboard', 'F1')
RegisterKeyMapping('armour', 'ARMOUR', 'keyboard', 'F2')

local heal, armor = false, false

local stonelasalope = MP.CreateProgressBar

local coldownheal = false
local coldownarmor = false

RegisterCommand('heal', function()
        local playerPed = PlayerPedId()
        if MP.ModeDeJeu == "battleroyale" then return end
        if GetEntityHealth(PlayerPedId()) == 200 then return end
        if IsEntityDead(PlayerPedId()) then heal = false return end
        if coldownheal then return end
        if armor or heal then return end
        heal = true
        if not IsPedInAnyVehicle(playerPed, false) then
            ClearPedTasksImmediately(PlayerPedId())
            RequestAnimDict("amb@medic@standing@kneel@base")
            while not HasAnimDictLoaded("amb@medic@standing@kneel@base") do
                Citizen.Wait(0)
            end
            TaskPlayAnim(playerPed, "amb@medic@standing@kneel@base", "base", 2.5, -2.0, -1, 1, 0.5, false, false, false)
        end
        stonelasalope(1740, "Healing", "#ff0707")
        local salope = false
        for i = 1, 20 do
            SetTimeout(i * 87, function()
                if IsEntityDead(PlayerPedId()) then heal = false return end
                if MP.ModeDeJeu == "battleroyale" then heal = false return end
                if heal then
                    local x = 5
                    if GetEntityHealth(PlayerPedId()) >= 195 then
                        x = 200 - GetEntityHealth(PlayerPedId())
                		if GetVehiclePedIsIn(PlayerPedId(), false) == 0 then
                			ClearPedTasksImmediately(PlayerPedId())
                		end
                		heal = false
                		salope = true
                		coldownheal = true
                		CreateThread(function()
                		    Citizen.Wait(1740)
                            coldownheal = false
                		end)
                		SendNUIMessage({
                            type = "progressbar",
                            action = "stop"
                        })
                    end
                    SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + x)
                end
            end)
        end
        Citizen.Wait(1740)
        if not salope then
            coldownheal = true
            heal = false
            if GetVehiclePedIsIn(PlayerPedId(), false) == 0 then
                		ClearPedTasksImmediately(PlayerPedId())
            end
            Citizen.Wait(1740)
            coldownheal = false
        end
end)

RegisterCommand('armour', function()
        local playerPed = PlayerPedId()
        if MP.ModeDeJeu == "battleroyale" then return end
        if IsEntityDead(PlayerPedId()) then armor = false return end
        if GetPedArmour(PlayerPedId()) == 100 then return end
        if coldownarmor then return end
        if armor or heal then return end
        armor = true
        if not IsPedInAnyVehicle(playerPed, false) then
            ClearPedTasksImmediately(PlayerPedId())
            RequestAnimDict("amb@medic@standing@kneel@base")
            while not HasAnimDictLoaded("amb@medic@standing@kneel@base") do
                Citizen.Wait(0)
            end
            TaskPlayAnim(playerPed, "amb@medic@standing@kneel@base", "base", 2.0, -2.0, -1, 1, 0.5, false, false, false)
        end
        stonelasalope(1740, "Armor", "#F9F871")
        local salopee = false
        for i = 1, 20 do
            SetTimeout(i * 87, function()
                if armor then
                    AddArmourToPed(PlayerPedId(), 5)
                    if GetPedArmour(PlayerPedId()) >= 95 then
                        if GetVehiclePedIsIn(PlayerPedId(), false) == 0 then
                			ClearPedTasksImmediately(PlayerPedId())
                		end
                        armor = false
                        salopee = true
                        coldownarmor = true
                        CreateThread(function()
                            Citizen.Wait(1740)
                            coldownarmor = false
                        end)
                        AddArmourToPed(PlayerPedId(), 5)
                        SendNUIMessage({
                            type = "progressbar",
                            action = "stop"
                        })
                    
                    end
                
                    if IsEntityDead(PlayerPedId()) then armor = false return end
                    if MP.ModeDeJeu == "battleroyale" then armor = false return end
                end
            end)
        end
        Citizen.Wait(1740)
        
	    if not salopee then
	        armor = false
	        coldownarmor = true
            if GetVehiclePedIsIn(PlayerPedId(), false) == 0 then
                	ClearPedTasksImmediately(PlayerPedId())
            end
	        Citizen.Wait(1740)
	        coldownarmor = false
	    end
		
end)

--[[RegisterCommand("startprogressbar", function(source, args)
    if tonumber(args[1]) == nil then return end
    if args[2] == nil then return end
    MP.CreateProgressBar(tonumber(args[1]), args[2])
end)

RegisterCommand("stone", function(source, args)
    if tonumber(args[1]) == nil then return end
    MP.MyKill[MP.ModeDeJeu] = tonumber(args[1])
end)]]

function StartEnleveHealth(nb)
    local lenb = nb
    healthaenlever = healthaenlever + nb
    Citizen.CreateThread(function()
        for i = 1, lenb do
            healthaenlever = healthaenlever - 1
            if GetEntityHealth(PlayerPedId()) == 200 then
                healthaenlever = 0
                break
            end
            Citizen.Wait(13)
        end
        if healthaenlever < 0 then
            healthaenlever = 0
        end
    end)
end
function StartEnleveArmor(nb)
    local lenb = nb
    armoraenelever = armoraenelever + nb
    Citizen.CreateThread(function()
        for i = 1, lenb do
            armoraenelever = armoraenelever - 1
            if GetPedArmour(PlayerPedId()) == 100 then
                armoraenelever = 0
                break
            end
            Citizen.Wait(13)
        end
        if armoraenelever < 0 then
            armoraenelever = 0
        end
    end)
end

function GetLePlayer(id)
    for _, player in ipairs(GetActivePlayers()) do
        if GetPlayerServerId(player) == tonumber(id) then
            return true, GetPlayerPed(player)
        end
    end
    return false
end
function DrawStuff(position, value, color, size)
    Citizen.CreateThread(function()
        -- checks if the timeout is true
        local positionOffset = {x=0, y=0}
        if math.random(2) == 1 then positionOffset.x = -math.random()/50 else positionOffset.x = math.random()/50 end
        if math.random(2) == 1 then positionOffset.y = -math.random()/50 else positionOffset.y = math.random()/50 end
        local currentAlpha = math.floor(math.random(127)) + 127
        local currentAlpha = 255
        local perspectiveScale = 2
        local scaleMultiplier = size or 1
        local font = 6
        local textOutline = true
        --while currentAlpha > 0 do
            Citizen.Wait(0)
            local onScreen, _x, _y = World3dToScreen2d(position.x, position.y, position.z)
            _x = _x + 0.125
            _y = _y - 0.035
            local p = GetGameplayCamCoords()
            local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, position.x, position.y, position.xyz.z, 1)
            local scale = (1 / distance) * (perspectiveScale)
            local fov = (1 / GetGameplayCamFov()) * 75
            scale = scale * fov
            if onScreen then
                SetTextScale(tonumber(scaleMultiplier * 0.0), tonumber(0.50 * scaleMultiplier))
                SetTextFont(font)
                SetTextProportional(true)

                SetTextColour(color[1], color[2], color[3], currentAlpha)

                if (textOutline) == true then SetTextOutline() end;
                SetTextEntry("STRING")
                
                AddTextComponentString(value)
                DrawText(_x - 0.03, _y)
                local ley = 0
                for i = 1, 2 do
                    ley = ley + 0.033
                end
                DrawRect(_x, _y+(ley/2), 0.175, ley, 0, 0, 0, 125)
                DrawRect(_x - 0.065, _y+(ley/2) - 0.0125, 0.015, 0.03, 0, 0, 0, 125)
                MP.DrawText(_x - 0.065, _y+(ley/2) - 0.031, {255, 255, 255, 255}, 6, 1.0, "E", true)
                MP.DrawText(_x - 0.065, _y+(ley/2) + 0.005, {255, 255, 255, 255}, 6, 0.75, "RAMASSER", true)
                -- DrawText(_x, _y)
            end
        --end
    end)
end

function searchEntityStuff(vector)
    if #MP.StuffParTerre > 0 then
        local dist = #(vector-MP.StuffParTerre[1].coords)
        local stuff = MP.StuffParTerre[1]
        for i = 1, #MP.StuffParTerre do
            if #(MP.StuffParTerre[i].coords-vector) < dist then
                dist = #(MP.StuffParTerre[i].coords-vector)
                stuff = MP.StuffParTerre[i]
            end
        end
        return true, stuff
    else
        return false
    end
end

RegisterNetEvent("MP:ChangeModeDeJeu")
AddEventHandler("MP:ChangeModeDeJeu", function(name)
    MP.ModeDeJeu = name
    exports["k9-inventory"]:ModeDeJeu(name)
end)

function MP.DrawText(x, y, color, font, scale, text, centre, a)
    if centre then
        SetTextCentre(true)
    end
    scale = scale - 0.1
    y = y - 0.0025
    SetTextScale(0.0 * scale, 0.55 * scale)
    SetTextFont(font)
    --SetTextProportional(true)
    SetTextColour(color[1], color[2], color[3], color[4])
    if a == nil then
        SetTextOutline()
    end
    --SetTextDropShadow(0, 0, 0, 0,255) 
    --SetTextEdge(1, 0, 0, 0, 255) 
    --SetTextDropShadow() 
    SetTextEntry('STRING')
    AddTextComponentString(text)
    DrawText(x, y)
end

--[[RegisterCommand("health", function(source, args)
    SetEntityHealth(PlayerPedId(), tonumber(args[1]))
end)

RegisterCommand("armor", function(source, args)
    SetPedArmour(PlayerPedId(), tonumber(args[1]))
end)]]

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local worked, groundZ, normal = GetGroundZAndNormalFor_3dCoord(coords.x, coords.y, coords.z)
    		--print()
    	    --print(#(coords-vector3(coords.x, coords.y, groundZ)), IsPedFalling(playerPed))
    		    --ClearPedTasksImmediately(PlayerPedId())
    		   
    		    --SetPedCanRagdoll(PlayerPedId(), false)
           		SetPedConfigFlag(PlayerPedId(), 359, false)
            	SetPedConfigFlag(PlayerPedId(), 422, false)
            	if IsPedGettingUp(PlayerPedId()) then
                	local velo = GetEntityVelocity(PlayerPedId())
                	ClearPedTasksImmediately(playerPed)
                	SetEntityVelocity(PlayerPedId(), velo)
    		        Citizen.Wait(1000)
               	end
    		    if IsPedFalling(playerPed) and #(coords-vector3(coords.x, coords.y, groundZ)) <= 6.0 then
    		        ClearPedTasksImmediately(playerPed)
    		        Citizen.Wait(1000)
    		   end

    	end
end)

function ReturnIdPlayerKill()
    local Killer = nil
    local PedKiller = GetPedSourceOfDeath(PlayerPedId())
    local DeathCauseHash = GetPedCauseOfDeath(PlayerPedId())
    if IsEntityAPed(PedKiller) and IsPedAPlayer(PedKiller) then
		Killer = NetworkGetPlayerIndexFromPed(PedKiller)
	elseif IsEntityAVehicle(PedKiller) and IsEntityAPed(GetPedInVehicleSeat(PedKiller, -1)) and IsPedAPlayer(GetPedInVehicleSeat(PedKiller, -1)) then
		Killer = NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(PedKiller, -1))
	end
	if (Killer ~= nil and PedKiller ~= nil) then
        return GetPlayerServerId(Killer), DeathCauseHash
    end
    return 0, DeathCauseHash
end

function CreateBlipCircle(coords, text, radius, color, sprite)
	local blip = AddBlipForRadius(coords, radius)

	SetBlipHighDetail(blip, true)
	SetBlipColour(blip, 2)
	SetBlipAlpha (blip, 128)

	-- create a blip in the middle
	blip = AddBlipForCoord(coords)
	SetBlipHighDetail(blip, true)
	SetBlipSprite (blip, sprite)
	SetBlipScale  (blip, 0.7)
	SetBlipColour (blip, color)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(text)
	EndTextCommandSetBlipName(blip)
end

local iscolwodn = false

RegisterCommand("solotricks", function(source, args)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if iscolwodn then MP.ShowNotification("~r~You are in cooldown solo deluxo tricks") return end
    if veh == 0 then return end
    if GetEntityModel(veh) ~= GetHashKey("deluxo") then return end
    if MP.InSafezone then MP.ShowNotification("~r~You are in safezone") return end
    if GetEntitySpeed(veh) >= 12.5 then MP.ShowNotification("~r~You're going too fast") return end
    local vel = GetEntityVelocity(veh)
    SetEntityCoords(ped, GetEntityCoords(veh).x, GetEntityCoords(veh).y, GetEntityCoords(veh).z)
    SetEntityVelocity(ped, vel)
    iscolwodn = true
    SetTimeout(3000, function()
        iscolwodn = false
    end)
end)

RegisterKeyMapping("solotricks", "Solo Tricks Deluxo", "keyboard", "B")

local leblip = {}

local function searchPlayer(id)
    for i = 1, #MP.MySquad do
        if MP.MySquad[i].id == id then
            return true
        end
   	end
    return false
end

RegisterNetEvent("MP:DrawBlips")
AddEventHandler("MP:DrawBlips", function(coords, id, idxtarget)
        local lesprite = (idxtarget == GetPlayerServerId(PlayerId()) or searchPlayer(idxtarget)) and 432 or 429
        if DoesBlipExist(leblip[tostring(id)]) then
            RemoveBlip(leblip[tostring(id)])
        end
            leblip[tostring(id)] = AddBlipForCoord(coords)
            SetBlipSprite(leblip[tostring(id)],  lesprite)
            SetBlipDisplay(leblip[tostring(id)], 4)
            SetBlipScale(leblip[tostring(id)], lesprite == 432 and 0.80 or 0.60)
            SetBlipColour(leblip[tostring(id)], lesprite == 432 and 0 or 1)
            SetBlipAsShortRange(leblip[tostring(id)], true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Mort")
            EndTextCommandSetBlipName(leblip[tostring(id)])
            Citizen.Wait(15000)
            RemoveBlip(leblip[tostring(id)])
end)

RegisterCommand("kill", function(source, args)
    if MP.InSafezone then MP.ShowNotification("~r~You are in safezone") return end
    local coords = GetEntityCoords(PlayerPedId())
    Citizen.Wait(1000)
    if GetEntityCoords(PlayerPedId()) ~= coords then return end
    MP.ShowNotification("Wait ~b~5s")
    Wait(1000)
    if GetEntityCoords(PlayerPedId()) ~= coords then return end
    MP.ShowNotification("Wait ~b~4s")
    if GetEntityCoords(PlayerPedId()) ~= coords then return end
    Wait(1000)
    MP.ShowNotification("Wait ~b~3s")
    if GetEntityCoords(PlayerPedId()) ~= coords then return end
    Wait(1000)
    if GetEntityCoords(PlayerPedId()) ~= coords then return end
    MP.ShowNotification("Wait ~b~2s")
    Wait(1000)
    if GetEntityCoords(PlayerPedId()) ~= coords then return end
    MP.ShowNotification("Wait ~b~1s")
    Wait(1000)
    if GetEntityCoords(PlayerPedId()) ~= coords then return end
    MP.ShowNotification("You are ~b~dead")
    SetEntityHealth(PlayerPedId(), 0)
end)

RegisterCommand("discord", function()
        MP.ShowNotification("https://discord.gg/k9pvp")
end)

RegisterNetEvent("MP:ShowCheaterWorld")
AddEventHandler("MP:ShowCheaterWorld", function(id)
        SendNUIMessage({
                type = "cheaterworld",
                action = "show",
                id = id,
            })
end)

RegisterNetEvent("MP:HideCheaterWorld")
AddEventHandler("MP:HideCheaterWorld", function()
        SendNUIMessage({
                type = "cheaterworld",
                action = "hide",
       })
end)