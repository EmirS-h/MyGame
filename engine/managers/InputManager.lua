local InputManager = {
    _justPressed = {},
    _justReleased = {},

    _pendingPressed = {},
    _pendingReleased = {},

    _mousePosition = { x = 0, y = 0 },
    _mouseDelta = { x = 0, y = 0 },

    bindings = {},
    consumed = {},
}

function InputManager.update()
    for k in pairs(InputManager._justPressed) do InputManager._justPressed[k] = nil end
    for k in pairs(InputManager._justReleased) do InputManager._justReleased[k] = nil end
    for k in pairs(InputManager.consumed) do InputManager.consumed[k] = nil end

    for k, v in pairs(InputManager._pendingPressed) do
        InputManager._justPressed[k] = true
        InputManager._pendingPressed[k] = nil
    end

    for k, v in pairs(InputManager._pendingReleased) do
        InputManager._justReleased[k] = true
        InputManager._pendingReleased[k] = nil
    end


    InputManager._mouseDelta.x = 0
    InputManager._mouseDelta.y = 0
end

function InputManager.wasJustPressed(key)
    return InputManager._justPressed[key] == true
end

function InputManager.wasJustReleased(key)
    return InputManager._justReleased[key] == true
end

-- Check if a key/button is physically held down (Native Love2D check)
function InputManager.isDown(key)
    if type(key) == "number" then
        return love.mouse.isDown(key)
    else
        return love.keyboard.isDown(key)
    end
end

function InputManager.bind(actionName, keys)
    InputManager.bindings[actionName] = keys
end

function InputManager.consume(actionName)
    InputManager.consumed[actionName] = true
end

function InputManager.isActionJustPressed(action)
    if InputManager.consumed[action] then return false end

    local keys = InputManager.bindings[action]
    if not keys then return false end

    for _, key in ipairs(keys) do
        if InputManager.wasJustPressed(key) then return true end
    end
    return false
end

function InputManager.isActionDown(action)
    if InputManager.consumed[action] then return false end

    local keys = InputManager.bindings[action]
    if not keys then return false end

    for _, key in ipairs(keys) do
        if InputManager.isDown(key) then return true end
    end
    return false
end

function InputManager.handlePressed(key)
    InputManager._pendingPressed[key] = true
end

function InputManager.handleReleased(key)
    InputManager._pendingReleased[key] = true
end

function InputManager.handleMouseMoved(x, y, dx, dy)
    InputManager._mousePosition.x = x
    InputManager._mousePosition.y = y
    InputManager._mouseDelta.x = dx
    InputManager._mouseDelta.y = dy
end

function InputManager.getMousePosition()
    return InputManager._mousePosition.x, InputManager._mousePosition.y
end

return InputManager
