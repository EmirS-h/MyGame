local Scene = require('engine.classes.Scene')
local Button = require('engine.ui.Button')

local MainMenuScene = {}
MainMenuScene.__index = MainMenuScene
setmetatable(MainMenuScene, Scene)

function MainMenuScene.new()
    local instance = Scene.new("Main Menu")

    setmetatable(instance, MainMenuScene)
    return instance
end

function MainMenuScene:load()
    print("Main Menu Scene Loaded")

    local startButton = Button.new(150, 200, "Start Game", function() SceneManager.changeScene("GameScene") end)

    local quitButton = Button.new(150, 300, "Quit Game")

    self:addUIElement(startButton)
    self:addUIElement(quitButton)
end

function MainMenuScene:unload()
    print("Main Menu Scene Unloaded")
    Scene.unload(self)
end

-- 5. Override the 'draw' function to add a background (optional)
function MainMenuScene:draw()
    love.graphics.clear(0.1, 0.1, 0.1)
    Scene.draw(self)
end

return MainMenuScene
