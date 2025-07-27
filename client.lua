blackBars = false

local function toggleBlackBars()
    blackBars = not blackBars
    if blackBars then
        DisplayRadar(false)
    else
        DisplayRadar(true)
    end
end

RegisterCommand("blackbars", function()
    toggleBlackBars()
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)

        if blackBars then
            DrawRect(1.0, 1.0, 2.0, 0.25, 0, 0, 0, 255) -- x, y, width, height, red, green, blue, alpha
            DrawRect(1.0, 0.0, 2.0, 0.25, 0, 0, 0, 255)
        end
    end
end)
