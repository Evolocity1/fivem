local allcustom = {}

Citizen.CreateThread(function()
        MySQL.Async.fetchAll('SELECT * FROM MP_vehicle', {}, function(result)
                for i = 1, #result do
                    if allcustom[result[i].identifier] == nil then allcustom[result[i].identifier] = {} end
                    table.insert(allcustom[result[i].identifier], {model = result[i].model, props = json.decode(result[i].props)})
                end
        end)
end)

function GetCustomVehicle(identifier, model)
    if allcustom[identifier] then
        for i = 1, #allcustom[identifier] do
            if tonumber(allcustom[identifier][i].model) == tonumber(model) then
                return true, allcustom[identifier][i]
            end
        end
    end
    return false
end

local function AddCustomVehicle(identifier, model, props)
    local bool, lacustom = GetCustomVehicle(identifier, model)
    if bool then
        MySQL.Async.execute('UPDATE MP_vehicle SET props = @props WHERE identifier = @identifier AND model = @model', {
            ['@props'] = json.encode(props),
            ['@identifier'] = identifier,
            ['@model'] = model,
        })
        lacustom.props = props
    else
        if allcustom[identifier] == nil then allcustom[identifier] = {} end
        table.insert(allcustom[identifier], {model = model, props = props})
        MySQL.Async.execute("INSERT INTO MP_vehicle (identifier, model, props) VALUES (@identifier, @model, @props)", {
            ['@identifier'] = identifier,
            ['@model'] = model,
            ['@props'] = json.encode(props),
        })
    end
end

RegisterServerEvent("LSC:buttonSelected")
AddEventHandler("LSC:buttonSelected", function(name, button)
    local _source = source
	local xPlayer = MP.GetPlayerFromId(_source)
	if button.price then -- check if button have price
		if button.price < xPlayer.getMoney() then
			TriggerClientEvent("LSC:buttonSelected", source,name, button, true)
			xPlayer.removeMoney(button.price)
		else
			TriggerClientEvent("LSC:buttonSelected", source,name, button, false)
		end
	end
end)

local tuningData = {}
function GetTuningData()
    local json_data = LoadResourceFile(GetCurrentResourceName(),  './vehTunings.json')
    if(json_data == '')then
        json_data = {}
    else
        json_data = json.decode(json_data)
    end
    return json_data
end

function SaveToTuningData(data)
    SaveResourceFile(GetCurrentResourceName(),'vehTunings.json', json.encode(data), -1)
end

Citizen.CreateThread(function()
	Citizen.Wait(1000)
	tuningData = GetTuningData()
end)

function CheckTuningDataExist(identifier)
	if(not tuningData[identifier])then
		tuningData[identifier] = {}
	end
end
function GetVehicleTuningData(source, model)
	model = tostring(model)
	local xPlayer = MP.GetPlayerFromId(source)
	CheckTuningDataExist(xPlayer.identifier)
	return tuningData[xPlayer.identifier][model] or false
end

RegisterServerEvent("authentic:SetVehMetadata")
AddEventHandler("authentic:SetVehMetadata", function(index, properties, model)
	local src = source
	local xPlayer = MP.GetPlayerFromId(src)
	CheckTuningDataExist(xPlayer.identifier)
	tuningData[xPlayer.identifier][tostring(model)] = properties
	SaveToTuningData(tuningData)
	xPlayer.SetMetadata(index, properties)
end)


RegisterServerEvent('sofyac_lscustom:refreshOwnedVehicle')
AddEventHandler('sofyac_lscustom:refreshOwnedVehicle', function(vehicleProps)
    if vehicleProps == nil then return end
	local xPlayer = MP.GetPlayerFromId(source)
	AddCustomVehicle(xPlayer.identifier, vehicleProps.model, vehicleProps)
end)

RegisterServerEvent("LSC:finished")
AddEventHandler("LSC:finished", function(veh)
	local model = veh.model --Display name from vehicle model(comet2, entityxf)
	local mods = veh.mods
	--[[
	mods[0].mod - spoiler
	mods[1].mod - front bumper
	mods[2].mod - rearbumper
	mods[3].mod - skirts
	mods[4].mod - exhaust
	mods[5].mod - roll cage
	mods[6].mod - grille
	mods[7].mod - hood
	mods[8].mod - fenders
	mods[10].mod - roof
	mods[11].mod - engine
	mods[12].mod - brakes
	mods[13].mod - transmission
	mods[14].mod - horn
	mods[15].mod - suspension
	mods[16].mod - armor
	mods[23].mod - tires
	mods[23].variation - custom tires
	mods[24].mod - tires(Just for bikes, 23:front wheel 24:back wheel)
	mods[24].variation - custom tires(Just for bikes, 23:front wheel 24:back wheel)
	mods[25].mod - plate holder
	mods[26].mod - vanity plates
	mods[27].mod - trim design
	mods[28].mod - ornaments
	mods[29].mod - dashboard
	mods[30].mod - dial design
	mods[31].mod - doors
	mods[32].mod - seats
	mods[33].mod - steering wheels
	mods[34].mod - shift leavers
	mods[35].mod - plaques
	mods[36].mod - speakers
	mods[37].mod - trunk
	mods[38].mod - hydraulics
	mods[39].mod - engine block
	mods[40].mod - cam cover
	mods[41].mod - strut brace
	mods[42].mod - arch cover
	mods[43].mod - aerials
	mods[44].mod - roof scoops
	mods[45].mod - tank
	mods[46].mod - doors
	mods[48].mod - liveries
	
	--Toggle mods
	mods[20].mod - tyre smoke
	mods[22].mod - headlights
	mods[18].mod - turbo
	
	--]]
	local color = veh.color
	local extracolor = veh.extracolor
	local neoncolor = veh.neoncolor
	local smokecolor = veh.smokecolor
	local plateindex = veh.plateindex
	local windowtint = veh.windowtint
	local wheeltype = veh.wheeltype
	local bulletProofTyres = veh.bulletProofTyres
	--Do w/e u need with all this stuff when vehicle drives out of lsc
end)
