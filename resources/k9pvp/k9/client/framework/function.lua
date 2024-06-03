function RotationToDirection(rotation)
	local adjustedRotation = { 
		x = (math.pi / 180) * rotation.x, 
		y = (math.pi / 180) * rotation.y, 
		z = (math.pi / 180) * rotation.z 
	}
	local direction = {
		x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
		y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
		z = math.sin(adjustedRotation.x)
	}
	return direction
end

function RayCastGamePlayCamera(distance)
	local cameraRotation = GetGameplayCamRot()
	local cameraCoord = GetGameplayCamCoord()
	local direction = RotationToDirection(cameraRotation)
	local destination = { 
		x = cameraCoord.x + direction.x * distance, 
		y = cameraCoord.y + direction.y * distance, 
		z = cameraCoord.z + direction.z * distance 
	}
	local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, -1, 1))
	return b, c, e
end

function MP.ConvertToRes(x, y)
    return (x * 1920), (y * 1080)
end
function MP.CalcPourcentage(p, t)
	return (100 * p) / t;
end

function MP.CreateProgressBar(times, text, color)
	SendNUIMessage({
		type = "progressbar",
		action = "run",
		time = times / 1000,
		text = text,
		color = color,
	})
	--if MP.ProgressBar.bool then return end
	-- MP.ProgressBar = {
	--     bool = true,
	--     color = color or {51, 121, 234},
	--     text = text or "",
	--     times = times,
	--     pourcent = 0.0, 
	-- }
	-- Citizen.CreateThread(function()
	-- 	local result = MP.ProgressBar.times / 100
	-- 	for i = 1, 100 do
	-- 		SetTimeout(i * result, function()
	-- 			MP.ProgressBar.pourcent = MP.ProgressBar.pourcent + 1.01
	-- 		end)
	-- 	end
	-- 	SetTimeout(100 * result, function()
	-- 			MP.ProgressBar = {
	-- 			    bool = false,
	-- 			    color = {255,255,255},
	-- 			    text = "",
	-- 			    times = 0.0,
	-- 			    pourcent = 0.0, 
	-- 			}
	-- 	end)
	-- end)
end

MP.DrawText3D = function(coords, text, size, font)
	local vector = type(coords) == "vector3" and coords or vec(coords.x, coords.y, coords.z)

	local camCoords = GetGameplayCamCoords()
	local distance = #(vector - camCoords)

	if not size then size = 1 end
	if not font then font = 0 end

	local scale = (size / distance) * 2
	local fov = (1 / GetGameplayCamFov()) * 100
	scale = scale * fov

	SetTextScale(0.0 * scale, 0.55 * scale)
	SetTextFont(font)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry('STRING')
	SetTextCentre(true)
    SetTextOutline()
	AddTextComponentString(text)
	SetDrawOrigin(vector.xyz, 0)
	DrawText(0.0, 0.0)
	ClearDrawOrigin()
end

function MP.ShowNotification(msg)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(msg)
	DrawNotification(0,1)
end

function MP.ShowAdvancedNotification(sender, subject, msg, textureDict, iconType, flash, saveToBrief, hudColorIndex)
    if saveToBrief == nil then
        saveToBrief = true
    end
    AddTextEntry('esxAdvancedNotification', msg)
    BeginTextCommandThefeedPost('esxAdvancedNotification')
    if hudColorIndex then
        ThefeedSetNextPostBackgroundColor(hudColorIndex)
    end
    EndTextCommandThefeedPostMessagetext(textureDict, textureDict, false, iconType, sender, subject)
    EndTextCommandThefeedPostTicker(flash or false, saveToBrief)
end

function MP.ShowHelpNotification(msg, thisFrame, beep, duration)
    AddTextEntry('esxHelpNotification', msg)

    if thisFrame then
        DisplayHelpTextThisFrame('esxHelpNotification', false)
    else
        if beep == nil then
            beep = false
        end
        BeginTextCommandDisplayHelp('esxHelpNotification')
        EndTextCommandDisplayHelp(0, false, beep, duration or -1)
    end
end

local function foundgroup(name)
	for i = 1, #MP.Group do
		if MP.Group[i] == name then
			return i
		end
	end
end

local function foundgroupmini(name)
	for i = 1, #MP.Group do
		if MP.Group[i] == name then
			return i 
		end
	end
end

function IsPerm(maperm, laperm)
	local bool = foundgroup(maperm) >= foundgroupmini(laperm)
	return bool
end

function MP.CreateBlips(info)
	local blip = AddBlipForCoord(info.coords.x, info.coords.y, info.coords.z)
    SetBlipSprite(blip, info.sprite)
    SetBlipDisplay(blip, info.display)
    SetBlipScale(blip, info.scale)
    SetBlipColour(blip, info.color)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(info.name)
    EndTextCommandSetBlipName(blip)
    return blip
end

local allpedspawn = {}

function MP.SpawnPed(info, is)
	local pedHash = GetHashKey(info.name)
	MP.RequestModel(pedHash)
    
    local ped = CreatePed(7, pedHash, info.coords, info.heading, false, false)
    table.insert(allpedspawn, ped)
    if is then
	    SetBlockingOfNonTemporaryEvents(ped, true)
        SetPedDiesWhenInjured(ped, false)
        SetPedCanPlayAmbientAnims(ped, true) 
        SetPedCanRagdollFromPlayerImpact(ped, false) 
        SetEntityInvincible(ped, true)	
        FreezeEntityPosition(ped, true)
        SetEntityCollision(ped, false, false)
	end
    return ped
