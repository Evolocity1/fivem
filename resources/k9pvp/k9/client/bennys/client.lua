local bennyLocation = {
	{coords = vector3(966.97430419922, -127.87487792969, 74.370040893555), heading = 0.0},
    {coords = vector3(-1275.7807617188, 274.22866821289, 64.796653747559), heading = 0.0},
    {coords = vector3(229.69413757324, -803.419921875, 30.535745620728), heading = 0.0},
    {coords = vector3(-770.26116943359, 5541.3715820312, 33.490230560303), heading = 0.0},
}
--local bennyLocation = vector3(-515.3406, -255.1252, 35.61536)
--local bennyLocation = vector3(-515.3406, -255.1252, 35.61536)

--local bennyHeading = 5.6692910194396

--location = {x = -515.3406, y = -255.1252, z = 35.61536}

function disableControls()
    DisableControlAction(1, 172, true) --Key: Up Arrow
    DisableControlAction(1, 173, true) --Key: Down Arrow
    DisableControlAction(1, 177, true) --Key: Backspace
    DisableControlAction(1, 176, true) --Key: Enter
    DisableControlAction(1, 71, true) --Key: W (veh_accelerate)
    DisableControlAction(1, 72, true) --Key: S (veh_brake)
    DisableControlAction(1, 34, true) --Key: A
    DisableControlAction(1, 35, true) --Key: D

    if IsDisabledControlJustReleased(1, 172) then --Key: Arrow U
        PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
    end

    if IsDisabledControlJustReleased(1, 173) then --Key: Arrow Down
        PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
    end

    if IsDisabledControlJustReleased(1, 176) then --Key: Enter
        PlaySoundFrontend(-1, "OK", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
    end

    if IsDisabledControlJustReleased(1, 177) then --Key: Backspace
        PlaySoundFrontend(-1, "NO", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
    end
end


local function isNear(pos1, pos2, distMustBe)
    local diff = pos2 - pos1
	local dist = (diff.x * diff.x) + (diff.y * diff.y)

	return (dist < (distMustBe * distMustBe))
end


function Draw3DText(x, y, z, str, r, g, b, a, font, scaleSize, enableProportional, enableCentre, enableOutline, enableShadow, sDist, sR, sG, sB, sA)
    local onScreen, worldX, worldY = World3dToScreen2d(x, y, z)
    local gameplayCamX, gameplayCamY, gameplayCamZ = table.unpack(GetGameplayCamCoords())

    if onScreen then
        SetTextScale(1.0, scaleSize)
        SetTextFont(font)
        SetTextColour(r, g, b, a)
        SetTextEdge(2, 0, 0, 0, 150)

        if enableProportional then
            SetTextProportional(1)
        end

        if enableOutline then
            SetTextOutline()
        end

        if enableShadow then
            SetTextDropshadow(sDist, sR, sG, sB, sA)
            SetTextDropShadow()
        end

        if enableCentre then
            SetTextCentre(1)
        end
        
        SetTextEntry("STRING")
        AddTextComponentString(str)
        DrawText(worldX, worldY)
    end
end


isPlyInBennys = false


--[[Citizen.CreateThread(function()
    while true do 
    	local plyPed = GetPlayerPed(-1)
    	local sleep = 200
        if IsPedInAnyVehicle(plyPed, false) then
            local plyPos = GetEntityCoords(plyPed)


	        nearDefault = #(plyPos - bennyLocation)
	        nearTuner = #(plyPos - bennyLocationTuner)

			if nearDefault <=10 then
				DrawMarker(1, bennyLocation.x, bennyLocation.y, bennyLocation.z - 1.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 5.0, 5.0, 1.5, 0,0,0, 255, false, true, 2, false, false, false, false)
	            if nearDefault <=5 then
	                if not isPlyInBennys then
	                    Draw3DText(bennyLocation.x, bennyLocation.y, bennyLocation.z + 0.5, "[Press ~p~E~w~ - Enter Benny's Motorworks]", 255, 255, 255, 255, 4, 0.45, true, true, true, true, 0, 0, 0, 0, 55)
	                else
	                    disableControls()
	                end
	            end
	            sleep = 1
	        end
        end
        Citizen.Wait(sleep)
    end
end)]]





function enterLocation(locationsPos, he)
    local plyPed = GetPlayerPed(-1)
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local isMotorcycle = false

    SetVehicleModKit(plyVeh, 0)
    FreezeEntityPosition(plyVeh, true)
    SetEntityCollision(plyVeh, true, true)
end


local inside = false
local currentpos = nil
local currentgarage = 0

local garages = { 
	[1] = { locked = false, camera = {x = -330.945, y = -135.471, z = 39.01, heading = 102.213}, driveout = {x = -350.376,y = -136.76, z = 38.294, heading = 70.226}, drivein = {x = -350.655,y = -136.55, z = 38.295, heading = 249.532}, outside = { x = -362.7962, y = -132.4005, z = 38.25239, heading = 71.187133}, inside = {x = -337.3863,y = -136.9247,z = 38.5737, heading = 269.455}},
	[2] = { locked = false, camera = {x = 737.09, y = -1085.721, z = 22.169, heading = 114.86}, driveout = {x = 725.46,y = -1088.822, z = 21.455, heading = 89.395}, drivein = {x = 726.157, y = -1088.768, z = 22.169, heading = 270.288}, outside = {x = 716.54,y = -1088.757, z = 21.651, heading = 89.248}, inside = {x = 733.69,y = -1088.74, z = 21.733, heading = 270.528}},
	[3] = { locked = false, camera = {x = -1154.902, y = -2011.438, z = 13.18, heading = 95.49}, driveout = {x = -1150.379,y = -1995.845, z = 12.465, heading = 313.594}, drivein = {x = -1150.26,y = -1995.642, z = 12.466, heading = 136.859}, outside = {x = -1140.352,y = -1985.89, z = 12.45, heading = 314.406}, inside = {x = -1155.077,y = -2006.61, z = 12.465, heading = 162.58}},
	[4] = { locked = false, camera = {x = 1177.98, y = 2636.059, z = 37.754, heading = 37.082}, driveout = {x = 1175.003,y = 2642.175, z = 37.045, heading = 0.759}, drivein = {x = 1174.701,y = 2643.764, z = 37.048, heading = 178.119}, outside = {x = 1175.565,y = 2652.819, z = 37.941, heading = 351.579}, inside = {x = 1174.823,y = 2637.807, z = 37.045, heading = 181.19}},
	[5] = { locked = false, camera = {x = 105.825, y = 6627.562, z = 31.787, heading = 266.692}, driveout = {x = 112.326,y = 6625.148, z = 31.073, heading = 224.641}, drivein = {x = 112.738,y = 6624.644, z = 31.072, heading = 44.262}, outside = {x = 118.493,y = 6618.897, z = 31.13, heading = 224.701}, inside = {x = 108.842,y = 6628.447, z = 31.072, heading = 45.504}},
	[6]= { locked = false, inside = {x = -212.368,y = -1325.486, z = 30.176, heading = 141.107} }
}

local Menu = SetMenu()
local myveh = {}

local gameplaycam = nil
local cam = nil

local function Notify(text)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(text)
	DrawNotification(false, false)
end

local function f(n)
	return (n + 0.00001)
end

local function LocalPed()
	return GetPlayerPed(-1)
end

local function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function myveh.repair()
	SetVehicleFixed(myveh.vehicle)
end

local function round(num, idp)
  if idp and idp>0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end

local function StartFade()
	Citizen.CreateThread(function()
		DoScreenFadeOut(0)
		while IsScreenFadingOut() do
			Citizen.Wait(0)
		end
	end)
end
local function EndFade()
	Citizen.CreateThread(function()
		ShutdownLoadingScreen()

        DoScreenFadeIn(500)

        while IsScreenFadingIn() do
            Citizen.Wait(0)
        end
	end)
end

--Setup main menu
local LSCMenu = Menu.new("Los Santos Customs","CATEGORIES", 0.16,0.13,0.24,0.36,0,{255,255,255,255})
LSCMenu.config.pcontrol = false

--Add mod to menu
local function AddMod(mod,parent,header,name,info,stock)
	local veh = myveh.vehicle
	SetVehicleModKit(veh,0)	
	if (GetNumVehicleMods(veh,mod) ~= nil and GetNumVehicleMods(veh,mod) > 0) or mod == 18 or mod == 22 then
		local m = parent:addSubMenu(header, name, info,true)
		if stock then
			local btn = m:addPurchase("Stock")
			btn.modtype = mod
			btn.mod = -1
		end
		if LSC_Config.prices.mods[mod].startprice then
			local price = LSC_Config.prices.mods[mod].startprice
			for i = 0,   tonumber(GetNumVehicleMods(veh,mod)) -1 do
				local lbl = GetModTextLabel(veh,mod,i)
				--if lbl ~= nil then
					local mname = tostring(GetLabelText(lbl))
					if mname ~= "NULL" then
						local btn = m:addPurchase(mname,price)
						btn.modtype = mod
						btn.mod = i
						price = price + LSC_Config.prices.mods[mod].increaseby
					else
						mname = 'Autre'
						local btn = m:addPurchase(mname,price)
						btn.modtype = mod
						btn.mod = i
						price = price + LSC_Config.prices.mods[mod].increaseby
					end
				--end
			end		
		else
			for n, v in pairs(LSC_Config.prices.mods[mod]) do
				btn = m:addPurchase(v.name,v.price)btn.modtype = mod
				btn.mod = v.mod
			end
		end
	end
end


--So we can actually enter it?
local function DriveInGarage()

	--Lock the garage
	TriggerServerEvent('lockGarage',true,currentgarage)

	-- local pos = currentpos
	local ped = LocalPed()
	local veh = GetVehiclePedIsUsing(ped)
	LSCMenu.buttons = {}
	isPlyInBennys = true


	if DoesEntityExist(veh) then
		--Set menu title
		if currentgarage == 4 or currentgarage == 5 then
			LSCMenu:setTitle("Beeker's Garage")
			LSCMenu.title_sprite = "shopui_title_carmod2"
		elseif currentgarage == 6 then
			LSCMenu:setTitle("Benny's Motorworks")
			LSCMenu.title_sprite = "shopui_title_supermod"
		else
			LSCMenu:setTitle("Benny's Motorworks")
			LSCMenu.title_sprite = "shopui_title_supermod"
		end
		
		-------------------------------Load some settings-----------------------------------
		
		--Controls
		LSCMenu.config.controls = LSC_Config.menu.controls
		SetIbuttons({
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_back, 0),"Back"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_select, 0),"Select"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_up, 0),"Up"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_down, 0),"Down"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_left, 0),"Left"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_right, 0),"Right"},
		 },0)
		 
		 --Max buttons
		LSCMenu:setMaxButtons(LSC_Config.menu.maxbuttons)
		
		--Width, height of menu
		LSCMenu.config.size.width = f(LSC_Config.menu.width) or 0.24;
		LSCMenu.config.size.height = f(LSC_Config.menu.height) or 0.36;
		
		--Position
		if type(LSC_Config.menu.position) == 'table' then
			LSCMenu.config.position = { x = LSC_Config.menu.position.x, y = LSC_Config.menu.position.y}
		elseif type(LSC_Config.menu.position) == 'string' then
			if LSC_Config.menu.position == "left" then
				LSCMenu.config.position = { x = 0.16, y = 0.13}
			elseif  LSC_Config.menu.position == "right" then
				LSCMenu.config.position = { x = 1-0.16, y = 0.13}
			end
		end
		
		--Theme
		if type(LSC_Config.menu.theme) == "table" then
			LSCMenu:setColors(LSC_Config.menu.theme.text_color,LSC_Config.menu.theme.stext_color,LSC_Config.menu.theme.bg_color,LSC_Config.menu.theme.sbg_color)
		elseif	type(LSC_Config.menu.theme) == "string" then
			if LSC_Config.menu.theme == "light" then
				--text_color,stext_color,bg_color,sbg_color
				LSCMenu:setColors({ r = 255,g = 255, b = 255, a = 255},{ r = 0,g = 0, b = 0, a = 255},{ r = 0,g = 0, b = 0, a = 155},{ r = 255,g = 255, b = 255, a = 255})
			elseif LSC_Config.menu.theme == "darkred" then
				LSCMenu:setColors({ r = 255,g = 255, b = 255, a = 255},{ r = 0,g = 0, b = 0, a = 255},{ r = 0,g = 0, b = 0, a = 155},{ r = 200,g = 15, b = 15, a = 200})
			elseif LSC_Config.menu.theme == "bluish" then	
				LSCMenu:setColors({ r = 255,g = 255, b = 255, a = 255},{ r = 255,g = 255, b = 255, a = 255},{ r = 0,g = 0, b = 0, a = 100},{ r = 0,g = 100, b = 255, a = 200})
			elseif LSC_Config.menu.theme == "greenish" then	
				LSCMenu:setColors({ r = 255,g = 255, b = 255, a = 255},{ r = 0,g = 0, b = 0, a = 255},{ r = 0,g = 0, b = 0, a = 100},{ r = 0,g = 200, b = 0, a = 200})
			end
		end
		
		LSCMenu:addSubMenu("CATEGORIES", "categories",nil, false)
		LSCMenu.categories.buttons = {}
		--Calculate price for vehicle repair and add repair  button
		local maxvehhp = 1000
		local damage = 0
		local cunt = GetVehicleBodyHealth(veh)
		local repairCost = math.ceil(1050 - cunt)
		LSCMenu:addPurchase("Repair vehicle",repairCost, "Full body repair and engine service.")
		
		--Setup table for vehicle with all mods, colors etc.
		SetVehicleModKit(veh,0)	
		myveh.vehicle = veh
		myveh.model = GetDisplayNameFromVehicleModel(GetEntityModel(veh)):lower()
		myveh.color =  table.pack(GetVehicleColours(veh))
		myveh.extracolor = table.pack(GetVehicleExtraColours(veh))
		myveh.neoncolor = table.pack(GetVehicleNeonLightsColour(veh))
		myveh.smokecolor = table.pack(GetVehicleTyreSmokeColor(veh))
		myveh.plateindex = GetVehicleNumberPlateTextIndex(veh)
		myveh.mods = {}
		for i = 0, 48 do
			myveh.mods[i] = {mod = nil}
		end
		for i,t in pairs(myveh.mods) do 
			if i == 22 or i == 18 then
				if IsToggleModOn(veh,i) then
				t.mod = 1
				else
				t.mod = 0
				end
			elseif i == 23 or i == 24 then
				t.mod = GetVehicleMod(veh,i)
				t.variation = GetVehicleModVariation(veh, i)
			else
				t.mod = GetVehicleMod(veh,i)
			end
		end
		if GetVehicleWindowTint(veh) == -1 or GetVehicleWindowTint(veh) == 0 then
			myveh.windowtint = false
		else
			myveh.windowtint = GetVehicleWindowTint(veh)
		end
		myveh.wheeltype = GetVehicleWheelType(veh)
		myveh.bulletProofTyres = GetVehicleTyresCanBurst(veh)
		
		--Menu stuff 
		local chassis,interior,bumper,fbumper,rbumper = false,false,false,false
		
		for i = 0,48 do
			if GetNumVehicleMods(veh,i) ~= nil and GetNumVehicleMods(veh,i) ~= false and GetNumVehicleMods(veh,i) > 0 then
				if i == 1 then
					bumper = true
					fbumper = true
				elseif i == 2 then
					bumper = true
					rbumper = true
				elseif (i >= 42 and i <= 46) or i == 5 then --If any chassis mod exist then add chassis menu
					chassis = true
				elseif i >= 27 and i <= 37 then --If any interior mod exist then add interior menu
					interior = true
				end
			end
		end
		
		AddMod(0,LSCMenu.categories,"SPOILER", "Spoiler", "Increase downforce.",true)
		AddMod(3,LSCMenu.categories,"SKIRTS", "Skirts", "Enhance your vehicle's look with custom side skirts.",true)
		AddMod(4,LSCMenu.categories,"EXHAUST", "Exhausts", "Customized sports exhausts.",true)
		AddMod(6,LSCMenu.categories,"GRILLE", "Grille", "Improved engine cooling.",true)
		AddMod(7,LSCMenu.categories,"HOOD", "Hood", "Enhance car engine cooling.",true)
		AddMod(8,LSCMenu.categories,"FENDERS", "Fenders", "Enhance body paneling with custom fenders.",true)
		--AddMod(10,LSCMenu.categories,"ROOF", "Roof", "Lower your center of gravity with lightweight roof panels.",true)
		AddMod(12,LSCMenu.categories,"BRAKES", "Brakes", "Increase stopping power and eliminate brake fade.",true)
		AddMod(13,LSCMenu.categories,"TRANSMISSION", "Transmission", "Improved acceleration with close ratio transmission.",true)
		AddMod(14,LSCMenu.categories,"HORN", "Horn", "Custom air horns.",true)
		AddMod(15,LSCMenu.categories,"SUSPENSION","Suspension","Upgrade to a sports oriented suspension setup.",true)
		AddMod(18, LSCMenu.categories, "TURBO", "Turbo", "Reduced lag turbocharger.",false)
		
		if chassis then
			LSCMenu.categories:addSubMenu("CHASSIS", "Chassis",nil, true)
			AddMod(42, LSCMenu.categories.Chassis, "ARCH COVER", "Arch cover", "",true) --headlight trim
			AddMod(43, LSCMenu.categories.Chassis, "AERIALS", "Aerials", "",true) --foglights
			AddMod(44, LSCMenu.categories.Chassis, "ROOF SCOOPS", "Roof Scoops", "",true) --roof scoops
			AddMod(45, LSCMenu.categories.Chassis, "Tank", "Tank", "",true)
			AddMod(46, LSCMenu.categories.Chassis, "DOORS", "Doors", "",true)-- windows
			AddMod(5,LSCMenu.categories.Chassis,"ROLL CAGE", "Roll cage", "Stiffen your chassis with a rollcage.",true)
		end
		
		LSCMenu.categories:addSubMenu("ENGINE", "Engine",nil, true)
		AddMod(39, LSCMenu.categories.Engine, "ENGINE BLOCK", "Engine Block", "Custom engine block casings.",true)
		AddMod(40, LSCMenu.categories.Engine, "CAM COVER", "Cam Cover", "Optional cam covers.",true)
		AddMod(41, LSCMenu.categories.Engine, "STRUT BRACE", "Strut Brace", "A selection of support struts.",true)
		AddMod(11,LSCMenu.categories.Engine,"ENGINE TUNES", "Engine Tunes", "Increases horsepower.",true)
		
		if interior then
			LSCMenu.categories:addSubMenu("INTERIOR", "Interior","Products for maximum style and comfort.", true)
			--LSCMenu.categories.Interior:addSubMenu("TRIM", "Trim","A selection of interior designs.", true)
			AddMod(27, LSCMenu.categories.Interior, "TRIM DESIGN", "Trim Design", "",true)
			--There are'nt any working natives that could change interior color :(
			--LSCMenu.categories.Interior.Trim:addSubMenu("TRIM COLOR", "Trim Color","", true)
			AddMod(28, LSCMenu.categories.Interior, "ORNAMENTS", "Ornaments", "Add decorative items to your dash.",true)
			AddMod(29, LSCMenu.categories.Interior, "DASHBOARD", "Dashboard", "Custom control panel designs.",true)
			AddMod(30, LSCMenu.categories.Interior, "DIAL DESIGN", "Dials", "Customize the look of your dials.",true)
			AddMod(31, LSCMenu.categories.Interior, "DOORS", "Doors", "Install door upgrades.",true)
			AddMod(32, LSCMenu.categories.Interior, "SEATS", "Seats", "Options where style meets comfort.",true)
			AddMod(33, LSCMenu.categories.Interior, "STEERING WHEELS", "Steering Wheels", "Customize the link between you and your vehicle.",true)
			AddMod(34, LSCMenu.categories.Interior, "Shifter leavers", "Shifter leavers", "",true)
			AddMod(35, LSCMenu.categories.Interior, "Plaques", "Plaques", "",true)
			AddMod(36, LSCMenu.categories.Interior, "Speakers", "Speakers", "",true)
			AddMod(37, LSCMenu.categories.Interior, "Trunk", "Trunk", "",true)
		end
		
		LSCMenu.categories:addSubMenu("PLATES", "Plates","Decorative identification.", true)
		LSCMenu.categories.Plates:addSubMenu("LICENSE", "License", "",true)
		for n, mod in pairs(LSC_Config.prices.plates) do
			local btn = LSCMenu.categories.Plates.License:addPurchase(mod.name,mod.price)btn.plateindex = mod.plateindex
		end
		--Customize license plates
		AddMod(25, LSCMenu.categories.Plates, "Plate holder", "Plate holder", "",true) --
		AddMod(26, LSCMenu.categories.Plates, "Vanity plates", "Vanity plates", "",true) --
		--AddMod(47, LSCMenu.categories, "UNK47", "unk47", "",true)
		--AddMod(49, LSCMenu.categories, "UNK49", "unk49", "",true)
		AddMod(38,LSCMenu.categories,"HYDRAULICS","Hydraulics","",true)
		AddMod(48,LSCMenu.categories,"Liveries", "Liveries", "A selection of decals for your vehicle.",true)
		
		if bumper then
			LSCMenu.categories:addSubMenu("BUMPERS", "Bumpers", "Custom front and rear bumpers.",true)
			if fbumper then
				AddMod(1,LSCMenu.categories.Bumpers,"FRONT BUMPERS", "Front bumpers", "Custom front bumpers.",true)
			end
			if rbumper then
				AddMod(2,LSCMenu.categories.Bumpers,"REAR BUMPERS", "Rear bumpers", "Custom rear bumpers.",true)
			end
		end
		
		local m = LSCMenu.categories:addSubMenu("LIGHTS", "Lights", "Improved night time visibility.",true)
		AddMod(22,LSCMenu.categories.Lights,"HEADLIGHTS", "Headlights", nil, false)
		if not IsThisModelABike(GetEntityModel(veh)) then
			m = m:addSubMenu("NEON KITS", "Neon kits", nil, true)
				m:addSubMenu("NEON LAYOUT", "Neon layout", nil, true)
					local btn = m["Neon layout"]:addPurchase("None")
					for n, mod in pairs(LSC_Config.prices.neonlayout) do
						local btn = m["Neon layout"]:addPurchase(mod.name,mod.price)
					end
			
			m = m:addSubMenu("NEON COLOR", "Neon color", nil, true)
				for n, mod in pairs(LSC_Config.prices.neoncolor) do
					local btn = m:addPurchase(mod.name,mod.price)btn.neon = mod.neon
				end
		end

		
		respray = LSCMenu.categories:addSubMenu("RESPRAY", "Respray", "Transforms vehicle appearance.",true)
			pcol = respray:addSubMenu("PRIMARY COLORS", "Primary color",  nil,true)
				pcol:addSubMenu("CHROME", "Chrome", nil,true)
				for n, c in pairs(LSC_Config.prices.chrome.colors) do
					local btn = pcol.Chrome:addPurchase(c.name,LSC_Config.prices.chrome.price)btn.colorindex = c.colorindex
					if btn.colorindex == myveh.color[1] then
						btn.purchased = true
					end
				end
				pcol:addSubMenu("CLASSIC", "Classic", nil,true)
				for n, c in pairs(LSC_Config.prices.classic.colors) do
					local btn = pcol.Classic:addPurchase(c.name,LSC_Config.prices.classic.price)btn.colorindex = c.colorindex
					if btn.colorindex == myveh.color[1] then
						btn.purchased = true
					end
				end
				pcol:addSubMenu("MATTE", "Matte", nil,true)
				for n, c in pairs(LSC_Config.prices.matte.colors) do
					local btn = pcol.Matte:addPurchase(c.name,LSC_Config.prices.matte.price)btn.colorindex = c.colorindex
					if btn.colorindex == myveh.color[1] then
						btn.purchased = true
					end
				end
				pcol:addSubMenu("METALLIC", "Metallic", nil,true)
				for n, c in pairs(LSC_Config.prices.metallic.colors) do
					local btn = pcol.Metallic:addPurchase(c.name,LSC_Config.prices.metallic.price)btn.colorindex = c.colorindex
					if btn.colorindex == myveh.color[1] and myveh.extracolor[1] == myveh.color[2] then
						btn.purchased = true
					end
				end
				pcol:addSubMenu("METALS", "Metals", nil,true)
				for n, c in pairs(LSC_Config.prices.metal.colors) do
					local btn = pcol.Metals:addPurchase(c.name,LSC_Config.prices.metal.price)btn.colorindex = c.colorindex
					if btn.colorindex == myveh.color[1] then
						btn.purchased = true
					end
				end
			scol = respray:addSubMenu("SECONDARY COLORS", "Secondary color", nil,true)
				scol:addSubMenu("CHROME", "Chrome", nil,true)
				for n, c in pairs(LSC_Config.prices.chrome2.colors) do
					local btn = scol.Chrome:addPurchase(c.name,LSC_Config.prices.chrome2.price)btn.colorindex = c.colorindex
					if btn.colorindex == myveh.color[2] then
						btn.purchased = true
					end
				end
				scol:addSubMenu("CLASSIC", "Classic", nil,true)
				for n, c in pairs(LSC_Config.prices.classic2.colors) do
					local btn = scol.Classic:addPurchase(c.name,LSC_Config.prices.classic2.price)btn.colorindex = c.colorindex
					if btn.colorindex == myveh.color[2] then
						btn.purchased = true
					end
				end
				scol:addSubMenu("MATTE", "Matte", nil,true)
				for n, c in pairs(LSC_Config.prices.chrome2.colors) do
					local btn = scol.Matte:addPurchase(c.name,LSC_Config.prices.matte2.price)btn.colorindex = c.colorindex
					if btn.colorindex == myveh.color[2] then
						btn.purchased = true
					end
				end
				scol:addSubMenu("METALLIC", "Metallic", nil,true)
				for n, c in pairs(LSC_Config.prices.metallic2.colors) do
					local btn = scol.Metallic:addPurchase(c.name,LSC_Config.prices.metallic2.price)btn.colorindex = c.colorindex
					if btn.colorindex == myveh.color[2] and myveh.extracolor[1] == btn.colorindex then
						btn.purchased = true
					end
				end
				scol:addSubMenu("METALS", "Metals", nil,true)
				for n, c in pairs(LSC_Config.prices.metal2.colors) do
					local btn = scol.Metals:addPurchase(c.name,LSC_Config.prices.metal2.price)btn.colorindex = c.colorindex
					if btn.colorindex == myveh.color[2] then
						btn.purchased = true
					end
				end
		
		
		LSCMenu.categories:addSubMenu("WHEELS", "Wheels", "Custom rims, tires and colors.",true)
			wtype = LSCMenu.categories.Wheels:addSubMenu("WHEEL TYPE", "Wheel type", "Custom rims in all styles and sizes.",true)
				if IsThisModelABike(GetEntityModel(veh)) then
					fwheels = wtype:addSubMenu("FRONT WHEEL", "Front wheel", nil,true)
						for n, w in pairs(LSC_Config.prices.frontwheel) do
							btn = fwheels:addPurchase(w.name,w.price)btn.wtype = w.wtype btn.modtype = 23 btn.mod = w.mod
						end
					bwheels = wtype:addSubMenu("BACK WHEEL", "Back wheel", nil,true)
						for n, w in pairs(LSC_Config.prices.backwheel) do
							btn = bwheels:addPurchase(w.name,w.price)btn.wtype = w.wtype btn.modtype = 24 btn.mod = w.mod
						end
				else
					sportw = wtype:addSubMenu("SPORT WHEELS", "Sport", nil,true)
						for n, w in pairs(LSC_Config.prices.sportwheels) do
							local btn = sportw:addPurchase(w.name,w.price)btn.wtype = w.wtype btn.modtype = 23 btn.mod = w.mod
						end
					musclew = wtype:addSubMenu("MUSCLE WHEELS", "Muscle", nil,true)
						for n, w in pairs(LSC_Config.prices.musclewheels) do
							local btn = musclew:addPurchase(w.name,w.price)btn.wtype =  w.wtype btn.modtype = 23 btn.mod = w.mod
						end
					lowriderw = wtype:addSubMenu("LOWRIDER WHEELS", "Lowrider", nil,true)
						for n, w in pairs(LSC_Config.prices.lowriderwheels) do
							local btn = lowriderw:addPurchase(w.name,w.price)btn.wtype =  w.wtype btn.modtype = 23 btn.mod = w.mod
						end
					suvw = wtype:addSubMenu("SUV WHEELS", "Suv", nil,true)
						for n, w in pairs(LSC_Config.prices.suvwheels) do
							local btn = suvw:addPurchase(w.name,w.price)btn.wtype = w.wtype btn.modtype = 23 btn.mod = w.mod
						end
					offroadw = wtype:addSubMenu("OFFROAD WHEELS", "Offroad", nil,true)
						for n, w in pairs(LSC_Config.prices.offroadwheels) do
							local btn = offroadw:addPurchase(w.name,w.price)btn.wtype = w.wtype btn.modtype = 23 btn.mod = w.mod
						end
					tunerw = wtype:addSubMenu("TUNER WHEELS", "Tuner", nil,true)
						for n, w in pairs(LSC_Config.prices.tunerwheels) do
							local btn = tunerw:addPurchase(w.name,w.price)btn.wtype = w.wtype btn.modtype = 23 btn.mod = w.mod
						end
					hughendw = wtype:addSubMenu("HIGHEND WHEELS", "Highend", nil,true)
						for n, w in pairs(LSC_Config.prices.highendwheels) do
							local btn = hughendw:addPurchase(w.name,w.price)btn.wtype = w.wtype btn.modtype = 23 btn.mod = w.mod
						end
				end
					
		m = LSCMenu.categories.Wheels:addSubMenu("WHEEL COLOR", "Wheel color", "Custom wheel colors.",true)
			for n, c in pairs(LSC_Config.prices.wheelcolor.colors) do
				local btn = m:addPurchase(c.name,LSC_Config.prices.wheelcolor.price)btn.colorindex = c.colorindex
			end
		
		m = LSCMenu.categories.Wheels:addSubMenu("WHEEL ACCESSORIES", "Wheel accessories", "Bulletproof tires and custom burnout smoke.",true)
			for n, mod in pairs(LSC_Config.prices.wheelaccessories) do
				local btn = m:addPurchase(mod.name,mod.price)btn.smokecolor = mod.smokecolor
			end
		
		m = LSCMenu.categories:addSubMenu("WINDOWS", "Windows", "A selection of tinted windows.",true)	
			btn = m:addPurchase("None")btn.tint = false
			for n, tint in pairs(LSC_Config.prices.windowtint) do
				btn = m:addPurchase(tint.name,tint.price)btn.tint = tint.tint
			end
					
		Citizen.CreateThread(function()
			SetVehRadioStation(veh, 255)
			

			if IsVehicleDamaged(veh) then
				LSCMenu:Open("main")
			else
				LSCMenu:Open("categories")
			end
			
		end)
	end
