local Direction = {}

function Direction.new(dirX, dirY)
    return {
        dirX = dirX or 0,
        dirY = dirY or 0
    }
end

return Direction
