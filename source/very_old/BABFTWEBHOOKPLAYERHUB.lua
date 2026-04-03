
local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3')))()

local w = library:CreateWindow("PlayerHub BABFT") -- Creates the window

local b = w:CreateFolder("Webhook stuff") -- Creates the folder(U will put here your buttons,etc)

local updatespeed
b:Slider("Webhook update speed",{
    min = 30; -- min value of the slider
    max = 600; -- max value of the slider
    precise = false; -- max 2 decimals
},function(value1)
updatespeed = value1
end)
local webhookURL1
b:Box("Gold Bars Webhook","string",function(value2) -- "number" or "string"
    webhookURL1 = value2 
end)

b:Toggle("^ Enable Gold Bars Webhook ^",function(bool)
    GoldWebhook = bool
    coroutine.wrap(function()
    local httpService = game:GetService("HttpService")
local request = (syn and syn.request) or request or (http and http.request) or http_request
local LastGoldAmount = game.Players.LocalPlayer.Data.Gold.Value
while GoldWebhook == true do
local NewGold = game.Players.LocalPlayer.Data.Gold.Value
request({
    Url = webhookURL1,
    Method = "POST",
    Headers = {
        ["Content-Type"] = "application/json",
    },
    Body = httpService:JSONEncode({
        content = "",
        embeds = {
            {
                title = "|| " ..game.Players.LocalPlayer.Name.. "  || 's Gold Update!",
                description = "Total Gold Bars Amount:  " .. game.Players.LocalPlayer.Data.Gold.Value,
                color = 0x81ff57,
                fields = {
                    {
                        
 name = "Updated amount made",
                        value = "Made " .. tostring(NewGold-LastGoldAmount), 
                        inline = true,
                    },
                },
            },
        },
    }),
})
LastGoldAmount = NewGold 
wait(updatespeed)
end 
end)()
end)

local WebhookURL2
b:Box("Gold Blocks Webhook","string",function(value4) -- "number" or "string"
    WebhookURL2 = value4
end)

b:Toggle("^ Enable Gold Blocks Webhook ^",function(bool)
    GoldBarWebhook = bool
    coroutine.wrap(function()
    local httpService = game:GetService("HttpService")
local request = (syn and syn.request) or request or (http and http.request) or http_request
local LastGoldBlockAmount = game:GetService("Players").LocalPlayer.Data.GoldBlock.Value
while GoldBarWebhook == true do 
local NewGoldBlock = game:GetService("Players").LocalPlayer.Data.GoldBlock.Value
request({
    Url = WebhookURL2,
    Method = "POST",
    Headers = {
        ["Content-Type"] = "application/json",
    },
    Body = httpService:JSONEncode({
        content = "",
        embeds = {
            {
                title = "|| " ..game.Players.LocalPlayer.Name.. "  || 's Gold Blocks Update!",
                description = "Total Gold Blocks Amount: " .. game:GetService("Players").LocalPlayer.Data.GoldBlock.Value,
                color = 0x81ff57,
                fields = {
                    {
                        
 name = "Updated amount made",
                        value = "Made " .. tostring(NewGoldBlock-LastGoldBlockAmount) ..  " Gold Blocks", 
                        inline = true,
                    },
                },
            },
        },
    }),
})
LastGoldBlockAmount = NewGoldBlock
wait(updatespeed)
end
end)()
end)

