local ForbiddenKnowledgeActions = {}

--- Adds the Forbidden Knowledge passive to a character
---@param characterUUID string The UUID of the target character
---@param passiveId string The ID of the passive to add
function ForbiddenKnowledgeActions.Add(characterUUID, passiveId)
    Osi.AddPassive(characterUUID, passiveId)
end

--- Removes the Forbidden Knowledge passive from a character
---@param characterUUID string The UUID of the target character
---@param passiveId string The ID of the passive to remove
function ForbiddenKnowledgeActions.Remove(characterUUID, passiveId)
    Osi.RemovePassive(characterUUID, passiveId)
end

return ForbiddenKnowledgeActions