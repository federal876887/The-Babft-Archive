-- Voltra Loader
-- Loading the Main Script and Second Module and if not used the Script before the Discord Module

-- Made with Love by Vyrusspcs
-- https://discord.gg/u46cvej5xM

local MainScriptURL = "main_script_url_placeholder"
local SecondModuleURL = "second_module_url_placeholder"
local DiscordURL = "https://raw.githubusercontent.com/Vyrusspcs/weshkyv2/refs/heads/main/client/external/discord.lua"

local FolderName = "VoltaraBuildStorage"

local HttpService = game:GetService("HttpService")

local function safeLoad(url)
    if not url or url == "" then
        warn("Invalid URL provided.")
        return false
    end

    local success, response = pcall(function()
        return game:HttpGet(url)
    end)

    if not success or not response then
        warn("Failed to fetch script from:", url)
        return false
    end

    local loadSuccess, loadErr = pcall(function()
        loadstring(response)()
    end)

    if not loadSuccess then
        warn("Error while executing script from:", url)
        warn(loadErr)
        return false
    end

    return true
end

local function init()
    safeLoad(MainScriptURL)
    task.wait(0.2)
    safeLoad(SecondModuleURL)
end

if not isfolder(FolderName) then
    safeLoad(DiscordURL)
end

init()