Shove = require("engine.libs.shove")
InputManager = require("engine.managers.InputManager")
SceneManager = require("engine.managers.SceneManager")
Globals = require("engine.managers.Globals")

Fullscreen = false

function love.load()
    local current_os = love.system.getOS()
    if current_os == "iOS" or current_os == "Android" then
    resW, resH = love.graphics.getDimensions()
    vW, vH = 360, 640 -- portrait virtual resolution
else
    resW, resH = 1280, 720
    vW, vH = 640, 360
end

    Shove.setResolution(vW,vH, { fitMethod = "pixel", scalingFilter = "nearest", renderMode = "layer" })
    Shove.setWindowMode(resW, resH, { resizable = false })

    Shove.createLayer("baseLayer")

    SceneManager.addScene('MainMenu', require('myGame.MenuScene'))
    SceneManager.addScene('GameScene', require('myGame.GameScene'))

    SceneManager.changeScene('MainMenu')

    InputManager.bind("fullscreen", { "escape", "space" })
end

function love.update(dt)
    InputManager.update()

    Globals.MouseX, Globals.MouseY = love.mouse.getPosition()
    _, Globals.MouseWorldX, Globals.MouseWorldY = Shove.mouseToViewport()

    SceneManager.update(dt)

    if InputManager.isActionJustPressed("fullscreen") then
        Fullscreen = not Fullscreen
        love.window.setFullscreen(Fullscreen)
    end
end

function love.draw()
    Shove.beginDraw()
    Shove.beginLayer("baseLayer")

    SceneManager.draw()

    love.graphics.print(Globals.MouseWorldX, 50, 50)
    love.graphics.print(Globals.MouseWorldY, 100, 50)

    love.graphics.print(Globals.MouseX, 50, 100)
    love.graphics.print(Globals.MouseY, 100, 100)

    Shove.endLayer()
    Shove.endDraw()
end

function love.keypressed(key)
    InputManager.handlePressed(key)
end

function love.keyreleased(key)
    InputManager.handleReleased(key)
end

function love.mousepressed(x, y, button)
    InputManager.handlePressed(button)
end

function love.mousereleased(x, y, button)
    InputManager.handleReleased(button)
end

function love.mousemoved(x, y, dx, dy)
    InputManager.handleMouseMoved(x, y, dx, dy)
end
