-- Listener for handling Forbidden Knowledge passive addition/removal via MCM

Ext.Require("Globals.lua")
local Utils = Ext.Require("Utils/_init.lua")
local Actions = Ext.Require("Actions/_init.lua")
local Helpers = Utils.Helpers
local Constants = Utils.Constants
local ForbiddenKnowledgeActions = Actions.ForbiddenKnowledge

local function updateForbiddenKnowledgeStatus(msg)
    Ext.ServerNet.BroadcastMessage("forbidden_knowledge_status_update", Ext.Json.Stringify({ status = msg }))
end

Ext.RegisterNetListener("update_forbidden_knowledge", function(_, payload)
    local data = Ext.Json.Parse(payload)
    local characterName = data.character
    local action = data.action -- "Add" or "Remove"

    local characterUUID = Helpers.GetUUID(characterName)
    if not Helpers.ValidateUUID(characterUUID) then
        local errorMsg = "Error: Could not find character '" .. characterName .. "'."
        updateForbiddenKnowledgeStatus(errorMsg)
        Ext.Utils.PrintError("Forbidden Knowledge update failed: Could not resolve UUID for " .. characterName)
        return
    end

    Ext.Utils.Print(string.format("Processing request to %s Forbidden Knowledge for %s (%s)", action, characterName, characterUUID))
    updateForbiddenKnowledgeStatus("Processing...")

    local passiveId = Constants.Passive_Forbidden_Knowledge
    local statusMessage = ""

    if action == "Add" then
        ForbiddenKnowledgeActions.Add(characterUUID, passiveId)
        statusMessage = "Forbidden Knowledge added to " .. characterName
    elseif action == "Remove" then
        ForbiddenKnowledgeActions.Remove(characterUUID, passiveId)
        statusMessage = "Forbidden Knowledge removed from " .. characterName
    end

    updateForbiddenKnowledgeStatus(statusMessage)
    Ext.Utils.Print(statusMessage)

end)