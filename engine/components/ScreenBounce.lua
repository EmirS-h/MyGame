local ScreenBounce = {}
ScreenBounce.__index = ScreenBounce

function ScreenBounce:new(vx, vy)
    local comp = setmetatable({}, ScreenBounce)

    comp.name = "ScreenBounce"
    comp.gameObject = nil

    comp.vx = vx or 200
    comp.vy = vy or 200

    return comp
end

function ScreenBounce:update(dt)
    -- 1. Get the components we need
    local t = self.gameObject:transform()
    if not t then return end

    -- Try to get the shape to know our width/height
    -- If no shape exists, we assume size is 0 (a single point)
    local shape = self.gameObject:getComponent("Shape")
    local halfWidth = shape and (shape.width / 2) or 0
    local halfHeight = shape and (shape.height / 2) or 0

    -- 2. Update Position based on Velocity
    t.x = t.x + self.vx * dt
    t.y = t.y + self.vy * dt

    -- 3. Check Screen Boundaries
    local sw, sh = Shove.getViewportDimensions()
    local screenW = sw
    local screenH = sh

    -- Bounce off Left Wall
    if t.x - halfWidth < 0 then
        t.x = halfWidth    -- Snap back inside
        self.vx = -self.vx -- Reverse direction
    end

    -- Bounce off Right Wall
    if t.x + halfWidth > screenW then
        t.x = screenW - halfWidth
        self.vx = -self.vx
    end

    -- Bounce off Top Wall
    if t.y - halfHeight < 0 then
        t.y = halfHeight
        self.vy = -self.vy
    end

    -- Bounce off Bottom Wall
    if t.y + halfHeight > screenH then
        t.y = screenH - halfHeight
        self.vy = -self.vy
    end
end

return ScreenBounce
