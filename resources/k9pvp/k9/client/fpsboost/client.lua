
local function setShadowAndAir(shadow, air)
    RopeDrawShadowEnabled(shadow)
    CascadeShadowsClearShadowSampleType()
    CascadeShadowsSetAircraftMode(air)
end


local function setEntityTracker(entity, dynamic, tracker, depth, bounds)
    CascadeShadowsEnableEntityTracker(entity)
    CascadeShadowsSetDynamicDepthMode(dynamic)
    CascadeShadowsSetEntityTrackerScale(tracker)
    CascadeShadowsSetDynamicDepthValue(depth)
    CascadeShadowsSetCascadeBoundsScale(bounds)
end

local function setLights(distance, tweak)
    SetFlashLightFadeDistance(distance)
    SetLightsCutoffDistanceTweak(tweak)
end



function FpsBooster(type)
    if not type then
		RopeDrawShadowEnabled(true)

      CascadeShadowsSetAircraftMode(true)
      CascadeShadowsEnableEntityTracker(false)
      CascadeShadowsSetDynamicDepthMode(true)
      CascadeShadowsSetEntityTrackerScale(5.0)
      CascadeShadowsSetDynamicDepthValue(5.0)
      CascadeShadowsSetCascadeBoundsScale(5.0)
      
      SetFlashLightFadeDistance(10.0)
      SetLightsCutoffDistanceTweak(10.0)
      DistantCopCarSirens(true)
      SetArtificialLightsState(false)
    else
        setShadowAndAir(false, false)
        setEntityTracker(true, false, 0.0, 0.0, 0.0)
        setLights(0.0, 0.0)
    end
end

exports("fpsbooster", function(bool)
        FpsBooster(bool)
        MP.GetPlayerData()["parameter"]["fpsboost"]["enable"] = bool
end)

CreateThread(function()
    while not MP.Loaded do Citizen.Wait(100) end
    while true do
        local xPlayer = MP.GetPlayerData()
        if xPlayer["parameter"]["fpsboost"]["enable"] then
            local ped = PlayerPedId()

            ClearAllBrokenGlass()
            ClearAllHelpMessages()
            LeaderboardsReadClearAll()
            ClearBrief()
            ClearGpsFlags()
            ClearPrints()
            ClearSmallPrints()
            ClearReplayStats()
            LeaderboardsClearCacheData()
            ClearFocus()
            ClearPedBloodDamage(ped)
            ClearPedWetness(ped)
            ClearPedEnvDirt(ped)
            ResetPedVisibleDamage(ped)
            ClearExtraTimecycleModifier()
            ClearTimecycleModifier()
            ClearOverrideWeather()
            ClearHdArea()
            DisableVehicleDistantlights(false)
            DisableScreenblurFade()
            SetRainLevel(0.0)
            SetWindSpeed(0.0)
            Wait(300)
        else
            Wait(1500)
        end
    end
end)