ejemplo = "Desacato RP"

offset = {x = 0.420, y = 0.050}

rgb = {r = 255, g = 0, b = 0}

transparencia = 255

scale = 0.7


-- 0 - 5
font = 4

arcoiris = true

Citizen.CreateThread(function()
    while true do
        Wait(1)

        if arcoiris then
            rgb = RGBRainbow(1)
        end
        SetTextColour(rgb.r, rgb.g, rgb.b, transparencia)
        SetTextFont(font)
        SetTextScale(scale, scale)
        SetTextWrap(0.0, 1.0)
        SetTextCentre(false)
        SetTextDropShadow(2, 2, 0, 0, 0)
        SetTextEdge(1, 0, 0, 0, 205)
        SetTextEntry("STRING")
        AddTextComponentString(ejemplo)
        DrawText(offset.x, offset.y)
    end
end)

function RGBRainbow(frequency)
    local result = {}
    local curtime = GetGameTimer() / 1000

    result.r = math.floor(math.sin(curtime * frequency + 0) * 127 + 128)
    result.g = math.floor(math.sin(curtime * frequency + 2) * 127 + 128)
    result.b = math.floor(math.sin(curtime * frequency + 4) * 127 + 128)

    return result
end