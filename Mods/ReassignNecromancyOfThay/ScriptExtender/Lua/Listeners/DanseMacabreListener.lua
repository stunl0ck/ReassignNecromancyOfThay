-- Listener for handling Danse Macabre spell addition/removal via MCM

Ext.Require("Globals.lua")
local Utils = Ext.Require("Utils/_init.lua")
local Actions = Ext.Require("Actions/_init.lua") -- Load Actions table
local Helpers = Utils.Helpers
local Constants = Utils.Constants
local DanseMacabreActions = Actions.DanseMacabre -- Get specific actions

-- Helper to send status updates to the client
local function updateDanseStatus(msg)
    Ext.ServerNet.BroadcastMessage("danse_macabre_status_update", Ext.Json.Stringify({ status = msg }))
end

-- Listener for the client message
Ext.RegisterNetListener("update_danse_macabre", function(_, payload)
    local data = Ext.Json.Parse(payload)
    local characterName = data.character
    local action = data.action -- "Add" or "Remove"

    local characterUUID = Helpers.GetUUID(characterName)
    if not Helpers.ValidateUUID(characterUUID) then
        local errorMsg = "Error: Could not find character '" .. characterName .. "'."
        updateDanseStatus(errorMsg)
        Ext.Utils.PrintError("Danse Macabre update failed: Could not resolve UUID for " .. characterName)
        return
    end

    Ext.Utils.Print(string.format("Processing request to %s Danse Macabre for %s (%s)", action, characterName, characterUUID))
    updateDanseStatus("Processing...")

    local spellId = Constants.Spell_Danse_Macabre
    local statusMessage = ""

    if action == "Add" then
        DanseMacabreActions.Add(characterUUID, spellId)
        statusMessage = "Danse Macabre added to " .. characterName
    elseif action == "Remove" then
        DanseMacabreActions.Remove(characterUUID, spellId)
        statusMessage = "Danse Macabre removed from " .. characterName
    end

    -- Send final status update
    updateDanseStatus(statusMessage)
    Ext.Utils.Print(statusMessage) -- Log success

end) 