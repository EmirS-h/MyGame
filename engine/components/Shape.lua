local Shape = {}
Shape.__index = Shape

function Shape:new(shapeType, width, height, color)
    local comp = setmetatable({}, Shape)

    comp.name = "Shape"
    comp.gameObject = nil

    comp.shapeType = shapeType or "rectangle"
    comp.width = width or 50
    comp.height = height or 50
    comp.color = color or { 1, 1, 1, 1 }

    comp.offsetX = comp.width / 2
    comp.offsetY = comp.height / 2

    return comp
end

function Shape:draw()
    local t = self.gameObject:transform()
    if not t then
        print("WARN: Shape component has no Transform to draw at!")
        return
    end

    love.graphics.push()

    love.graphics.translate(t.x, t.y)
    love.graphics.rotate(t.angle)
    love.graphics.scale(t.scaleX, t.scaleY)

    local c = self.color
    love.graphics.setColor(c[1], c[2], c[3], c[4] or 1)

    if self.shapeType == "rectangle" then
        love.graphics.rectangle(
            "fill",
            -self.offsetX,
            -self.offsetY,
            self.width,
            self.height
        )
    elseif self.shapeType == "circle" then
        love.graphics.circle("fill", 0, 0, self.width / 2)
    end

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.pop()
end

return Shape