end


--Get the length of table
local function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

--Check if table contains value
local function tableContains(t,val)
	for k,v in pairs(t) do
		if v == val then
			return true
		end
	end
	return false
end

--Magical loop that allows you to  drive in garage if you successfully go through checks

returnclosest = function()
	local coords, heading, dist = vector3(0,0,0), 0.0, 10000.0
	for i = 1, #bennyLocation do
		if #(GetEntityCoords(PlayerPedId())-bennyLocation[i].coords) < #(GetEntityCoords(PlayerPedId())-coords) then
			coords, heading, dist = bennyLocation[i].coords, bennyLocation[i].heading, #(GetEntityCoords(PlayerPedId())-bennyLocation[i].coords)
		end
	end
	return coords, heading, dist
end

Citizen.CreateThread(function()
	while true do
		local playerPed = GetPlayerPed(-1)
		local sleep = 200

		if IsPedInAnyVehicle(playerPed, false) then
			local plyPos = GetEntityCoords(playerPed)

			coords, heading, nearDefault = returnclosest()
			if nearDefault <= 7.5 and coords ~= vector3(0,0,0) then
			    if IsControlJustReleased(0, 38) then
			        enterLocation(coords, heading)
			        DriveInGarage(6)
			    end
			    sleep = 5
			end
			
			if nearDefault <=15 and coords ~= vector3(0,0,0) then
				DrawMarker(1, coords.x, coords.y, coords.z - 1.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 7.5, 7.5, 1.5, 0,0,0, 255, false, true, 2, false, false, false, false)
	            if nearDefault <=7.5 then
	                if not isPlyInBennys then
	                    Draw3DText(coords.x, coords.y, coords.z + 0.5, "[Press ~b~E~w~ - Enter Benny's Motorworks]", 255, 255, 255, 255, 4, 0.45, true, true, true, true, 0, 0, 0, 0, 55)
	                else
	                    disableControls()
	                end
	            end
	            sleep = 1
	        end
			 
			--if nearTuner <= 2 then
			    --if IsControlJustReleased(0, 38) then
					--enterLocation(bennyLocationTuner)
					--DriveInGarage(6)
			    --end
			    --sleep = 5
			--end
			            
		end	
		Citizen.Wait(sleep)
	end
end)




