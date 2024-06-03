local alltriggerprotectbymp = {}
local allargsantitrigger = {}

RegisterNetEvent("MP:RandomiseArgs")
AddEventHandler("MP:RandomiseArgs", function(args)
    allargsantitrigger = args
    print("j'ai recu")
end)

function MP.TriggerServerEvent(name, ...)
        if alltriggerprotectbymp[name] == nil then alltriggerprotectbymp[name] = 0 end
        alltriggerprotectbymp[name] = alltriggerprotectbymp[name] + 1
        TriggerServerEvent("MP:AntiTrigger:" ..name, {args = allargsantitrigger[name][alltriggerprotectbymp[name]], triggername = name}, nil, ...)
end