Citizen.Trace("\n===========\nLoading " ..GetCurrentResourceName().. "\nScript Enabled: " ..tostring(Config.ScriptEnabled).. "\n===========")

if Config.ScriptEnabled then
if GetCurrentResourceName() == "M-AOP" then

HudFormat = "~g~~h~AOP: ~w~%s" --S is defined as the string, we format it down ther
AOP = Config.AOP.DefaultAOP

--Tables
IsBanned = {Sandy = false, Paleto = false, Legion = false}
IsAOP = {BC = false, LS = false}
Inside = {SandyBanned = false, PaletoBanned = false, LegionBanned = false, BC = false, LS = false}
ReadyForAOPChange = {SandyBanned = false, PaletoBanned = false, LegionBanned = false, BC = false, LS = false}

-------------------------------------
-------------- Threads --------------
-------------------------------------
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    HudText = string.format(HudFormat, AOP)
     Draw2DText(Config.Hud.x, Config.Hud.y, HudText, Config.Hud.scale)
   end
end)

--Do not remove this or I will commit a murder, this is for when a player connects it makes sure AOP is updated etc.
Citizen.CreateThread(function()
	TriggerServerEvent("M:ServerUpdateAOP")
	return
end)

-------------------------------------
------------- Functions -------------
-------------------------------------

function Draw2DText(x, y, text, scale)
  SetTextFont(4)
  SetTextProportional(7)
  SetTextScale(scale, scale)
  SetTextColour(255, 255, 255, 255)
  SetTextDropShadow(0, 0, 0, 0,255)
  SetTextDropShadow()
  SetTextEdge(4, 0, 0, 0, 255)
  SetTextOutline()
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(x, y)
end

-------------------------------------
-------------- Events ---------------
-------------------------------------

RegisterNetEvent("M:UpdateAOP")
AddEventHandler("M:UpdateAOP", function(NewAOP)
  AOP = NewAOP
  TriggerEvent("M:DebugLog", "===========\nUpdating AOP Cause someone changed it??? true \nChecking for banned areas\nAOP Changed to: " ..AOP.. "\n===========\nSandy Banned: " ..tostring(IsBanned.Sandy).. "\nPaleto Banned: " ..tostring(IsBanned.Paleto).. "\nLegion Banned:" ..tostring(IsBanned.Legion).. "\nBlaine County: " ..tostring(IsAOP.BC).. "\nLos Santos: " ..tostring(IsAOP.LS).. "\n===========")
end)

RegisterNetEvent("M:ClearAOPBans")
AddEventHandler("M:ClearAOPBans", function()
  if IsBanned.Sandy then
   SandyBanned:destroy()
   IsBanned.Sandy = false 
   Inside.SandyBanned = false
   ReadyForAOPChange.SandyBanned = false
  end 

  if IsBanned.Paleto then 
   PaletoBanned:destroy()
   IsBanned.Paleto = false
   Inside.PaletoBanned = false
   ReadyForAOPChange.PaletoBanned = false
  end

  if IsAOP.BC then
   BlaineCounty:destroy()
   IsAOP.BC = false
   Inside.BC = true
   ReadyForAOPChange.BC = false
  end
  if IsAOP.LS then
   LosSantos:destroy()
   IsAOP.LS = false
   Inside.LS = true 
   ReadyForAOPChange.LS = false
  end
end)

RegisterNetEvent("M:DebugLog")
AddEventHandler("M:DebugLog", function(msg)
   if Config.Debug then 
    Citizen.Trace("\n" .. msg)
    --[[EVENT COPY AND PASTE, TEHE
    TriggerClientEvent("M:DebugLog", -1, ARGS_HERE_BUDDY)
    TriggerEvent("M:DebugLog", ARGS_HERE_BUDDY)
]]
    end
end)

