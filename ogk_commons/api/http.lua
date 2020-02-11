-- OGK Common Utils - API Common interface

-- Author: DeadlyKungFu.Ninja

SERVER_PRIVATE_KEY = nil

function makeApiRequest()
    if http_create == nil then
        error("[OGK][API] FATAL !! UPDATE ONSET GAMESERVER !!")
    end
    local r = http_create()
	http_set_resolver_protocol(r, "ipv4")
	http_set_protocol(r, "http")
	http_set_host(r, "api.ogk.deadlykungfu.ninja")
    http_set_port(r, 3000)
	http_set_timeout(r, 30)
	http_set_version(r, 11)
	http_set_keepalive(r, true)
    http_set_field(r, "user-agent", "Onset Server / "..GetGameVersionString())

    if SERVER_PRIVATE_KEY then
        http_set_field(r, "x-server-key", SERVER_PRIVATE_KEY)
    end
    return r
end
