--[[local isNoClip = false

function getCamDirection()
    local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(PlayerPedId())
    local pitch = GetGameplayCamRelativePitch()
    local coords = vector3(-math.sin(heading * math.pi / 180.0), math.cos(heading * math.pi / 180.0), math.sin(pitch * math.pi / 180.0))
    local len = math.sqrt((coords.x * coords.x) + (coords.y * coords.y) + (coords.z * coords.z))

    if len ~= 0 then
        coords = coords / len
    end

    return coords
end
local NoClipSpeed = 1.0
function NoClip(bool)
    local xPlayer = MP.GetPlayerData()
    if xPlayer.group == "user" then return end
    if not MP.InModeStaff then MP.ShowNotification("Tu n'es pas en mode staff") return end
    isNoClip = bool
    if isNoClip then
        --SetEntityInvincible(PlayerPedId(), true)
        Citizen.CreateThread(function()
            local vehicle = GetVehiclePedIsIn(PlayerPedId())
            local entity = vehicle == 0 and PlayerPedId() or vehicle
            while isNoClip do
                Wait(1)
                local pCoords = GetEntityCoords(PlayerPedId(), false)
                local camCoords = getCamDirection()
                vehicle = GetVehiclePedIsIn(PlayerPedId())
                entity = vehicle == 0 and PlayerPedId() or vehicle
                SetEntityVelocity(entity, 0.01, 0.01, 0.01)
                SetEntityCollision(entity, 0, 1)
                FreezeEntityPosition(entity, true)

                if IsControlPressed(0, 32) then
                    pCoords = pCoords + (NoClipSpeed * camCoords)
                end

                if IsControlPressed(0, 269) then
                    pCoords = pCoords - (NoClipSpeed * camCoords)
                end

                if IsDisabledControlJustPressed(1, 15) then
                    NoClipSpeed = NoClipSpeed + 0.1
                end
                if IsDisabledControlJustPressed(1, 14) then
                    NoClipSpeed = NoClipSpeed - 0.2
                    if NoClipSpeed < 0 then
                        NoClipSpeed = 0
                    end
                end
                SetEntityCoordsNoOffset(entity, pCoords, true, true, true)
                SetEntityVisible(entity, 0, 0)

            end
            FreezeEntityPosition(entity, false)
            SetEntityVisible(entity, 1, 0)
            SetEntityCollision(entity, 1, 1)
            FreezeEntityPosition(PlayerPedId(), false)
            SetEntityVisible(PlayerPedId(), 1, 0)
            SetEntityCollision(PlayerPedId(), 1, 1)
        end)
    else
        --SetEntityInvincible(PlayerPedId(), false)
    end
end

RegisterCommand("noclip", function(source, args)
    NoClip(not isNoClip)
end)]]