local Scale = {}
Scale.__index = Scale

function Scale.new(sx, sy)
    local comp = setmetatable({}, Scale)

    comp.name = "Scale"
    comp.gameObject = nil

    comp.scaleX = sx or 1
    comp.scaleY = sy or 1

    return comp
end

return Scale
