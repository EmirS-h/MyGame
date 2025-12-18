local SceneManager = {}

SceneManager.scenes = {}
SceneManager.currentScene = nil

function SceneManager.addScene(sceneName, sceneClass)
    if SceneManager.scenes[sceneName] then
        print("Warning: Scene '" .. sceneName .. "' already exists.")
        return
    end

    SceneManager.scenes[sceneName] = sceneClass
end

function SceneManager.changeScene(sceneName)
    local sceneClass = SceneManager.scenes[sceneName]

    if sceneClass then
        if SceneManager.currentScene and SceneManager.currentScene.unload then
            SceneManager.currentScene:unload()
        end

        SceneManager.currentScene = sceneClass.new()

        if SceneManager.currentScene.load then
            SceneManager.currentScene:load()
        end
    else
        error("Scene '" .. sceneName .. "' does not exist.")
    end
end

function SceneManager.update(dt)
    if SceneManager.currentScene and SceneManager.currentScene.update then
        SceneManager.currentScene:update(dt)
    end
end

function SceneManager.draw()
    if SceneManager.currentScene and SceneManager.currentScene.draw then
        SceneManager.currentScene:draw()
    end
end

return SceneManager