--Lets drive out of the garage 
function LSCMenu:OnMenuClose(m)
	local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
	FreezeEntityPosition(plyVeh, false)
	isPlyInBennys = false
	SetEntityCollision(plyVeh, true, true)
	-- DriveOutOfGarage(currentpos.outside)
end

function LSCMenu:onSelectedIndexChanged(name, button)
	name = name:lower()
	local m = LSCMenu.currentmenu
	local price = button.price or 0
	local veh = myveh.vehicle
	p = m.parent or self.name
	if m == "main" then
		m = self
	end
	CheckPurchases(m)
	m = m.name:lower()
	p = p:lower()
	--set up temporary shitt, or in other words show preview of selected mod
	if m == "chrome" or m ==  "classic" or m ==  "matte" or m ==  "metals" then
		if p == "primary color" then
			SetVehicleColours(veh,button.colorindex,myveh.color[2])
		else
			SetVehicleColours(veh,myveh.color[1],button.colorindex)	
		end
		
	elseif m == "metallic" then
		if p == "primary color" then
			SetVehicleColours(veh,button.colorindex,myveh.color[2])
			SetVehicleExtraColours(veh, myveh.color[2], myveh.extracolor[2])
		else
			SetVehicleColours(veh,myveh.color[1],button.colorindex)
			SetVehicleExtraColours(veh, button.colorindex, myveh.extracolor[2])				
		end
	elseif m == "wheel color" then
		SetVehicleExtraColours(veh,myveh.extracolor[1], button.colorindex)
	elseif button.modtype and button.mod then
		if button.modtype ~= 18 and button.modtype ~= 22 then
			if button.wtype then
				SetVehicleWheelType(veh,button.wtype)
			end
			SetVehicleMod(veh,button.modtype, button.mod)	
		elseif button.modtype == 22 then
			ToggleVehicleMod(veh,button.modtype, button.mod)
		elseif button.modtype == 18 then
		end
	elseif m == "license" then
		SetVehicleNumberPlateTextIndex(veh,button.plateindex)
	elseif m == "neon color" then
		SetVehicleNeonLightsColour(veh,button.neon[1], button.neon[2], button.neon[3])
	elseif m == "windows" then
		SetVehicleWindowTint(veh, button.tint)
	else
	end
	if m == "horn" then
		--Maybe some way of playing the horn?
		OverrideVehHorn(veh,false,0)
		if IsHornActive(veh) or IsControlPressed(1,86) then
			StartVehicleHorn(veh, 10000, "HELDDOWN", 1)
		end
	end
