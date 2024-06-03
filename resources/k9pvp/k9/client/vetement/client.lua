local inClothingShop = false
local inBarberShop   = false 
local inTattooShop   = false
local allMyOutfits   = {}

local id 

RegisterCommand("skin", function()
	local safe = MP.InSafezone
	if safe then
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
				print('Saved')
			else
				print('Canceled')
			end
			--lib.showTextUI("[E] Change Hair/Face", {icon = "fa-solid fa-scissors"})
		end, config)
	else
		MP.ShowNotification("You are not in safezone")
	end
end)
	


RegisterNetEvent('fivem-appearance:inShop')
AddEventHandler('fivem-appearance:inShop', function()
	--[[if inClothingShop then
		lib.showTextUI("[E] Change Clothing", {icon = "fa-solid fa-shirt"})
	elseif inBarberShop then
		lib.showTextUI("[E] Change Hair/Face", {icon = "fa-solid fa-scissors"})
	elseif inTattooShop then
		lib.showTextUI("[E] Change Tattoos", {icon = "fa-solid fa-child"})
	end]]
	while inClothingShop or inBarberShop or inTattooShop do
		Citizen.Wait(0)
		if IsControlPressed(1, 38) then
			Citizen.Wait(500)
			if inClothingShop then
				TriggerEvent("fivem-appearance:clothingShop")
			end
			if inTattooShop then
				TriggerEvent("fivem-appearance:tattooMenu")
			end
			if inBarberShop then
				local config = {
					ped = true,
					headBlend = true,
					faceFeatures = true,
					headOverlays = true,
					components = false,
					props = false,
					tattoos = false
				}
				exports['fivem-appearance']:startPlayerCustomization(function (appearance)
					if (appearance) then
						TriggerServerEvent('esx_skin:save', appearance)
						-- print(appearance)
						print('Saved')
					else
						print('Canceled')
					end
				end, config)
			end
		end
	end
end)


RegisterNetEvent('fivem-appearance:clothingMenu', function()
	local config = {
		ped = true,
		headBlend = false,
		faceFeatures = false,
		headOverlays = false,
		components = true,
		props = true,
    	tattoos = false
	}
	
	exports['fivem-appearance']:startPlayerCustomization(function (appearance)
		if (appearance) then
			TriggerServerEvent('esx_skin:save', appearance)
			-- print(appearance)
			print('Saved')
		else
			print('Canceled')
		end
	end, config)
end)

RegisterNetEvent('fivem-appearance:tattooMenu', function()
	local config = {
		ped = false,
		headBlend = false,
		faceFeatures = false,
		headOverlays = false,
		components = false,
		props = false,
    	tattoos = true
	}
	
	exports['fivem-appearance']:startPlayerCustomization(function (appearance)
		if (appearance) then
			local tattoos = exports['fivem-appearance']:getPedTattoos(PlayerPedId())
			TriggerServerEvent('esx_skin:save', appearance, tattoos)
			-- print(appearance)
			print('Saved')
		else
			print('Canceled')
		end
	end, config)
end)

RegisterNetEvent('fivem-appearance:getOutfits')
AddEventHandler('fivem-appearance:getOutfits', function()
	TriggerServerEvent('fivem-appearance:getOutfits')
end)

RegisterNetEvent('fivem-appearance:sendOutfits')
AddEventHandler('fivem-appearance:sendOutfits', function(myOutfits)
	local Outfits = {}
	for i=1, #myOutfits, 1 do
		table.insert(Outfits, {id = myOutfits[i].id, name = myOutfits[i].name, pedModel = myOutfits[i].ped, pedComponents = myOutfits[i].components, pedProps = myOutfits[i].props})
	end
	allMyOutfits = Outfits
end)

RegisterNetEvent('fivem-appearance:setOutfit')
AddEventHandler('fivem-appearance:setOutfit', function(data)
	local pedModel = data.ped
	local pedComponents = data.components
	local pedProps = data.props
	local playerPed = PlayerPedId()
	local currentPedModel = exports['fivem-appearance']:getPedModel(playerPed)
	if currentPedModel ~= pedModel then
    	exports['fivem-appearance']:setPlayerModel(pedModel)
		Citizen.Wait(500)
		playerPed = PlayerPedId()
		exports['fivem-appearance']:setPedComponents(playerPed, pedComponents)
		exports['fivem-appearance']:setPedProps(playerPed, pedProps)
		local appearance = exports['fivem-appearance']:getPedAppearance(playerPed)
		TriggerServerEvent('esx_skin:save', appearance)
	else
		exports['fivem-appearance']:setPedComponents(playerPed, pedComponents)
		exports['fivem-appearance']:setPedProps(playerPed, pedProps)
		local appearance = exports['fivem-appearance']:getPedAppearance(playerPed)
		TriggerServerEvent('esx_skin:save', appearance)
	end
end)

RegisterNetEvent('fivem-appearance:saveOutfit', function()
	if input ~= nil then
		local playerPed = PlayerPedId()
		local pedModel = exports['fivem-appearance']:getPedModel(playerPed)
		local pedComponents = exports['fivem-appearance']:getPedComponents(playerPed)
		local pedProps = exports['fivem-appearance']:getPedProps(playerPed)
		Citizen.Wait(500)
		TriggerServerEvent('fivem-appearance:saveOutfit', input[1], pedModel, pedComponents, pedProps)
	end
end)

RegisterNetEvent('fivem-appearance:deleteOutfit')
AddEventHandler('fivem-appearance:deleteOutfit', function(id)
	TriggerServerEvent('fivem-appearance:deleteOutfit', id)
end)

-- Add compatibility with skinchanger and esx_skin TriggerEvents
RegisterNetEvent('skinchanger:loadSkin')
AddEventHandler('skinchanger:loadSkin', function(skin, cb)
	if not skin then 
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
		if cb ~= nil then
			cb()
		end
	end
end)

RegisterNetEvent('esx_skin:openSaveableMenu')
AddEventHandler('esx_skin:openSaveableMenu', function(submitCb, cancelCb)
	local config = {
		ped = true,
		headBlend = true,
		faceFeatures = true,
		headOverlays = true,
		components = true,
		props = true,
    	tattoos = false
	}
	exports['fivem-appearance']:startPlayerCustomization(function (appearance)
		if (appearance) then
			TriggerServerEvent('esx_skin:save', appearance)
			-- print(appearance)
			if submitCb ~= nil then submitCb() end
		elseif cancelCb ~= nil then
			cancelCb()
		end
	end, config)
end)


Citizen.CreateThread(function()
	for i = 1, #Config.vetement.coords do
        local hash = GetHashKey("a_f_o_soucent_01")
        while not HasModelLoaded(hash) do
        RequestModel(hash)
        Wait(20)
        end
        MP.SpawnPed({name = "a_f_o_soucent_01", coords = vector3(Config.vetement.coords[i].coords.x, Config.vetement.coords[i].coords.y, Config.vetement.coords[i].coords.z - 1.0), heading = Config.vetement.coords[i].heading}, true)
        MP.CreateBlips({coords = Config.vetement.coords[i].coords, sprite = 73, display = 5, scale = 0.75, color = 5})
        
    end
end)