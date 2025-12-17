local InputManager = {
    keyboardStates = {},
    mouseStates = {},
    previousKeyboardStates = {},
    previousMouseStates = {},
    mouseTouchStates = {},
    mousePosition = { x = 0, y = 0 },
    mouseDelta = { x = 0, y = 0 },
    bindings = {},
    consumedActions = {}
}

local KEY_STATES = {
    NONE = 0,
    PRESSED = 1,
    HELD = 2,
    RELEASED = 3
}

function InputManager.update()
    InputManager.consumedActions = {}

    InputManager.previousKeyboardStates = {}
    for k, v in pairs(InputManager.keyboardStates) do
        InputManager.previousKeyboardStates[k] = v
    end

    InputManager.previousMouseStates = {}
    for k, v in pairs(InputManager.mouseStates) do
        InputManager.previousMouseStates[k] = v
    end

    for key, state in pairs(InputManager.keyboardStates) do
        if state == KEY_STATES.PRESSED then
            InputManager.keyboardStates[key] = KEY_STATES.HELD
        elseif state == KEY_STATES.RELEASED then
            InputManager.keyboardStates[key] = KEY_STATES.NONE
        end
    end

    for button, state in pairs(InputManager.mouseStates) do
        if state == KEY_STATES.PRESSED then
            InputManager.mouseStates[button] = KEY_STATES.HELD
        elseif state == KEY_STATES.RELEASED then
            InputManager.mouseStates[button] = KEY_STATES.NONE
            InputManager.mouseTouchStates[button] = nil
        end
    end
end

function InputManager.bindAction(actionName, keys)
    InputManager.bindings[actionName] = keys
end

function InputManager.consumeAction(actionName)
    InputManager.consumedActions[actionName] = true
end

function InputManager.isActionPressed(actionName)
    if InputManager.consumedActions[actionName] then
        return false
    end

    local keys = InputManager.bindings[actionName]
    if not keys then return false end

    for _, key in ipairs(keys) do
        -- We must check if the key is a number (mouse) or string (keyboard)
        if type(key) == "number" then
            if InputManager.isMousePressed(key) then
                return true
            end
        elseif type(key) == "string" then
            if InputManager.isKeyPressed(key) then
                return true
            end
        end
    end
    return false
end

function InputManager.isActionHeld(actionName)
    if InputManager.consumedActions[actionName] then
        return false
    end

    local keys = InputManager.bindings[actionName]
    if not keys then return false end

    for _, key in ipairs(keys) do
        if type(key) == "number" then
            if InputManager.isMouseHeld(key) then
                return true
            end
        elseif type(key) == "string" then
            if InputManager.isKeyHeld(key) then
                return true
            end
        end
    end
    return false
end

function InputManager.isActionReleased(actionName)
    if InputManager.consumedActions[actionName] then
        return false
    end

    local keys = InputManager.bindings[actionName]
    if not keys then return false end

    for _, key in ipairs(keys) do
        if type(key) == "number" then
            if InputManager.isMouseReleased(key) then
                return true
            end
        elseif type(key) == "string" then
            if InputManager.isKeyReleased(key) then
                return true
            end
        end
    end
    return false
end

function InputManager.isKeyPressed(key)
    return InputManager.keyboardStates[key] == KEY_STATES.PRESSED
end

function InputManager.isKeyHeld(key)
    return InputManager.keyboardStates[key] == KEY_STATES.HELD
end

function InputManager.isKeyReleased(key)
    return InputManager.keyboardStates[key] == KEY_STATES.RELEASED
end

function InputManager.isMousePressed(button)
    return InputManager.mouseStates[button] == KEY_STATES.PRESSED
end

function InputManager.isMouseHeld(button)
    return InputManager.mouseStates[button] == KEY_STATES.HELD
end

function InputManager.isMouseReleased(button)
    return InputManager.mouseStates[button] == KEY_STATES.RELEASED
end

function InputManager.isMousePressedByTouch(button)
    return InputManager.isMousePressed(button) and InputManager.mouseTouchStates[button] == true
end

function InputManager.isMouseHeldByTouch(button)
    return InputManager.isMouseHeld(button) and InputManager.mouseTouchStates[button] == true
end

function InputManager.getMousePosition()
    return InputManager.mousePosition.x, InputManager.mousePosition.y
end

function InputManager.getMouseDelta()
    return InputManager.mouseDelta.x, InputManager.mouseDelta.y
end

function InputManager.handleKeypressed(key)
    InputManager.keyboardStates[key] = KEY_STATES.PRESSED
end

function InputManager.handleKeyreleased(key)
    InputManager.keyboardStates[key] = KEY_STATES.RELEASED
end

function InputManager.handleMousepressed(x, y, button, istouch)
    InputManager.mouseStates[button] = KEY_STATES.PRESSED
    InputManager.mouseTouchStates[button] = istouch or false
end

function InputManager.handleMousereleased(x, y, button, istouch)
    InputManager.mouseStates[button] = KEY_STATES.RELEASED
end

function InputManager.handleMousemoved(x, y, dx, dy)
    InputManager.mousePosition.x = x
    InputManager.mousePosition.y = y
    InputManager.mouseDelta.x = dx
    InputManager.mouseDelta.y = dy
end

return InputManager
