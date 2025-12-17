local Collider = {}

function Collider.new(width, height)
    return {
        width = width or 50,
        height = height or 50
    }
end

return Collider
