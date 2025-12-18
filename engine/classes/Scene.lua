local Scene = {}
Scene.__index = Scene

function Scene.new(name)
    local instance = {
        name = name or "Unnamed Scene",
        gameObjects = {},
        uiElements = {},
        paused = false,
    }
    return setmetatable(instance, Scene)
end

function Scene:load()
end

function Scene:unload()
    self.gameObjects = nil
    self.uiElements = nil
end

function Scene:addGameObject(gameObject)
    table.insert(self.gameObjects, gameObject)
end

function Scene:addUIElement(uiElement)
    table.insert(self.uiElements, uiElement)
end

function Scene:update(dt)
    if self.paused then
        return
    end
    for _, gameObject in ipairs(self.gameObjects) do
        if gameObject.update then
            gameObject:update(dt)
        end
    end
    for _, uiElement in ipairs(self.uiElements) do
        if uiElement.update then
            uiElement:update(dt)
        end
    end
end

function Scene:draw()
    for _, gameObject in ipairs(self.gameObjects) do
        if gameObject.draw then
            gameObject:draw()
        end
    end
    for _, uiElement in ipairs(self.uiElements) do
        if uiElement.draw then
            uiElement:draw()
        end
    end
end

return Scene
