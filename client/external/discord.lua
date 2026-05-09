-- maybe controversial, but ehh you can discuss about it.
-- also credits too: https://rscripts.net/script/auto-join-discord-script-E2ke

local discordInvite = "https://discord.gg/QMUcu5H7bY"
if setclipboard then
	setclipboard(discordInvite)
end

local inviteCode =
    discordInvite:match("discord%.gg/(%w+)")
    or discordInvite:match("discord%.com/invite/(%w+)")

if not inviteCode then
    return
end

local http_request =
    (syn and syn.request) or
    (http and http.request) or
    (http_request) or
    (request)

if http_request then
    pcall(function()
        http_request({
            Url = "http://127.0.0.1:6463/rpc?v=1",
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json",
                ["Origin"] = "https://discord.com"
            },
            Body = game:GetService("HttpService"):JSONEncode({
                cmd = "INVITE_BROWSER",
                args = { code = inviteCode },
                nonce = game:GetService("HttpService"):GenerateGUID(false)
            })
        })
    end)
else
	print("not supported")
end
