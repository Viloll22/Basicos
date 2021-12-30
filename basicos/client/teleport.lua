------------------- teleport ------------------------------


local TeleportFromTo = {

    ["hospital"] = {
        positionFrom = { ['x'] = 330.03, ['y'] = -601.03, ['z'] = 42.28, nom = "ir al Helipuerto"},
        positionTo = { ['x'] = 338.86, ['y'] = -583.83, ['z'] = 74.16, nom = "bajar al hospital"},
    },
    ["hospital2"] = {
        positionFrom = { ['x'] = 332.12, ['y'] = -595.68, ['z'] = 42.28, nom = "ir al hospital de abajo"},
        positionTo = { ['x'] = 344.68, ['y'] = -586.48, ['z'] = 27.8, nom = "ir al hospital de arriba"},
    },
    ["parkinghospital"] = {
        positionFrom = { ['x'] = 327.04, ['y'] = -603.6, ['z'] = 42.28, nom = "ir al garaje"},
        positionTo = { ['x'] = 340.08, ['y'] = -584.68, ['z'] = 27.8, nom = "ir al hospital de arriba"},
    },
    ["parkinghospital2"] = {
        positionFrom = { ['x'] = 341.28, ['y'] = -580.92, ['z'] = 27.8, nom = "ir al Helipuerto"},
        positionTo = { ['x'] = 338.86, ['y'] = -583.83, ['z'] = 74.16, nom = "bajar al hospital"},
    },
    ["Morgue"] = {
        positionFrom = { ['x'] = 346.16, ['y'] = -582.52, ['z'] = 27.8, nom = "ir a la Morgue"},
        positionTo = { ['x'] =279.4, ['y'] = -1349.6, ['z'] = 23.52, nom = "ir al hospital"},
    },
    ["ConcesionarioLuxeAscensor"] = {
        positionFrom = { ['x'] = 138.28, ['y'] = -137.72, ['z'] = 54.88, nom = "SUBIR"},
        positionTo = { ['x'] =137.52, ['y'] = -134.76, ['z'] = 60.52, nom = "BAJAR"},
    },
    -- ["ConceLuxeAscensorcoche"] = {
    --     positionFrom = { ['x'] = 134.56, ['y'] = -134.44, ['z'] = 54.92, nom = "SUBIR"},
    --     positionTo = { ['x'] = 134.36, ['y'] = -131.36, ['z'] = 60.56, nom = "BAJAR"},
    -- },
    }
    
    Drawing = setmetatable({}, Drawing)
    Drawing.__index = Drawing
    
    
    function Drawing.draw3DText(x,y,z,textInput,fontId,scaleX,scaleY,r, g, b, a)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
    
    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    
    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(r, g, b, a)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
    end
    
    function Drawing.drawMissionText(m_text, showtime)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(m_text)
    DrawSubtitleTimed(showtime, 1)
    end
    
    function msginf(msg, duree)
    duree = duree or 500
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(msg)
    DrawSubtitleTimed(duree, 1)
    end
    
    Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        local pos = GetEntityCoords(GetPlayerPed(-1), true)
        local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    
        for k, j in pairs(TeleportFromTo) do
    
            --msginf(k .. " " .. tostring(j.positionFrom.x), 15000)
            if(Vdist(pos.x, pos.y, pos.z, j.positionFrom.x, j.positionFrom.y, j.positionFrom.z) < 150.0)then
                DrawMarker(-1, j.positionFrom.x, j.positionFrom.y, j.positionFrom.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, .801, 255, 255, 255,255, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, j.positionFrom.x, j.positionFrom.y, j.positionFrom.z) < 5.0)then
                    sleep = 1
                    Drawing.draw3DText(j.positionFrom.x, j.positionFrom.y, j.positionFrom.z - 1.100, j.positionFrom.texto, 2, 0.2, 0.1, 255, 255, 255, 215)
                    if(Vdist(pos.x, pos.y, pos.z, j.positionFrom.x, j.positionFrom.y, j.positionFrom.z) < 2.0)then
                        ClearPrints()
                        SetTextEntry_2("STRING")
                        AddTextComponentString("Presiona ~r~E~w~ para ".. j.positionFrom.nom)
                        DrawSubtitleTimed(100, 1)
                        if IsControlJustPressed(1, 38) then
                            DoScreenFadeOut(1000)
                            Citizen.Wait(2000)
                                if(IsPedInAnyVehicle(GetPlayerPed(-1))) then
                                   --ESX.Game.Teleport(vehicle, {j.entrar.x, j.entrar.y, j.entrar.z, j.entrar.h })
                                   SetEntityCoords(GetPlayerPed(-1), j.positionTo.x, j.positionTo.y, j.positionTo.z, -1)
                                else
                                    SetEntityCoords(GetPlayerPed(-1), j.positionTo.x, j.positionTo.y, j.positionTo.z, -1)
                                    
                                end
                            DoScreenFadeIn(1000)
                        end
                    end
                end
            end
    
            if(Vdist(pos.x, pos.y, pos.z, j.positionTo.x, j.positionTo.y, j.positionTo.z) < 150.0)then
                DrawMarker(-1, j.positionTo.x, j.positionTo.y, j.positionTo.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, .801, 255, 255, 255,255, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, j.positionTo.x, j.positionTo.y, j.positionTo.z) < 5.0)then
                    sleep = 1
                    Drawing.draw3DText(j.positionTo.x, j.positionTo.y, j.positionTo.z - 1.100, j.positionTo.texto, 2, 0.2, 0.1, 255, 255, 255, 215)
                    if(Vdist(pos.x, pos.y, pos.z, j.positionTo.x, j.positionTo.y, j.positionTo.z) < 2.0)then
                        ClearPrints()
                        SetTextEntry_2("STRING")
                        AddTextComponentString("Presiona ~r~E~w~ para ".. j.positionTo.nom)
                        DrawSubtitleTimed(100, 1)
                        if IsControlJustPressed(1, 38) then
                            DoScreenFadeOut(1000)
                            Citizen.Wait(2000)
                                if(IsPedInAnyVehicle(GetPlayerPed(-1))) then
                                    --ESX.Game.Teleport(vehicle, {j.salir.x, j.salir.y, j.salir.z, j.salir.h})   
                                    SetEntityCoords(GetPlayerPed(-1), j.positionFrom.x, j.positionFrom.y, j.positionFrom.z, -1)                            
                                else
                                    SetEntityCoords(GetPlayerPed(-1), j.positionFrom.x, j.positionFrom.y, j.positionFrom.z, -1)                                
                                end
                            DoScreenFadeIn(1000)
                        end
                    end
                end
            end
        end
        Citizen.Wait(sleep)
    end
    end)