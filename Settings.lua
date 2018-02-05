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
        --requiresReload = true,
        width = "full",
    },
    [3] = {
        type = "header",
        name = "Add Wisdom",
        width = "full", --or "half" (optional)
    },
    [4] = {
        type = "editbox",
        name = "Wisdom Name",
        tooltip = "Name of Wisdom that is used to reference the phrase (in a future update).",
        getFunc = function() return "" end,
        setFunc = function(text) newPhrase.title = text end,
        isMultiline = false,
        width = "full",
        default = "",
    },
    [5] = {
        type = "editbox",
        name = "Wisdom Phrase",
        tooltip = "Text for wisdom. Do not include line breaks.",
        getFunc = function() return "" end,
        setFunc = function(text) newPhrase.phrase = text end,
        isMultiline = true,
        width = "full",
        default = "",
    },
    [6] = {
        type = "button",
        name = "Add",
        tooltip = "Add new Wisdom text.",
        func = function() SaveWisdom() end,
        width = "full",
    },
    [7] = {
        type = "header",
        name = "Manage Wisdom",
        width = "full", --or "half" (optional)
    },
    [8] = {
        type = "description",
        title = "TODO",	--(optional)
        text = "Editing and managing wisdom coming in a future update. In the meantime, you will see feedback about your added wisdom in the chat log. To remove or edit wisdom, logout and edit |cFFCCCCSavedVariables/FatherKnowsBest.lua|r. More work is needed as LibAddonMenu 2.0 does not provide dynamic selection boxes built-in.",
        width = "full",	--or "half" (optional)
    },
    --[8] = {
    --    type = "dropdown",
    --    name = "Wisdom Name",
    --    tooltip = "Name of stored Wisdom. Wisdom will appear in text box.",
    --    --choices = {"And that's why I'm Father of the Year", "of", "choices"},
    --    choices = Phrases,
    --    getFunc = function() return "Local Empty" end,
    --    setFunc = function(var) print(var) end,
	--	--scrollable = true,
	--	sort = "name-down",
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