end
--Didnt even need to use this 
function LSCMenu:OnMenuOpen(menu)

end

function LSCMenu:onButtonSelected(name, button)
	--Send the selected button to server
	TriggerServerEvent("LSC:buttonSelected", name, button)
end

--So we get the button back from server +  bool that determines if we can prchase specific item or not
RegisterNetEvent("LSC:buttonSelected")
AddEventHandler("LSC:buttonSelected", function(name, button, canpurchase)
	name = name:lower()
	local m = LSCMenu.currentmenu
	local price = button.price or 0
	local veh = myveh.vehicle
	if m == "main" then
		m = LSCMenu
	end
	
	mname = m.name:lower()
	--Bunch of button shitt, that gets executed if button is selected + goes through checks
	if mname == "chrome" or mname ==  "classic" or mname ==  "matte" or mname ==  "metals" then
		if m.parent == "Primary color" then
			if button.name == "Stock" or button.purchased or CanPurchase(price, canpurchase) then
				myveh.color[1] = button.colorindex
			end
		else
			if button.name == "Stock" or button.purchased or CanPurchase(price, canpurchase) then
				myveh.color[2] = button.colorindex
			end
		end
	elseif mname == "metallic" then
		if m.parent == "Primary color" then
			if button.name == "Stock" or button.purchased or CanPurchase(price, canpurchase)then
				myveh.color[1] = button.colorindex
				myveh.extracolor[1] = myveh.color[2]
			end
		else
			if button.name == "Stock" or button.purchased or CanPurchase(price, canpurchase)then
				myveh.extracolor[1] = button.colorindex
				myveh.color[2] = button.colorindex
			end
		end	
	elseif mname == "liveries" or mname == "hydraulics" or mname == "horn" or mname == "tank" or mname == "ornaments" or  mname == "arch cover" or mname == "aerials" or mname == "roof scoops" or mname == "doors" or mname == "roll cage" or mname == "engine block" or mname == "cam cover" or mname == "strut brace" or mname == "trim design" or mname == "ormnametns" or mname == "dashboard" or mname == "dials" or mname == "seats" or mname == "steering wheels" or mname == "plate holder" or mname == "vanity plates" or mname == "shifter leavers" or mname == "plaques" or mname == "speakers" or mname == "trunk" or mname == "armor" or mname == "suspension" or mname == "transmission" or mname == "brakes" or mname == "engine tunes" or mname == "roof" or mname == "hood" or mname == "grille" or mname == "roll cage" or mname == "exhausts" or mname == "skirts" or mname == "rear bumpers" or mname == "front bumpers" or mname == "spoiler" then
		if button.name == "Stock" or button.purchased or CanPurchase(price, canpurchase)then
			myveh.mods[button.modtype].mod = button.mod
			SetVehicleMod(veh,button.modtype,button.mod)
		end
	elseif mname == "fenders" then
		if button.name == "Stock" or button.purchased or CanPurchase(price, canpurchase)then
			if button.name == "Stock" then
				myveh.mods[8].mod = button.mod
				myveh.mods[9].mod = button.mod
				SetVehicleMod(veh,9,button.mod)
				SetVehicleMod(veh,8,button.mod)
			else
				myveh.mods[button.modtype].mod = button.mod
				SetVehicleMod(veh,button.modtype,button.mod)
			end
		end
	elseif mname == "turbo" or mname == "headlights" then
		if button.name == "None" or button.name == "Stock Lights" or button.purchased or CanPurchase(price, canpurchase) then
			myveh.mods[button.modtype].mod = button.mod
			ToggleVehicleMod(veh, button.modtype, button.mod)
		end
	elseif mname == "neon layout" then
		if button.name == "None"  then
			SetVehicleNeonLightEnabled(veh,0,false)
			SetVehicleNeonLightEnabled(veh,1,false)
			SetVehicleNeonLightEnabled(veh,2,false)
			SetVehicleNeonLightEnabled(veh,3,false)
			myveh.neoncolor[1] = 255
			myveh.neoncolor[2] = 255
			myveh.neoncolor[3] = 255
			SetVehicleNeonLightsColour(veh,255,255,255)
		elseif button.purchased or CanPurchase(price, canpurchase) then
			if not myveh.neoncolor[1] then
				myveh.neoncolor[1] = 255
				myveh.neoncolor[2] = 255
				myveh.neoncolor[3] = 255
			end
			SetVehicleNeonLightsColour(veh,myveh.neoncolor[1],myveh.neoncolor[2],myveh.neoncolor[3])
			SetVehicleNeonLightEnabled(veh,0,true)
			SetVehicleNeonLightEnabled(veh,1,true)
			SetVehicleNeonLightEnabled(veh,2,true)
			SetVehicleNeonLightEnabled(veh,3,true)
		end
	elseif mname == "neon color" then
		if button.purchased or CanPurchase(price, canpurchase) then
			myveh.neoncolor[1] = button.neon[1]
			myveh.neoncolor[2] = button.neon[2]
			myveh.neoncolor[3] = button.neon[3]
			SetVehicleNeonLightsColour(veh,button.neon[1],button.neon[2],button.neon[3])
		end
	elseif mname == "windows" then
		if button.name == "None" or button.purchased or CanPurchase(price, canpurchase) then
			myveh.windowtint = button.tint
			SetVehicleWindowTint(veh, button.tint)
		end
	elseif mname == "sport" or mname == "muscle" or mname == "lowrider" or mname == "back wheel" or mname == "front wheel" or mname == "highend" or mname == "suv" or mname == "offroad" or mname == "tuner" then
		if button.purchased or CanPurchase(price, canpurchase) then
			myveh.wheeltype = button.wtype
			myveh.mods[button.modtype].mod = button.mod
			SetVehicleWheelType(veh,button.wtype)
			SetVehicleMod(veh,button.modtype,button.mod)
		end
	elseif mname == "wheel color" then
		if button.purchased or CanPurchase(price, canpurchase) then
			myveh.extracolor[2] = button.colorindex
			SetVehicleExtraColours(veh, myveh.extracolor[1], button.colorindex)
		end
	elseif mname == "wheel accessories" then
		if button.name == "Stock Tires" then
			SetVehicleModKit(veh,0)
			SetVehicleMod(veh,23,myveh.mods[23].mod,false)
			myveh.mods[23].variation = false
			if IsThisModelABike(GetEntityModel(veh)) then
				SetVehicleModKit(veh,0)
				SetVehicleMod(veh,24,myveh.mods[24].mod,false)
				myveh.mods[24].variation = false
			end
		elseif button.name == "Custom Tires" and  (button.purchased or CanPurchase(price, canpurchase)) then
			SetVehicleModKit(veh,0)
			SetVehicleMod(veh,23,myveh.mods[23].mod,true)
			myveh.mods[23].variation = true
			if IsThisModelABike(GetEntityModel(veh)) then
				SetVehicleModKit(veh,0)
				SetVehicleMod(veh,24,myveh.mods[24].mod,true)
				myveh.mods[24].variation = true
			end
		elseif button.name == "Bulletproof Tires" and  (button.purchased or CanPurchase(price, canpurchase)) then
			if GetVehicleTyresCanBurst(myveh.vehicle) then
				myveh.bulletProofTyres = false
				SetVehicleTyresCanBurst(veh,false)
			else
				myveh.bulletProofTyres = true
				SetVehicleTyresCanBurst(veh,true)
			end
		elseif button.smokecolor ~= nil  and  (button.purchased or CanPurchase(price, canpurchase)) then
			SetVehicleModKit(veh,0)
			myveh.mods[20].mod = true
			ToggleVehicleMod(veh,20,true)
			myveh.smokecolor = button.smokecolor
			SetVehicleTyreSmokeColor(veh,button.smokecolor[1],button.smokecolor[2],button.smokecolor[3])
		end
	elseif mname == "license" then
		if button.purchased or CanPurchase(price, canpurchase) then
			myveh.plateindex = button.plateindex
			SetVehicleNumberPlateTextIndex(veh,button.plateindex)
		end
	elseif mname == "main" then
		if name == "repair vehicle" then
			if CanPurchase(price, canpurchase) then 
				myveh.repair()
				LSCMenu:ChangeMenu("categories")
			end
		end
	end
	CheckPurchases(m)
end)



