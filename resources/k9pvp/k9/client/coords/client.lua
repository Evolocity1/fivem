local mainMenuZ = RageUI.CreateMenu("Menu pos", "By MP")

local open = false

RegisterCommand('coords', function(source, args, rawCommand)
    if MP.GetPlayerData()["group"] ~= "owner" then return end
	if open then return end
	open = true
	leopen()
end)

function leopen()
	local elements = {
		{label = 'vector3(x, y, z)', value = "vector"},
		{label = '{x = x, y = y, z = z}', value = "xyz"},
		{label = 'Heading', value = "heading"},
		{label = 'Tout', value = "all"}
	}
	Citizen.CreateThread(function()
		RageUI.Visible(mainMenuZ, true)
		while open do
			RageUI.IsVisible(mainMenuZ, function()
				for i = 1, #elements do
					RageUI.Button(elements[i].label, nil, {RightLabel = "→"}, true, {onSelected = function()
						if elements[i].value == "vector" then
							local coords = GetEntityCoords(PlayerPedId())
							SendNUIMessage({
							    type ="coords",
								coords = "vector3("..coords.x..", "..coords.y..", "..coords.z..")"
							})
							print("vector3("..coords.x..", "..coords.y..", "..coords.z..")")
						elseif elements[i].value == "xyz" then
							local coords = GetEntityCoords(PlayerPedId())
							SendNUIMessage({
							    type ="coords",
								coords = "{x = "..coords.x..", y = "..coords.y..", z = "..coords.z.."}"
							})
						elseif elements[i].value == "heading" then
							local coords = GetEntityHeading(PlayerPedId())
							SendNUIMessage({
							    type ="coords",
								coords = "" ..coords.. ""
							})
						elseif elements[i].value == "all" then
							local coords = GetEntityCoords(PlayerPedId())
							local heading = GetEntityHeading(PlayerPedId())
							SendNUIMessage({
							    type ="coords",
								coords = "vector3("..coords.x..", "..coords.y..", "..coords.z..") \n{x = "..coords.x..", y = "..coords.y..", z = "..coords.z.."} \n" ..heading
							})
						end
					end});
				end
			end)
			if not RageUI.Visible(mainMenuZ) then open = false end
			if MP.GetPlayerData()["group"] ~= "owner" then open = false end
			Citizen.Wait(1)
		end
	end)
	
end