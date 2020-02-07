
-- OGK Common Utils - API Common interface

-- Author: DeadlyKungFu.Ninja

-- Gamemode events

local function OnGetProfileComplete(profileRequest, id)
    local status = http_result_status(profileRequest)
    if status == 200 then
        local body = http_result_body(profileRequest)
        print("[OGK][API] Player detail fetched")
        -- _.print(body)
        CallEvent("OGK:API:ReceivePlayerProfile", id, body)
    else
        print("[OGK][API] Player data fetch failed")
        _.print(body)
    end
end

AddEvent("OGK:API:GetPlayerProfile", function(id, playerSteamId)
    print("[OGK][API] Getting player profile for "..playerSteamId)
    local profileRequest = makeApiRequest()

    -- TODO: Renew key periodically
	http_set_target(profileRequest, "/profile/"..playerSteamId)
    http_set_verb(profileRequest, "get")

    if http_send(profileRequest, OnGetProfileComplete, profileRequest, id) == false then
		print("[OGK][API] ERROR : Player profile request failed due to gameserver problem")
		http_destroy(profileRequest)
    end
end)