function LSCMenu:OnMenuChange(last,current)
	UnfakeVeh()
	if last == "main" then
		last = self
	end
	if last.name == "categories" and current.name == "main" then
		LSCMenu:Close()
	end	
	c = current.name:lower()
	--Camera,door stuff 
	if c == "front bumpers" then
		-- MoveVehCam('front',-0.6,1.5,0.4)
	elseif  c == "rear bumpers" then
		-- MoveVehCam('back',-0.5,-1.5,0.2)
	elseif c == "Engine Tunes" then
		--PointCamAtBone('engine',0,-1.5,1.5)
	elseif c == "exhausts" then
		--PointCamAtBone("exhaust",0,-1.5,0)
	elseif c == "hood" then
		-- MoveVehCam('front-top',-0.5,1.3,1.0)
	elseif c == "headlights" then
		-- MoveVehCam('front',-0.6,1.3,0.6)
	elseif c == "license" or c == "plate holder" then
		-- MoveVehCam('back',0,-1,0.2)
	elseif c == "vanity plates" then
		-- MoveVehCam('front',-0.3,0.8,0.3)
	elseif c == "roof" then
		--MoveVehCam('middle',-1.2,2,1.5)
	elseif c == "fenders" then
		-- MoveVehCam('left',-1.8,-1.3,0.7)
	elseif c == "grille" then
		--MoveVehCam('front',-0.3,0.8,0.6)
	elseif c == "skirts" then
		-- MoveVehCam('left',-1.8,-1.3,0.7)
	elseif c == "spoiler" then
		-- MoveVehCam('back',0.5,-1.6,1.3)
	elseif c == "back wheel" then
		-- PointCamAtBone("wheel_lr",-1.4,0,0.3)
	elseif c == "front wheel" or c == "wheel accessories" or  c == "wheel color" or c == "sport" or c == "muscle" or c == "lowrider"  or c == "highend" or c == "suv" or c == "offroad" or c == "tuner" then
		-- PointCamAtBone("wheel_lf",-1.4,0,0.3)
	--[[elseif c == "windows" then
		if not IsThisModelABike(GetEntityModel(myveh.vehicle)) then
		PointCamAtBone("window_lf",-2.0,0,0.3)
		end]]
	elseif c == "neon color" then
		-- PointCamAtBone("neon_l",-2.0,2.0,0.4)
	elseif c == "shifter leavers" or c == "trim design" or c == "ornaments" or c == "dashboard" or c == "dials" or c == "seats" or c =="steering wheels" then
		--Set view mode to first person
		SetFollowVehicleCamViewMode(4)
	elseif c == "doors" and last.name:lower() == "interior" then
		--Open both front doors
		SetVehicleDoorOpen(myveh.vehicle, 0, 0, 0)
		SetVehicleDoorOpen(myveh.vehicle, 1, 0, 0)
	elseif c == "trunk" then
		--- doorIndex:
		-- 0 = Front Left Door
		-- 1 = Front Right Door
		-- 2 = Back Left Door
		-- 3 = Back Right Door
		-- 4 = Hood
		-- 5 = Trunk
		-- 6 = Back
		-- 7 = Back2
		SetVehicleDoorOpen(myveh.vehicle, 5, 0, 0)
	elseif c == "speakers" or  c == "engine block" or c == "air filter" or c == "strut brace" or c == "cam cover" then
		--Open hood and trunk
		SetVehicleDoorOpen(myveh.vehicle, 5, 0, 0)
		SetVehicleDoorOpen(myveh.vehicle, 4, 0, 0)
	elseif IsCamActive(cam) then
		--Go back to gameplaycam
		SetCamCoord(cam,GetGameplayCamCoords())
		SetCamRot(cam, GetGameplayCamRot(2), 2)
		RenderScriptCams( 1, 1, 0, 0, 0)
		RenderScriptCams( 0, 1, 1000, 0, 0)
		SetCamActive(gameplaycam, true)
		EnableGameplayCam(true)
		SetCamActive(cam, false)
		SetIbuttons({
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_back, 0),"Back"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_select, 0),"Select"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_up, 0),"Up"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_down, 0),"Down"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_left, 0),"Left"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_right, 0),"Right"}
		},0)
	else
		--Close all doors
		SetVehicleDoorShut(myveh.vehicle, 0, 0)
		SetVehicleDoorShut(myveh.vehicle, 1, 0)
		SetVehicleDoorShut(myveh.vehicle, 4, 0)
		SetVehicleDoorShut(myveh.vehicle, 5, 0)
		SetFollowVehicleCamViewMode(0)
	end
