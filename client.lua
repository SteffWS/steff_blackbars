local blackBars = false
local barHeight = 0.0
local targetHeight = 0.0
local transitionSpeed = 0.005

-- Open the blackbars menu
RegisterCommand("blackbars", function()
    lib.registerContext({
        id = 'blackbars_menu',
        title = 'Cinematic Blackbars',
        options = {
            {
                title = 'Low',
                description = 'Small bars',
                icon = 'minus',
                onSelect = function()
                    setBlackBars(true, 0.05)
                end,
            },
            {
                title = 'Medium',
                description = 'Medium bars',
                icon = 'film',
                onSelect = function()
                    setBlackBars(true, 0.10)
                end,
            },
            {
                title = 'High',
                description = 'Tall bars',
                icon = 'film',
                onSelect = function()
                    setBlackBars(true, 0.15)
                end,
            },
            {
                title = 'Remove',
                icon = 'x',
                description = 'Remove blackbars',
                onSelect = function()
                    setBlackBars(false)
                end,
            },
        }
    })

    lib.showContext('blackbars_menu')
end)

function setBlackBars(state, height)
    blackBars = state
    if state then
        targetHeight = height
        DisplayRadar(false)
    else
        targetHeight = 0.0
        DisplayRadar(true)
    end
end

-- Draw cinematic blackbars
CreateThread(function()
    while true do
        Wait(0)
        if blackBars or barHeight > 0.0 then
            -- Animate the bars up/down
            if math.abs(barHeight - targetHeight) > 0.001 then
                if barHeight < targetHeight then
                    barHeight = barHeight + transitionSpeed
                    if barHeight > targetHeight then barHeight = targetHeight end
                else
                    barHeight = barHeight - transitionSpeed
                    if barHeight < targetHeight then barHeight = targetHeight end
                end
            end

            -- Hide HUD elements
            HideHudAndRadarThisFrame()

            -- Draw top and bottom black bars
            DrawRect(0.5, 0.0 + barHeight / 2, 1.0, barHeight, 0, 0, 0, 255)
            DrawRect(0.5, 1.0 - barHeight / 2, 1.0, barHeight, 0, 0, 0, 255)
        else
            Wait(100)
        end
    end
end)