RegisterNetEvent("M:CreatePolyAOP")
AddEventHandler("M:CreatePolyAOP", function(Area)
  --[Sandy Banned]
   if Area == "Sandy" then 
    SandyBanned = PolyZone:Create({ --Create the Visible Zone
      vector2(2067.0021972656, 3731.3178710938),
      vector2(1688.1508789062, 3510.34765625),
      vector2(1503.8568115234, 3794.5886230469),
      vector2(1894.8681640625, 4016.6379394531)
  }, {
    name = "ss_banned",
    minZ = -200.0,
    maxZ = 2700.0,
    debugGrid = false, 
    debugPoly = true,
    debugColors = {
      walls = {0, 0, 0},
      grid = {0, 0, 0}
    }
  })
  IsBanned.Sandy = true
  ReadyForAOPChange.SandyBanned = false
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      if IsBanned.Sandy then
        local playerPed = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(playerPed, false)
        Inside.SandyBanned = SandyBanned:isPointInside(plyCoords)

        if Inside.SandyBanned and not ReadyForAOPChange.SandyBanned then 
          if (IsPedInAnyVehicle(playerPed, true)) then vehicle = GetVehiclePedIsIn(playerPed, false) SetEntityAsMissionEntity(vehicle, false, false) DeleteEntity(vehicle) end
          for _, coords in pairs(Config.TeleportCoords[1]) do
          SetEntityCoords(playerPed, coords.x, coords.y, coords.z, 0, 0, 0)
          exports['t-notify']:Custom({style  =  'error', duration  =  5000, title  =  'AOP Announcement', message  =  'You have been teleported due to being out of AOP.', sound  =  false})
          ReadyForAOPChange.SandyBanned = true 
          end 
        else
          ReadyForAOPChange.SandyBanned = true 

        if ReadyForAOPChange.SandyBanned then 
          if not Inside.SandyBanned then
            LastValidSandy = plyCoords
        else
          local vehicle
          if (IsPedInAnyVehicle(playerPed, true)) then
            vehicle = GetVehiclePedIsIn(playerPed, false)
          end
          local index = 0
          if (vehicle) then
            SetEntityCoordsNoOffset(vehicle, LastValidSandy.x + index, LastValidSandy.y + index, LastValidSandy.z, 0, 0, 1)
          else 
            SetEntityCoords(playerPed, LastValidSandy.x + index, LastValidSandy.y + index, LastValidSandy.z -1, 0, 0, 0, false)
                  end
                end
              end
            end
        end
    end
  end)
end

--[Paleto Banned]
if Area == "Paleto" then
  PaletoBanned = PolyZone:Create({
    vector2(394.3742980957, 6710.7983398438),
    vector2(-522.88342285156, 5755.3701171875),
    vector2(-740.63665771484, 6065.189453125),
    vector2(151.09629821777, 6970.9653320312)
  }, {
    name = "paleto_banned",
    minZ = -200.0,
    maxZ = 2700.0,
    debugGrid = false, 
    debugPoly = true,
    debugColors = {
      walls = {0, 0, 0},
      grid = {0, 0, 0}
    }
  })
  IsBanned.Paleto = true
  ReadyForAOPChange.PaletoBanned = false
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      if IsBanned.Paleto then
        local playerPed = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(playerPed, false)
        Inside.PaletoBanned = PaletoBanned:isPointInside(plyCoords)

        if Inside.PaletoBanned and not ReadyForAOPChange.PaletoBanned then 
          if (IsPedInAnyVehicle(playerPed, true)) then vehicle = GetVehiclePedIsIn(playerPed, false) SetEntityAsMissionEntity(vehicle, false, false) DeleteEntity(vehicle) end
          for _, coords in pairs(Config.TeleportCoords[2]) do
          SetEntityCoords(playerPed, coords.x, coords.y, coords.z, 0, 0, 0)
          exports['t-notify']:Custom({style  =  'error', duration  =  5000, title  =  'AOP Announcement', message  =  'You have been teleported due to being out of AOP.', sound  =  false})
          ReadyForAOPChange.PaletoBanned = true 
          end 
        else
          ReadyForAOPChange.PaletoBanned = true 

        if ReadyForAOPChange.PaletoBanned then 
          if not Inside.PaletoBanned then
            LastValidPaleto = plyCoords
        else
          local vehicle
          if (IsPedInAnyVehicle(playerPed, true)) then
            vehicle = GetVehiclePedIsIn(playerPed, false)
          end
          local index = 0
          if (vehicle) then
            SetEntityCoordsNoOffset(vehicle, LastValidPaleto.x + index, LastValidPaleto.y + index, LastValidPaleto.z, 0, 0, 1)
          else 
            SetEntityCoords(playerPed, LastValidPaleto.x + index, LastValidPaleto.y + index, LastValidPaleto.z -1, 0, 0, 0, false)
                end
              end
            end
          end
      end
    end
  end)
