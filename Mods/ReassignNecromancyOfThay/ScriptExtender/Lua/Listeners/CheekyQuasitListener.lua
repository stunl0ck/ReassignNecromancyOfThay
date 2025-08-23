-- Listener for handling Cheeky Quasit spell addition/removal via MCM

Ext.Require("Globals.lua")
local Utils = Ext.Require("Utils/_init.lua")
local Actions = Ext.Require("Actions/_init.lua")
local Helpers = Utils.Helpers
local Constants = Utils.Constants
local CheekyQuasitActions = Actions.CheekyQuasit

local function updateCheekyQuasitStatus(msg)
    Ext.ServerNet.BroadcastMessage("cheeky_quasit_status_update", Ext.Json.Stringify({ status = msg }))
end

Ext.RegisterNetListener("update_cheeky_quasit", function(_, payload)
    local data = Ext.Json.Parse(payload)
    local characterName = data.character
    local action = data.action -- "Add" or "Remove"

    local characterUUID = Helpers.GetUUID(characterName)
    if not Helpers.ValidateUUID(characterUUID) then
        local errorMsg = "Error: Could not find character '" .. characterName .. "'."
        updateCheekyQuasitStatus(errorMsg)
        Ext.Utils.PrintError("Cheeky Quasit update failed: Could not resolve UUID for " .. characterName)
        return
    end

    Ext.Utils.Print(string.format("Processing request to %s Cheeky Quasit for %s (%s)", action, characterName, characterUUID))
    updateCheekyQuasitStatus("Processing...")

    local spellId = Constants.Spell_Cheeky_Quasit
    local statusMessage = ""

    if action == "Add" then
        CheekyQuasitActions.Add(characterUUID, spellId)
        statusMessage = "Find Familiar: Cheeky Quasit added to " .. characterName
    elseif action == "Remove" then
        CheekyQuasitActions.Remove(characterUUID, spellId)
        statusMessage = "Find Familiar: Cheeky Quasit removed from " .. characterName
    end

    updateCheekyQuasitStatus(statusMessage)
    Ext.Utils.Print(statusMessage)

end)