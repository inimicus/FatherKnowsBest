-- -----------------------------------------------------------------------------
-- Father Knows Best
-- Author:  g4rr3t
-- Created: February 4, 2018
--
-- Settings.lua
-- -----------------------------------------------------------------------------

local LAM = LibStub("LibAddonMenu-2.0")

local newPhrase = {}
local editPhrase = {}
local Phrases = {}

local panelData = {
    type        = "panel",
    name        = "Father Knows Best",
    displayName = "Father Knows Best",
    author      = "g4rr3t",
	slashCommand = "/father",
    version     = FKB.version,
    registerForRefresh  = true,
}

local optionsTable = {
    [1] = {
        type = "description",
        text = "Options for spreading Father's Wisdom. Set keybind in Controls menu.",
        width = "full",
    },
    [2] = {
        type = "checkbox",
        name = "Auto Select Reply Target",
        tooltip = "Automatically switch to reply mode to the last whisperer. If set to off or there have been no whispers since the last UI reload, message will be output to active chat tab.",
        getFunc = function() return GetAutoSelect() end,
        setFunc = function(value) SetAutoSelect(value) end,
        width = "full",
    },
    [3] = {
        type = "checkbox",
        name = "Select Random Wisdom",
        tooltip = "When the keybind is pressed, automatically select a random wisdom.",
        getFunc = function() return GetBindRandom() end,
        setFunc = function(value) SetBindRandom(value) end,
        width = "full",
    },
    [4] = {
        type = "description",
        --title = "TODO",
        text = "When the keybind is pressed and |cFFCCCCSelect Random Wisdom|r is toggled |cC5C39DON|r, a random wisdom will be automatically picked and output to chat. Otherwise, the keybind will open chat and allow you to type/select the name of the wisdom you'd like to spread.",
        width = "full",
    },
    [5] = {
        type = "header",
        name = "Add Wisdom",
        width = "full",
    },
    [6] = {
        type = "editbox",
        name = "Wisdom Name",
        tooltip = "Name of Wisdom that is used to reference the phrase (in a future update).",
        getFunc = function() return "" end,
        setFunc = function(text) newPhrase.title = text end,
        isMultiline = false,
        width = "full",
        default = "",
    },
    [7] = {
        type = "editbox",
        name = "Wisdom Phrase",
        tooltip = "Text for wisdom. Do not include line breaks.",
        getFunc = function() return "" end,
        setFunc = function(text) newPhrase.phrase = text end,
        isMultiline = true,
        width = "full",
        default = "",
    },
    [8] = {
        type = "button",
        name = "Add",
        tooltip = "Add new Wisdom text.",
        func = function() SaveWisdom() end,
        width = "full",
    },
    [9] = {
        type = "description",
        title = "Note:",
        text = "After adding phrases, the UI must be reloaded for options to appear in the autocomplete menu.",
        width = "full",
    },
    [10] = {
        type = "header",
        name = "Manage Wisdom",
        width = "full",
    },
    [11] = {
        type = "description",
        title = "TODO", --(optional)
        text = "Editing and managing wisdom coming in a future update. In the meantime, you will see feedback about your added wisdom in the chat log. To remove or edit wisdom, logout and edit |cFFCCCCSavedVariables/FatherKnowsBest.lua|r. More work is needed as LibAddonMenu 2.0 does not provide dynamic selection boxes built-in.",
        width = "full",
    },
    --[8] = {
    --    type = "dropdown",
    --    name = "Wisdom Name",
    --    tooltip = "Name of stored Wisdom. Wisdom will appear in text box.",
    --    --choices = {"And that's why I'm Father of the Year", "of", "choices"},
    --    choices = Phrases,
    --    getFunc = function() return "Local Empty" end,
    --    setFunc = function(var) print(var) end,
    --  sort = "name-down",
    --    width = "full",
    --},
    --[9] = {
    --    type = "editbox",
    --    name = "Wisdom Phrase",
    --    tooltip = "Text for additional Wisdom.",
    --    getFunc = function() return "" end,
    --    setFunc = function(text) print(text) end,
    --    isMultiline = true,
    --    width = "full",
    --    default = "",
    --},
    --[10] = {
    --    type = "button",
    --    name = "Save",
    --    tooltip = "Update and save displayed Wisdom text.",
    --    func = function() d("button pressed!") end,
    --    width = "half",
    --},
    --[11] = {
    --    type = "button",
    --    name = "Delete",
    --    tooltip = "Delete saved Wisdom.",
    --    func = function() d("button pressed!") end,
    --    width = "half",
    --},
}

-- -----------------------------------------------------------------------------
-- Settings Functions
-- -----------------------------------------------------------------------------

function GetBindRandom()
    return FKB.preferences.bindRandom
end

function SetBindRandom(value)
    FKB.preferences.bindRandom = value
end

function GetAutoSelect()
    return FKB.preferences.autoSelect
end

function SetAutoSelect(value)
    FKB.preferences.autoSelect = value
end

function SaveWisdom()
    FKB.preferences.wisdom[newPhrase.title] = newPhrase.phrase
    d("Added Wisdom: " .. newPhrase.phrase)
    newPhrase = {}
end

function PopulatePhrases()
    local wisdom = FKB.preferences.wisdom
    local keys = {}

    for k in pairs(wisdom) do
        table.insert(keys, k)
    end

    --d(keys)
    Phrases = keys
end

-- -----------------------------------------------------------------------------
-- Initialize Settings
-- -----------------------------------------------------------------------------

function FKB.InitSettings()
    LAM:RegisterAddonPanel(FKB.name, panelData)
    PopulatePhrases()
    LAM:RegisterOptionControls(FKB.name, optionsTable)
end

