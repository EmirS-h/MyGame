local Rotation = {}
Rotation.__index = Rotation

function Rotation:new(angle)
    local comp = setmetatable({}, Rotation)

    comp.name = "Rotation"
    comp.gameObject = nil

    comp.angle = angle or 0

    return comp
end

return Rotation
