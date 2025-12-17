local Button = {}

Button.__index = Button

function Button.new(x, y, text, onPressed, onReleased, onMouseEnter, onMouseLeave)
    local instance = {
        text = text or "Button",
        x = x or 0,
        y = y or 0,
        width = 100,
        height = 50,
        borderRadius = 4,
        isBeingHovered = false,
        isBeingHeldDown = false,
        onPressed = onPressed or function() print(text .. " has no onPressedHandler") end,
        onReleased = onReleased or function() print(text .. " has no onReleasedHandler") end,
        onMouseEnter = onMouseEnter or function() print(text .. " has no onMouseOverHandler") end,
        onMouseLeave = onMouseLeave or function() print(text .. " has no onMouseLeaveHandler") end,
    }
    return setmetatable(instance, Button)
end

function Button:draw()
    if self.isBeingHeldDown then
        love.graphics.setColor(0.4, 0.4, 0.4)
    elseif self.isBeingHovered then
        love.graphics.setColor(0.7, 0.7, 0.7)
    else
        love.graphics.setColor(1, 1, 1)
    end

    love.graphics.rectangle("line", self.x, self.y, self.width, self.height, self.borderRadius)
    love.graphics.printf(self.text, self.x, self.y + (self.height / 2) - 10, self.width, "center")

    love.graphics.setColor(1, 1, 1)
end

function Button:update(dt)
    local _, mx, my = Shove.mouseToViewport()
    local isHovered = self:isHovered(mx, my)

    if isHovered then
        if self.isBeingHovered == false then
            self.onMouseEnter()
            self.isBeingHovered = true
        end
    else
        if self.isBeingHovered == true then
            self.onMouseLeave()
            self.isBeingHovered = false
        end
        if self.isBeingHeldDown then
            self.isBeingHeldDown = false
        end
    end
end

function Button:isHovered(px, py)
    return px >= self.x and px <= self.x + self.width and
        py >= self.y and py <= self.y + self.height
end

function Button:onMousePressed(x, y, button, istouch)
    if button == 1 and self.isBeingHovered then
        self.onPressed()
        self.isBeingHeldDown = true
        return
    end
end

function Button:onMouseReleased(x, y, button, istouch)
    if button == 1 and self.isBeingHeldDown then
        if self.isBeingHovered then
            self.onReleased()
        end
        self.isBeingHeldDown = false
    end
end

function Button:onKeyPressed(key)

end

function Button:onKeyReleased(key)

end

return Button
