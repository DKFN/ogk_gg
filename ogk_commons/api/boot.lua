
-- OGK Common Utils - API Common interface

-- Author: DeadlyKungFu.Ninja

local function OnLoginComplete(keyRequest)
    local status = http_result_status(keyRequest)
    if status == 200 then
        local body = http_result_body(keyRequest)
        local data = json.parse(body)
        
        SERVER_PRIVATE_KEY = data.token
        print("[OGK][API] Gameserver successfully logged in to OGK ! /o/")
        if data.isOfficial then
            print("[OGK][API] Official server -- Key for "..data.community.." community")
        else
            print("[OGK][API] Server is not official or debug enabled. PM DeadlyKungFu.Ninja#8294 to get an official server key")
        end
        CallEvent("OGK:API:GetGamemodeStats")
    else
        print("[OGK][API] /!\\ ERROR : Gameserver could not connect to OGK ["..status.."]")
        print("[OGK][API] /!\\ ERROR : Ui and gamemode might be broken, users will not be rewarded by playing on your server ")
    end
    http_destroy(keyRequest)
end

AddEvent("OnPackageStart", function()
    local officialKey = ""
    local gamemode = "Unknown"
    local keyRequest = makeApiRequest()
    print("[OGK][API] Getting API key for game server ...")

    -- TODO: Renew key periodically
	http_set_target(keyRequest, "/game-server")
    http_set_verb(keyRequest, "post")
    

    -- if not OGK_GG_DEBUG then -- FIXME : Coupling (Introduce naming for debug variable ?)
        local file = io.open('ogk_key', 'r')
        if file == nil then
            print("[OGK][API] No official server key found (Player stats will not be saved)")
        else
            officialKey = file:read("*a")
            file.close()
        end

    -- else
    --    print("[OGK][API] Server is not allowed to register an official key on debug mode")
    -- end

    if OGK_GAMEMODE then
        gamemode = OGK_GAMEMODE
    end
    
    -- Todo: Find the binded ip and if not on masterlist or non binded to public or with a password then cancel credits
    local body = json.stringify({
        name = GetServerName(),
        gameMode = gamemode,
        officialServerKey = officialKey
    })

	http_set_field(keyRequest, "content-length", string.len(body))
    http_set_field(keyRequest, "content-type", "application/json; charset=utf-8")
    http_set_body(keyRequest, body)
    if http_send(keyRequest, OnLoginComplete, keyRequest) == false then
        http_destroy(keyRequest)
		error("[OGK][API] ERROR : Login request failed due to gameserver problem (things will break)")
	end
end)