end

--[Legion Banned]
if Area == "Legion" then
  LegionBanned = PolyZone:Create({
    vector2(233.37663269043, -1074.9246826172),
    vector2(319.18588256836, -829.88989257812),
    vector2(158.31649780273, -777.93499755859),
    vector2(78.355484008789, -1012.6400146484)
  }, {
    name = "legion_banned",
    minZ = -200.0,
    maxZ = 2700.0,
    debugGrid = false, 
    debugPoly = true,
    debugColors = {
      walls = {0, 0, 0},
      grid = {0, 0, 0}
    }
  })
  IsBanned.Legion = true
  ReadyForAOPChange.LegionBanned = false
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      if IsBanned.Legion then
        local playerPed = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(playerPed, false)
        Inside.LegionBanned = LegionBanned:isPointInside(plyCoords)

        if Inside.LegionBanned and not ReadyForAOPChange.LegionBanned then 
          if (IsPedInAnyVehicle(playerPed, true)) then vehicle = GetVehiclePedIsIn(playerPed, false) SetEntityAsMissionEntity(vehicle, false, false) DeleteEntity(vehicle) end
          for _, coords in pairs(Config.TeleportCoords[3]) do
          SetEntityCoords(playerPed, coords.x, coords.y, coords.z, 0, 0, 0)
          exports['t-notify']:Custom({style  =  'error', duration  =  5000, title  =  'AOP Announcement', message  =  'You have been teleported due to being out of AOP.', sound  =  false})
          ReadyForAOPChange.LegionBanned = true 
          end 
        else
          ReadyForAOPChange.LegionBanned = true 

        if ReadyForAOPChange.LegionBanned then 
          if not Inside.LegionBanned then
            LastValidLegion = plyCoords
        else
          local vehicle
          if (IsPedInAnyVehicle(playerPed, true)) then
            vehicle = GetVehiclePedIsIn(playerPed, false)
          end
          local index = 0
          if (vehicle) then
            SetEntityCoordsNoOffset(vehicle, LastValidLegion.x + index, LastValidLegion.y + index, LastValidLegion.z, 0, 0, 1)
          else 
            SetEntityCoords(playerPed, LastValidLegion.x + index, LastValidLegion.y + index, LastValidLegion.z -1, 0, 0, 0, false)
                end
              end
            end
          end
      end
    end
  end)
end

