local GameObject = {}
GameObject.__index = GameObject

local Transform = require("engine.components.Transform")

function GameObject:new()
    local obj = setmetatable({}, GameObject)

    obj.name = "GameObject"

    obj.active = true
    obj.visible = true
    obj.components = {}

    return obj
end

function GameObject:transform()
    return self.components["Transform"]
end

function GameObject:addComponent(component)
    if not component.name then
        print("ERROR: Component added without a 'name' property.")
        return
    end
    if self.components[component.name] then
        print("WARNING: Component '" .. component.name .. "' already exists in " .. self.name)
        return
    end

    self.components[component.name] = component
    component.gameObject = self
end

function GameObject:getComponent(componentName)
    return self.components[componentName]
end

function GameObject:removeComponent(componentName)
    local comp = self.components[componentName]
    if comp then
        comp.gameObject = nil
        self.components[componentName] = nil
    end
end

function GameObject:update(dt)
    if not self.active then return end
    for _, component in pairs(self.components) do
        if component.update then
            component:update(dt)
        end
    end
end

function GameObject:draw()
    if not self.active then return end
    if not self.visible then return end
    for _, component in pairs(self.components) do
        if component.draw then
            component:draw()
        end
    end
end

return GameObject
