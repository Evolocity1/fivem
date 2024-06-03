local serverCallbacks = {}

local clientRequests = {}
local RequestId = 0

---@param eventName string
---@param callback function
MP.RegisterServerCallback = function(eventName, callback)
  serverCallbacks[eventName] = callback
end

RegisterNetEvent('MP:triggerServerCallback', function(eventName, requestId, invoker, ...)
  if not serverCallbacks[eventName] then
    return print(('[^1ERROR^7] Server Callback not registered, name: ^5%s^7, invoker resource: ^5%s^7'):format(eventName, invoker))
  end

  local source = source

  serverCallbacks[eventName](source, function(...)
    TriggerClientEvent('MP:serverCallback', source, requestId, invoker, ...)
  end, ...)
end)

---@param player number playerId
---@param eventName string
---@param callback function
---@param ... any
MP.TriggerClientCallback = function(player, eventName, callback, ...)
  clientRequests[RequestId] = callback

  TriggerClientEvent('MP:triggerClientCallback', player, eventName, RequestId, GetInvokingResource() or "unknown", ...)

  RequestId = RequestId + 1
end

RegisterNetEvent('MP:clientCallback', function(requestId, invoker, ...)
  if not clientRequests[requestId] then
    return print(('[^1ERROR^7] Client Callback with requestId ^5%s^7 Was Called by ^5%s^7 but does not exist.'):format(requestId, invoker))
  end

  clientRequests[requestId](...)
  clientRequests[requestId] = nil
end)