local Velocity = {}
Velocity.__index = Velocity

function Velocity:new(vx, vy)
    local comp = setmetatable({}, Velocity)

    comp.name = "Velocity"
    comp.gameObject = nil

    comp.velocityX = vx or 0
    comp.velocityY = vy or 0

    return comp
end

return Velocity