end


--Bunch of checks
function CheckPurchases(m)
	name = m.name:lower()
	if name == "chrome" or name ==  "classic" or name ==  "matte" or name ==  "metals" then
		if m.parent == "Primary color" then
			for i,b in pairs(m.buttons) do
				if b.purchased and b.colorindex ~= myveh.color[1] then
					if b.purchased ~= nil then b.purchased = false end
					b.sprite = nil
				elseif b.purchased == false and b.colorindex == myveh.color[1] then
					if b.purchased ~= nil then b.purchased = true end
					b.sprite = "garage"
				end
			end
		else
			for i,b in pairs(m.buttons) do
				if b.purchased and (b.colorindex ~= myveh.color[1] or myveh.extracolor[1] ~= myveh.color[2]) then
					if b.purchased ~= nil then b.purchased = false end
					b.sprite = nil
				elseif b.purchased == false and b.colorindex == myveh.color[1] and myveh.extracolor[1] == myveh.color[2] then
					if b.purchased ~= nil then b.purchased = true end
					b.sprite = "garage"
				end
			end
		end
	elseif name == "metallic" then
		if m.parent == "Primary color" then
			for i,b in pairs(m.buttons) do
				if b.purchased and b.colorindex ~= myveh.color[1] then
					if b.purchased ~= nil then b.purchased = false end
					b.sprite = nil
				elseif b.purchased == false and b.colorindex == myveh.color[1] then
					if b.purchased ~= nil then b.purchased = true end
					b.sprite = "garage"
				end
			end
		else
			for i,b in pairs(m.buttons) do
				if b.purchased and (b.colorindex ~= myveh.color[2] or myveh.extracolor[1] ~= b.colorindex) then
					if b.purchased ~= nil then b.purchased = false end
					b.sprite = nil
				elseif b.purchased == false and b.colorindex == myveh.color[2] and myveh.extracolor[1] == b.colorindex then
					if b.purchased ~= nil then b.purchased = true end
					b.sprite = "garage"
				end
			end
		end
	elseif name == "armor" or name == "suspension" or name == "transmission" or name == "brakes" or name == "engine tunes" or name == "roof" or name == "fenders" or name == "hood" or name == "grille" or name == "roll cage" or name == "exhausts" or name == "skirts" or name == "rear bumpers" or name == "front bumpers" or name == "spoiler" then
		for i,b in pairs(m.buttons) do
			if b.mod == -1  then
				if myveh.mods[b.modtype].mod == -1 then
					if b.purchased ~= nil then b.purchased = true end
					b.sprite = "garage"
				else
					if b.purchased ~= nil then b.purchased = false end
					b.sprite = nil
				end
			elseif b.mod == 0 or b.mod == false then
				if myveh.mods[b.modtype].mod == false or myveh.mods[b.modtype].mod == 0 then
					if b.purchased ~= nil then b.purchased = true end
					b.sprite = "garage"
				else
					if b.purchased ~= nil then b.purchased = false end
					b.sprite = nil
				end
			else
				if myveh.mods[b.modtype].mod == b.mod then
					if b.purchased ~= nil then b.purchased = true end
					b.sprite = "garage"
				else
					if b.purchased ~= nil then b.purchased = false end
					b.sprite = nil
				end
			end
		end
	elseif name == "neon layout" then
		for i,b in pairs(m.buttons) do
			if b.name == "None" then
				if IsVehicleNeonLightEnabled(myveh.vehicle, 0) == false and IsVehicleNeonLightEnabled(myveh.vehicle, 1) == false  and IsVehicleNeonLightEnabled(myveh.vehicle, 2) == false and IsVehicleNeonLightEnabled(myveh.vehicle, 3) == false then
					b.sprite = "garage"
				else
					b.sprite =  nil
				end
			elseif b.name == "Front,Back and Sides" then
				if IsVehicleNeonLightEnabled(myveh.vehicle, 0)  and IsVehicleNeonLightEnabled(myveh.vehicle, 1)  and IsVehicleNeonLightEnabled(myveh.vehicle, 2)  and IsVehicleNeonLightEnabled(myveh.vehicle, 3)  then
					b.sprite = "garage"
				else
					b.sprite =  nil
				end
			end		
		end
	elseif name == "neon color" then
		for i,b in pairs(m.buttons) do
			if b.neon[1] == myveh.neoncolor[1] and b.neon[2] == myveh.neoncolor[2] and b.neon[3] == myveh.neoncolor[3] then
				b.sprite = "garage"
			else
				b.sprite = nil
			end
		end
	elseif name == "windows" then
		for i,b in pairs(m.buttons) do
			if myveh.windowtint == b.tint then
				b.sprite = "garage"
			else
				b.sprite = nil
			end
		end
	elseif name == "sport" or name == "muscle" or name == "lowrider" or name == "back wheel" or name == "front wheel" or name == "highend" or name == "suv" or name == "offroad" or name == "tuner" then
		for i,b in pairs(m.buttons) do
			if myveh.mods[b.modtype].mod == b.mod and myveh.wheeltype == b.wtype then
				b.sprite = "garage"
			else
				b.sprite = nil
			end
		end
	elseif name == "wheel color" then
		for i,b in pairs(m.buttons) do
			if b.colorindex == myveh.extracolor[2] then
				b.sprite = "garage"
			else
				b.sprite = nil
			end
		end
	elseif name == "wheel accessories" then
		for i,b in pairs(m.buttons) do
			if b.name == "Stock Tires" then
				if GetVehicleModVariation(myveh.vehicle,23) == false then
					b.sprite = "garage"
				else
					b.sprite = nil
				end
			elseif b.name == "Custom Tires" then
				if GetVehicleModVariation(myveh.vehicle,23) then
					b.sprite = "garage"
				else
					b.sprite = nil
				end
			elseif b.name == "Bulletproof Tires" then
				if GetVehicleTyresCanBurst(myveh.vehicle) == false then
					b.sprite = "garage"
				else
					b.sprite = nil
				end
			elseif b.smokecolor ~= nil then
				local col = table.pack(GetVehicleTyreSmokeColor(myveh.vehicle))
				if col[1] == b.smokecolor[1] and col[2] == b.smokecolor[2] and col[3] == b.smokecolor[3] then
					b.sprite = "garage"
				else
					b.sprite = nil
				end
			end
		end
	elseif name == "license" then
		for i,b in pairs(m.buttons) do
			if myveh.plateindex == b.plateindex then
				b.sprite = "garage"
			else
				b.sprite = nil
			end
		end
	elseif name == "tank" or name == "ornaments" or name == "arch cover" or name == "aerials" or name == "roof scoops" or name == "doors" or name == "roll cage" or name == "engine block" or name == "cam cover" or name == "strut brace" or name == "trim design" or name == "ornametns" or name == "dashboard" or name == "dials" or name == "seats" or name == "steering wheels" or name == "plate holder" or name == "vanity plates" or name == "shifter leavers" or name == "plaques" or name == "speakers" or name == "trunk" or name == "headlights" or name == "turbo" or  name == "hydraulics" or name == "liveries" or name == "horn" then
		for i,b in pairs(m.buttons) do
			if myveh.mods[b.modtype].mod == b.mod then
				b.sprite = "garage"
			else
				b.sprite = nil
			end
		end
	end
