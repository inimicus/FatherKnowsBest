-- -----------------------------------------------------------------------------
-- Father Knows Best
-- Author:  g4rr3t
-- Created: February 6, 2018
--
-- SlashCommands.lua
-- -----------------------------------------------------------------------------

local LSC = LibStub("LibSlashCommander")

local function OfferWisdom(input)

    -- If no Wisdom saved
    if (#FKB.GetKeys(FKB.preferences.wisdom) < 1) then
        d('No Wisdom Found!')
        return
    end

    if (input) then
        FKB.SpreadSpecific(input)
    else
        FKB.SpreadRandom()
    end
end


-- -----------------------------------------------------------------------------
-- Initialize Slash Commands
-- -----------------------------------------------------------------------------

function FKB.InitSlashCommands()
    local c = LSC:Register()
    c:AddAlias("/wisdom")
    c:SetCallback(function(input) OfferWisdom(input) end)
    c:SetDescription("Spread wisdom!") 
    c:SetAutoComplete(FKB.GetKeys(FKB.preferences.wisdom))
end

