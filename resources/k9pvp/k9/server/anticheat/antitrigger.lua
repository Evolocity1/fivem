local lesargs = {}
local argsexec = {}
local lestrigger = {}
local ok = ""
function MP.RegisterServerEvent(name, cb)
    RegisterServerEvent("MP:AntiTrigger:"..name)
    RegisterServerEvent(name)
    print("Trigger : ".. name .. " is protect")
    table.insert(lestrigger, name)
    if cb then
        MP.AddEventHandler(name, cb)
    end
end

function MP.AddEventHandler(name, cb)
    AddEventHandler("MP:AntiTrigger:"..name, function(data, isTriggerEvent, ...)
        local _src = source
            if isTriggerEvent == nil then
                argsexec[tostring(_src)][name] = argsexec[tostring(_src)][name] + 1
                if data.args == lesargs[tostring(_src)][name][argsexec[tostring(_src)][name]] then
                    local pack = msgpack.pack({_src, ...})
                    local one, two = InvokeFunctionReference(Citizen.GetFunctionReference(cb), pack, pack:len(), 0)
                    print(GetPlayerName(_src).. " vient d'executer le trigger : " ..name.. " [LEGIT]")
                else
                    MP.BanPlayer(_src, "Anti Trigger K9 PVP", "Anti Trigger (" ..name.. ")")
                end
            end
    end)

    AddEventHandler(name, function()
        local _src = source
        MP.BanPlayer(_src, "Anti Trigger K9 PVP", "Anti Trigger (" ..name.. ")")
    end)
end

function RandomVariable(length)
	local res = ""
	for i = 1, length do
		res = res .. string.char(math.random(97, 122))
	end
	return res
end

function GenerateToken(src)
    argsexec[tostring(src)] = {}
    lesargs[tostring(src)] = {}
    for i = 1, #lestrigger do
        argsexec[tostring(src)][lestrigger[i]] = 0
        lesargs[tostring(src)][lestrigger[i]] = {}
        for d = 1, 20000 do
            table.insert(lesargs[tostring(src)][lestrigger[i]], string.char(math.random(97, 122)))
        end
    end
    TriggerClientEvent("MP:RandomiseArgs", src, lesargs[tostring(src)])
    print("Token généré pour le joueur : " ..src)
end

function DeleteToken(src)
    argsexec[tostring(src)] = nil
    lesargs[tostring(src)] = nil
end