end

--Show notifications and return if item can be purchased
function CanPurchase(price, canpurchase)
	
		if LSCMenu.currentmenu == "main" then
			LSCMenu:showNotification("Your vehicle has been repaired.")
		else
			LSCMenu:showNotification("Item purchased.")
			local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			myCar = MP.GetVehicleProperties(vehicle)
			TriggerServerEvent('sofyac_lscustom:refreshOwnedVehicle', myCar)
		end
		return true
end

--Unfake vehicle, or in other words reset vehicle stuff to real so all the preview stuff would be gone
function UnfakeVeh()
	local veh = myveh.vehicle
	SetVehicleModKit(veh,0)
	SetVehicleWheelType(veh, myveh.wheeltype)
	for i,m in pairs(myveh.mods) do
		if i == 22 or i == 18 then
			ToggleVehicleMod(veh,i,m.mod)
		elseif i == 23 or i == 24 then
			SetVehicleMod(veh,i,m.mod,m.variation)
		else
			SetVehicleMod(veh,i,m.mod)
		end
	end
	SetVehicleColours(veh,myveh.color[1], myveh.color[2])
	SetVehicleExtraColours(veh,myveh.extracolor[1], myveh.extracolor[2])
	SetVehicleNeonLightsColour(veh,myveh.neoncolor[1],myveh.neoncolor[2],myveh.neoncolor[3])
	SetVehicleNumberPlateTextIndex(veh, myveh.plateindex)
	SetVehicleWindowTint(veh, myveh.windowtint)
