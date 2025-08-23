-- Listener for handling Tharchiate Blessing addition/removal via MCM

Ext.Require("Globals.lua")
local Utils = Ext.Require("Utils/_init.lua")
local Actions = Ext.Require("Actions/_init.lua")
local Helpers = Utils.Helpers
local Constants = Utils.Constants
local TharchiateActions = Actions.TharchiateBlessing

local function updateBlessingStatus(msg)
    Ext.ServerNet.BroadcastMessage("tharchiate_blessing_status_update", Ext.Json.Stringify({ status = msg }))
end

Ext.RegisterNetListener("update_tharchiate_blessing", function(_, payload)
    local data = Ext.Json.Parse(payload)
    local characterName = data.character
    local action = data.action -- "Add" or "Remove"

    local characterUUID = Helpers.GetUUID(characterName)
    if not Helpers.ValidateUUID(characterUUID) then
        local errorMsg = "Error: Could not find character '" .. characterName .. "'."
        updateBlessingStatus(errorMsg)
        Ext.Utils.PrintError("Tharchiate Blessing update failed: Could not resolve UUID for " .. characterName)
        return
    end

    Ext.Utils.Print(string.format("Processing request to %s Tharchiate Blessing for %s (%s)", action, characterName, characterUUID))
    updateBlessingStatus("Processing...")

    local statusId = Constants.Status_Tharchiate_Blessing_Technical
    local statusMessage = ""

    if action == "Add" then
        TharchiateActions.Add(characterUUID, statusId)
        statusMessage = "Tharchiate Blessing added to " .. characterName
    elseif action == "Remove" then
        TharchiateActions.Remove(characterUUID, statusId)
        statusMessage = "Tharchiate Blessing removed from " .. characterName
    end

    updateBlessingStatus(statusMessage)
    Ext.Utils.Print(statusMessage)

end) 