end

AddEventHandler("onResourceStop", function(name)
    if name == GetCurrentResourceName() then
        for i = 1, #allpedspawn do
                if DoesEntityExist(allpedspawn[i]) then
                    DeleteEntity(allpedspawn[i])
                end
        end
    end
end)



function MP.GiveKeyVehicle(plate, model, isperm)
	TriggerServerEvent("MP:GiveKeyVehicle", plate, model, isperm)
end

function MP.DumpTable(table, nb)
	if nb == nil then
		nb = 0
	end

	if type(table) == 'table' then
		local s = ''
		for _ = 1, nb + 1, 1 do
			s = s .. "    "
		end

		s = '{\n'
		for k, v in pairs(table) do
			if type(k) ~= 'number' then k = '"' .. k .. '"' end
			for _ = 1, nb, 1 do
				s = s .. "    "
			end
			s = s .. '[' .. k .. '] = ' .. MP.DumpTable(v, nb + 1) .. ',\n'
		end

		for _ = 1, nb, 1 do
			s = s .. "    "
		end

		return s .. '}'
	else
		return tostring(table)
	end
end

function KeyboardInput(textEntry, inputText, maxLength)   


    AddTextEntry('FMMC_KEY_TIP1', textEntry)
	DisplayOnscreenKeyboard(1, 'FMMC_KEY_TIP1', '', inputText, '', '', '', maxLength)

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end

	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		return result
	else
		Citizen.Wait(500)
		return KeyboardInput(textEntry, inputText, maxLength)
	end
end

function MP.Round(value, numDecimalPlaces)
	if numDecimalPlaces then
		local power = 10 ^ numDecimalPlaces
		return math.floor((value * power) + 0.5) / (power)
	else
		return math.floor(value + 0.5)
	end
end

-- credit http://richard.warburton.it
function MP.GroupDigits(value)
	local left, num, right = string.match(value, '^([^%d]*%d)(%d*)(.-)$')

	return left .. (num:reverse():gsub('(%d%d%d)', '%1' .. " "):reverse()) .. right
end

function MP.Trim(value)
	if value then
		return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
	else
		return nil
	end
end

function MP.ShowFreemodeMessage(title, msg, sec)
	local scaleform = MP.RequestScaleformMovie('MP_BIG_MESSAGE_FREEMODE')

	BeginScaleformMovieMethod(scaleform, 'SHOW_SHARD_WASTED_MP_MESSAGE')
	ScaleformMovieMethodAddParamTextureNameString(title)
	ScaleformMovieMethodAddParamTextureNameString(msg)
	EndScaleformMovieMethod()

	while sec > 0 do
		Wait(0)
		sec = sec - 0.01

		DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
	end

	SetScaleformMovieAsNoLongerNeeded(scaleform)
end

function MP.ShowBreakingNews(title, msg, bottom, sec)
	local scaleform = MP.RequestScaleformMovie('BREAKING_NEWS')

	BeginScaleformMovieMethod(scaleform, 'SET_TEXT')
	ScaleformMovieMethodAddParamTextureNameString(msg)
	ScaleformMovieMethodAddParamTextureNameString(bottom)
	EndScaleformMovieMethod()

	BeginScaleformMovieMethod(scaleform, 'SET_SCROLL_TEXT')
	ScaleformMovieMethodAddParamInt(0) -- top ticker
	ScaleformMovieMethodAddParamInt(0) -- Since this is the first string, start at 0
	ScaleformMovieMethodAddParamTextureNameString(title)

	EndScaleformMovieMethod()

	BeginScaleformMovieMethod(scaleform, 'DISPLAY_SCROLL_TEXT')
	ScaleformMovieMethodAddParamInt(0) -- Top ticker
	ScaleformMovieMethodAddParamInt(0) -- Index of string

	EndScaleformMovieMethod()

	while sec > 0 do
		Wait(0)
		sec = sec - 0.01

		DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
	end

	SetScaleformMovieAsNoLongerNeeded(scaleform)
end

function MP.ShowPopupWarning(title, msg, bottom, sec)
	local scaleform = MP.RequestScaleformMovie('POPUP_WARNING')

	BeginScaleformMovieMethod(scaleform, 'SHOW_POPUP_WARNING')

	ScaleformMovieMethodAddParamFloat(500.0) -- black background
	ScaleformMovieMethodAddParamTextureNameString(title)
	ScaleformMovieMethodAddParamTextureNameString(msg)
	ScaleformMovieMethodAddParamTextureNameString(bottom)
	ScaleformMovieMethodAddParamBool(true)

	EndScaleformMovieMethod()

	while sec > 0 do
		Wait(0)
		sec = sec - 0.01

		DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
	end

	SetScaleformMovieAsNoLongerNeeded(scaleform)
end

function MP.ShowTrafficMovie(sec)
	local scaleform = MP.RequestScaleformMovie('TRAFFIC_CAM')

	BeginScaleformMovieMethod(scaleform, 'PLAY_CAM_MOVIE')

	EndScaleformMovieMethod()

	while sec > 0 do
		Wait(0)
		sec = sec - 0.01

		DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
	end

	SetScaleformMovieAsNoLongerNeeded(scaleform)
end

function MP.RequestScaleformMovie(movie)
	local scaleform = RequestScaleformMovie(movie)

	while not HasScaleformMovieLoaded(scaleform) do
		Wait(0)
	end

	return scaleform
end