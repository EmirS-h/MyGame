local GameObject = require("engine.classes.GameObject")
local Transform = require("engine.components.Transform")
local Shape = require("engine.components.Shape")

local ScreenBounce = require("engine.components.ScreenBounce")

local Player = {}

function Player:new()
    local go = GameObject:new()

    go:addComponent(Transform:new(150, 300))

    go:addComponent(Shape:new("rectangle", 50, 50, { 0.6, 0.3, 1 }))

    go:addComponent(ScreenBounce:new(400, 400))

    return go
end

return Player
