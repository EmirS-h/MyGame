local Sprite = {}
Sprite.__index = Sprite

function Sprite:new(image)
    local comp = setmetatable({}, Sprite)

    comp.name = "Sprite"
    comp.gameObject = nil

    comp.image = image
    comp.width = image:getWidth()
    comp.height = image:getHeight()

    return comp
end

function Sprite:draw()
    if not self.image then return end

    -- Get the transform data from the GameObject
    local t = self.gameObject:transform()

    love.graphics.draw(
        self.image,
        t.x, -- Get X from the transform component
        t.y, -- Get Y from the transform component
        t.angle,
        t.scaleX,
        t.scaleY
    )
end

return Sprite