end


RegisterNetEvent('lockGarage')
AddEventHandler('lockGarage', function(tbl)
	for i,garage in ipairs(tbl) do
		garages[i].locked = garage.locked
	end
end)

local Ibuttons = nil
--Set up scaleform
function SetIbuttons(buttons, layout)
	Citizen.CreateThread(function()
		if not HasScaleformMovieLoaded(Ibuttons) then
			Ibuttons = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
			while not HasScaleformMovieLoaded(Ibuttons) do
				Citizen.Wait(0)
			end
		else
			Ibuttons = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
			while not HasScaleformMovieLoaded(Ibuttons) do
				Citizen.Wait(0)
			end
		end
		local sf = Ibuttons
		local w,h = GetScreenResolution()
		PushScaleformMovieFunction(sf,"CLEAR_ALL")
		PopScaleformMovieFunction()
		PushScaleformMovieFunction(sf,"SET_DISPLAY_CONFIG")
		PushScaleformMovieFunctionParameterInt(w)
		PushScaleformMovieFunctionParameterInt(h)
		PushScaleformMovieFunctionParameterFloat(0.03)
		PushScaleformMovieFunctionParameterFloat(0.98)
		PushScaleformMovieFunctionParameterFloat(0.01)
		PushScaleformMovieFunctionParameterFloat(0.95)
		PushScaleformMovieFunctionParameterBool(true)
		PushScaleformMovieFunctionParameterBool(false)
		PushScaleformMovieFunctionParameterBool(false)
		PushScaleformMovieFunctionParameterInt(w)
		PushScaleformMovieFunctionParameterInt(h)
		PopScaleformMovieFunction()
		PushScaleformMovieFunction(sf,"SET_MAX_WIDTH")
		PushScaleformMovieFunctionParameterInt(1)
		PopScaleformMovieFunction()
		
		for i,btn in pairs(buttons) do
			PushScaleformMovieFunction(sf,"SET_DATA_SLOT")
			PushScaleformMovieFunctionParameterInt(i-1)
			PushScaleformMovieFunctionParameterString(btn[1])
			PushScaleformMovieFunctionParameterString(btn[2])
			PopScaleformMovieFunction()
			
		end
		if layout ~= 1 then
			PushScaleformMovieFunction(sf,"SET_PADDING")
			PushScaleformMovieFunctionParameterInt(10)
			PopScaleformMovieFunction()
		end
		PushScaleformMovieFunction(sf,"DRAW_INSTRUCTIONAL_BUTTONS")
		PushScaleformMovieFunctionParameterInt(layout)
		PopScaleformMovieFunction()
	end)
end

--Draw the scaleform
function DrawIbuttons()
	if HasScaleformMovieLoaded(Ibuttons) then
		DrawScaleformMovie(Ibuttons, 0.5, 0.5, 1.0, 1.0, 255, 255, 255, 255)
	end
end