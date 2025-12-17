local Position = {}
Position.__index = Position

function Position:__call(x, y)
    local comp = setmetatable({}, Position)

    comp.name = "Position"
    comp.gameObject = nil

    comp.x = x or 0
    comp.y = y or 0

    return comp
end

return Position
