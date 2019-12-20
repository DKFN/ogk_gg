-- Web UI Manager
--
--  State is currently hard coded in gui.lua as "game"
--
-- Possible Manager improvement:
--   - use a force attribut instead of default for UIs not closable in a particular state
--   - propagate state to child [required] (give to GUIs the hability to react on event accordingly to the state)
--      - add a win/end state
--      - add an intro state
--   - add dynamic init 


-- Web UI
--
-- MUST respect the following interface:
--  - function Foo.setVisibility(visibility) call SetWebVisibility on it's inner object
--  - function Foo.hide() call Foo.setVisibility(WEB_HIDDEN)
--
-- Possible interface improvement
--   - Learn how to use these fucking lua class and do some inheritance 
--   - add a function Foo.setState(state) to propagate change to the GUIs


local webUI = { -- "private" internal structure 
    game = { -- Web ui authorized on the game state and default visibility
        hud = {default = WEB_VISIBLE},
        scoreboard = {default = WEB_HIDDEN}
    },
    death = { -- Web ui authorized on the death state and default visibility (state not used so far, just here as example)
        scoreboard = {default = WEB_VISIBLE}
    },
    gui = {} -- dictionnaire of GUI handled by the manager, the gui name should match key in state
}
-- Every GUIs not visible on a particular state should be hidden

-- Pseudo class that handle all web GUI
-- The command should depend on the player state
WebUIManager = {}

function WebUIManager.init()
	HUD.init()
    Scoreboard.init()

    -- Init list of gui, key MUST BE the same as used in the state
    webUI.gui["hud"] = HUD 
    webUI.gui["scoreboard"] = Scoreboard
end

-- Return a gui (can be nil), we should get ride of this function at some time
-- the WebUIManager should act like a firewall for all web GUIs 
-- currently needed on win, will be remove once Foo.setState(state) and a win state are added
function WebUIManager.getGUI(gui)
    Logger.info("WebUI", "start getGUI")
    if gui == nil then
        Logger.err("WebUI", "Nil gui in getGUI")
        return
    elseif webUI.gui[gui] == nil then
        Logger.err("WebUI", "Unknown gui "..gui.." in getGUI")
        return
    end
    return webUI.gui[gui] 
end

function WebUIManager.setVisibility(item, state, visibility)
    Logger.info("WebUI", "start set visibility")
    if state == nil or item == nil or visibility == nil then
        Logger.err("WebUI", "Nil argument in setVisibility")
        return
    elseif webUI.gui[item] == nil then
        Logger.err("WebUI", "Unknown item "..item.." in setVisibility")
        return
    elseif webUI[state] == nil then
        Logger.err("WebUI", "Unknown state "..state.." in setVisibility")
        return
    end

    -- If the ui is not in the current state, we hide it
    if webUI[state][item] == nil then
        webUI[item].hide()
    -- Else we give it it's new visibility
    else
        webUI.gui[item].setVisibility(visibility)
    end
end

function WebUIManager.changeState(state)
    Logger.info("WebUI", "start state change")
    if state == nil then
        Logger.err("WebUI", "Nil state in change state")
        return
    elseif webUI[state] == nil then
        Logger.err("WebUI", "Unknown state "..state.." in change state")
        return
    end

    for name, ui in ipairs(webUI.gui) do
        if webUI[state][name] == nil then -- if we doesn't found the gui in the current state
            ui.hide() -- Foo.hide() interface function
        else
            ui.setVisibility(webUI[ui][state].default)
            -- TODO propagate change to gui element so they can have advanced reaction (show winner on scoreboard on a future win state)
            -- ui.changeState(state)
        end
    end
end