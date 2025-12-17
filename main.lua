Shove = require("engine.libs.shove")
InputManager = require("engine.managers.InputManager")
SceneManager = require("engine.managers.SceneManager")
Globals = require("engine.managers.Globals")

Fullscreen = false

function love.load()
    Shove.setResolution(640, 360, { fitMethod = "pixel", scalingFilter = "nearest", renderMode = "layer" })
    Shove.setWindowMode(1280, 720, { resizable = true })

    Shove.createLayer("baseLayer")

    InputManager.bindAction('close_game', { 'escape' })

    SceneManager.addScene('MainMenu', require('myGame.MenuScene'))
    SceneManager.addScene('GameScene', require('myGame.GameScene'))

    SceneManager.changeScene('MainMenu')
end

function love.update(dt)
    Globals.MouseX, Globals.MouseY = love.mouse.getPosition()
    _, Globals.MouseWorldX, Globals.MouseWorldY = Shove.mouseToViewport()


    if InputManager.isActionPressed('close_game') then
        love.event.quit()
    end

    if InputManager.isKeyPressed("e") then
        print("eeeeeeeeeeeeeeeee")
    end

    SceneManager.update(dt)
    InputManager.update()
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
    InputManager.handleKeypressed(key)
end

function love.keyreleased(key)
    InputManager.handleKeyreleased(key)
end

function love.mousepressed(x, y, button, istouch)
    InputManager.handleMousepressed(x, y, button, istouch)
end

function love.mousereleased(x, y, button, istouch)
    InputManager.handleMousereleased(x, y, button, istouch)
end
