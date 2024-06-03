Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if NetworkIsPlayerActive(PlayerId()) then
			setAutoSpawn(false)
			DoScreenFadeOut(0)
			TriggerServerEvent('MP:PlayerJoin')
            ShutdownLoadingScreen()
			ShutdownLoadingScreenNui()
			break
		end
	end
end)

local function FreezePlayer(player, freeze)
	SetPlayerControl(player, not freeze, false)
	local ped = GetPlayerPed(player)

	if not freeze then
		if not IsEntityVisible(ped) then
			SetEntityVisible(ped, true)
		end

		if not IsPedInAnyVehicle(ped) then
			SetEntityCollision(ped, true)
		end

		FreezeEntityPosition(ped, false)
		SetPlayerInvincible(player, false)
	else
		if IsEntityVisible(ped) then
			SetEntityVisible(ped, false)
		end

		SetEntityCollision(ped, false)
		FreezeEntityPosition(ped, true)
		SetPlayerInvincible(player, true)

		if not IsPedFatallyInjured(ped) then
			ClearPedTasksImmediately(ped)
		end
	end
end

local data = {}



RegisterNetEvent("MP:PlayerLoad")
AddEventHandler("MP:PlayerLoad", function(io, IsNew, n, skin)
    --IdUnique = MP.idunique
    if MP.Loaded then return end
    local isnew = IsNew
    local msg = n
    
    MP.SetPlayerData(io)
    local pose = GetClosestSafezoneFromCoords(vector3(io.position.x, io.position.y, io.position.z))
    spawnPlayer({
        x = 241.2887878418, 
        y = -768.60821533203, 
        z = 30.765214920044,
        heading = 167.09230041504,
        model = `mp_m_freemode_01`,
        skipFade = false,
        anim = false,
    }, function()
        ShutdownLoadingScreen()
        ShutdownLoadingScreenNui()
        if skin == nil or skin == "" then
            local modelHash = GetHashKey("mp_m_freemode_01")
            RequestModel(modelHash)
            while not HasModelLoaded(modelHash) do
            Wait(0)
            end
            SetPlayerModel(PlayerId(), modelHash)
            SetPedDefaultComponentVariation(PlayerPedId())
            SetModelAsNoLongerNeeded(modelHash)
       	else
            local playerPed = PlayerPedId()
            Citizen.Wait(500)
            exports['fivem-appearance']:setPlayerAppearance(skin)
       	end
        SetEntityHealth(PlayerPedId(), 200)
        SetPedArmour(PlayerPedId(), 100)
		TriggerEvent('XNL_NET:XNL_SetInitialXPLevels', tonumber(io.xp), true, true)
        SendNUIMessage({
                type = "shopk9",
                action = "setshopk9",
                data = Config.ShopK9,
        })
       	SetTimeout(1000, function()
              FpsBooster(io["parameter"]["fpsboost"]["enable"])
        end)     
        
				
        for i = 1, #msg["normal"] do
            MP.ShowNotification(msg["normal"][i].message)
        end
        for i = 1, #msg["advanced"] do
            MP.ShowAdvancedNotification(msg["advanced"][i].title, msg["advanced"][i].subject, msg["advanced"][i].message, msg["advanced"][i].texture, msg["advanced"][i].icon)
        end
        if isnew then
            while MP.CheckRPF do Citizen.Wait(1) end
           	Citizen.Wait(500)
            TriggerEvent("esx_skin:openSaveableMenu")
        end
    end)
end)

RegisterNetEvent("MP:UpdatePPSteam")
AddEventHandler("MP:UpdatePPSteam", function(url)
    SendNUIMessage({
         type = "setppsteam",
         pp = url
    })
end)
