-- -----------------------------------------------------------------------------
-- Father Knows Best
-- Author:  g4rr3t
-- Created: February 4, 2018
--
-- FatherKnowsBest.lua
-- -----------------------------------------------------------------------------
FKB             = {}
FKB.name        = "FatherKnowsBest"
FKB.version     = "1.0.1"
FKB.dbVersion   = 1
FKB.saltySailor = nil

FKB.defaults = {
    autoSelect = true,
    bindRandom = true,
    wisdom = {}
}

-- -----------------------------------------------------------------------------
-- Startup
-- -----------------------------------------------------------------------------

function FKB.Initialize(event, addonName)
    if addonName ~= FKB.name then return end

    -- Unregister Addon Loaded event
    EVENT_MANAGER:UnregisterForEvent(FKB.name, EVENT_ADD_ON_LOADED)

    -- Add Keybind option to Controls
    ZO_CreateStringId("SI_BINDING_NAME_SPREAD_WISDOM", "Spread Wisdom")

    -- Load/create saved variables
    FKB.preferences = ZO_SavedVars:New("FatherKnowsBestWisdom", FKB.dbVersion, nil, FKB.defaults)

    -- Init Additional Parts
    FKB.InitSettings()
    FKB.InitSlashCommands()
end


function FKB.SpreadWisdom()

    -- If no Wisdom saved
    if (#FKB.GetKeys(FKB.preferences.wisdom) < 1) then
        d('No Wisdom Found!')
        return
    end

    -- If we should auto select reply target
    -- AND we've received salt recently
    if (FKB.preferences.autoSelect and FKB.saltySailor) then
        StartChatInput("", CHAT_CHANNEL_WHISPER, FKB.saltySailor)
    else
        StartChatInput("")
    end

    -- If we should pick a random phrase
    -- or open it up for completion
    if (FKB.preferences.bindRandom) then
        FKB.SpreadRandom()
    else
        CHAT_SYSTEM.textEntry:Open("/wisdom ")
    end

end


function FKB.SpreadSpecific(selection)
    CHAT_SYSTEM.textEntry:Open(FKB.preferences.wisdom[selection])
end

function FKB.SpreadRandom()
    CHAT_SYSTEM.textEntry:Open(FKB.GetRandom(FKB.preferences.wisdom))
end

function FKB.DidReceiveWhisper(id, type, name, text)
    if type == CHAT_CHANNEL_WHISPER then
        FKB.saltySailor = name
    end
end

function FKB.GetRandom(selection)
    local keys = FKB.GetKeys(selection)
    return selection[keys[math.random(#keys)]]
end

function FKB.GetKeys(selection)
    local keys = {}
    for k in pairs(selection) do
        table.insert(keys, k)
    end
    return keys
end

-- -----------------------------------------------------------------------------
-- Event Hooks
-- -----------------------------------------------------------------------------

EVENT_MANAGER:RegisterForEvent(FKB.name, EVENT_ADD_ON_LOADED, function(...) FKB.Initialize(...) end)
EVENT_MANAGER:RegisterForEvent(FKB.name, EVENT_CHAT_MESSAGE_CHANNEL, function(...) FKB.DidReceiveWhisper(...) end)

