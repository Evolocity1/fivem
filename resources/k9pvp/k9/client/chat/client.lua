function addMessageInChat(msg)
    if #MP.Chat >= 6 then
        table.remove(MP.Chat, 1)
    end
    table.insert(MP.Chat, {msg = msg, time = 5})
end

local function deleteAllChatTime()
    for i = 1, #MP.Chat do
        if MP.Round(MP.Chat[i].time) == 0 then
            table.remove(MP.Chat, i)
            break
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        for i = 1, #MP.Chat do
            MP.Chat[i].time = MP.Chat[i].time - 0.1
        end
        for i = 1, #MP.Chat do
            deleteAllChatTime()
        end
    end
end)

RegisterNetEvent("MP:AddChat")
AddEventHandler("MP:AddChat", function(msg)
    addMessageInChat(msg)
end)

local random = {
    "~o~MP~s~ a éliminé ~r~Stone~s~ avec un fusil à pompe ~r~(150.0m)",
    "~r~Tatatata~s~ a éliminé ~r~Tatatatata~s~ avec un fusil d'assault ~r~(175.0m)",
}