--Blaine County
if Area == "BC" then
  BlaineCounty = PolyZone:Create({
    vector2(3988.1889648438, 1150.2734375),
    vector2(-3682.111328125, 3279.951171875),
    vector2(-10.136557579041, 8165.2641601562),
    vector2(4699.3608398438, 5827.4853515625)
  }, {
    name = "blaine_county",
    minZ = -200.0,
    maxZ = 2700.0,
    debugGrid = false, 
    debugPoly = true,
    debugColors = {
      walls = {0, 0, 0},
      grid = {0, 0, 0}
    }
  })
  IsAOP.BC = true
  ReadyForAOPChange.BC = false
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      if IsAOP.BC then
        local playerPed = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(playerPed, false)
        Inside.BC = BlaineCounty:isPointInside(plyCoords)

        if not Inside.BC and not ReadyForAOPChange.BC then 
          if (IsPedInAnyVehicle(playerPed, true)) then vehicle = GetVehiclePedIsIn(playerPed, false) SetEntityAsMissionEntity(vehicle, false, false) DeleteEntity(vehicle) end
          for _, coords in pairs(Config.TeleportCoords[4]) do
          SetEntityCoords(playerPed, coords.x, coords.y, coords.z, 0, 0, 0)
          exports['t-notify']:Custom({style  =  'error', duration  =  5000, title  =  'AOP Announcement', message  =  'You have been teleported due to being out of AOP.', sound  =  false})
          ReadyForAOPChange.BC = true 
          end 
        else
          ReadyForAOPChange.BC = true 

        if ReadyForAOPChange.BC then 
          if Inside.BC then
            LastValidBC = plyCoords
        else
          local vehicle
          if (IsPedInAnyVehicle(playerPed, true)) then
            vehicle = GetVehiclePedIsIn(playerPed, false)
          end
          local index = 0
          if (vehicle) then
            SetEntityCoordsNoOffset(vehicle, LastValidBC.x + index, LastValidBC.y + index, LastValidBC.z, 0, 0, 1)
          else 
            SetEntityCoords(playerPed, LastValidBC.x + index, LastValidBC.y + index, LastValidBC.z -1, 0, 0, 0, false)
                  end
                end
              end
            end
        end
      end
  end)
end

--Los Santos
  if Area == "LS" then
    LosSantos = PolyZone:Create({
      vector2(3923.9282226562, 2843.8864746094),
      vector2(-3938.0290527344, 2881.302734375),
      vector2(-3836.0129394531, -4037.7358398438),
      vector2(3954.1811523438, -3850.9892578125)
    }, {
      name = "los_santos",
      minZ = -200.0,
      maxZ = 2700.0,
      debugGrid = false, 
      debugPoly = true,
      debugColors = {
        walls = {0, 0, 0},
        grid = {0, 0, 0}
      }
    })
  IsAOP.LS = true
  ReadyForAOPChange.LS = false
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
            if IsAOP.LS then
        local playerPed = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(playerPed, false)
        Inside.LS = LosSantos:isPointInside(plyCoords)

        if not Inside.LS and not ReadyForAOPChange.LS then 
          if (IsPedInAnyVehicle(playerPed, true)) then vehicle = GetVehiclePedIsIn(playerPed, false) SetEntityAsMissionEntity(vehicle, false, false) DeleteEntity(vehicle) end
          for _, coords in pairs(Config.TeleportCoords[5]) do
          SetEntityCoords(playerPed, coords.x, coords.y, coords.z, 0, 0, 0)
          exports['t-notify']:Custom({style  =  'error', duration  =  5000, title  =  'AOP Announcement', message  =  'You have been teleported due to being out of AOP.', sound  =  false})
          ReadyForAOPChange.LS = true 
          end 
        else
          ReadyForAOPChange.LS = true 

        if ReadyForAOPChange.LS then 
          if Inside.LS then
            LastValidLS = plyCoords
        else
          local vehicle
          if (IsPedInAnyVehicle(playerPed, true)) then
            vehicle = GetVehiclePedIsIn(playerPed, false)
          end
          local index = 0
          if (vehicle) then
            SetEntityCoordsNoOffset(vehicle, LastValidLS.x + index, LastValidLS.y + index, LastValidLS.z, 0, 0, 1)
          else 
            SetEntityCoords(playerPed, LastValidLS.x + index, LastValidLS.y + index, LastValidLS.z -1, 0, 0, 0, false)
                  end
                end
              end
            end
        end
    end
  end)
  end
end)

else 
  Citizen.Trace("\nERROR: " ..GetCurrentResourceName().. " Needs to be Named M-AOP\n===========")
end
else 
  Citizen.Trace(GetCurrentResourceName().. " is currently disabled as Config.ScriptEnabled = " ..tostring(Config.ScriptEnabled))
end
