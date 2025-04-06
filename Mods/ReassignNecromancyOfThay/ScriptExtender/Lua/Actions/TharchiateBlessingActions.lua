local TharchiateBlessingActions = {}

--- Adds the Tharchiate Blessing technical status to a character
---@param characterUUID string The UUID of the target character
---@param statusId string The ID of the status to add
function TharchiateBlessingActions.Add(characterUUID, statusId)
    Osi.ApplyStatus(characterUUID, statusId, -1) -- -1 duration for permanent/passive
end

--- Removes the Tharchiate Blessing technical status from a character
---@param characterUUID string The UUID of the target character
---@param statusId string The ID of the status to remove
function TharchiateBlessingActions.Remove(characterUUID, statusId)
    Osi.RemoveStatus(characterUUID, statusId)
end

return TharchiateBlessingActions 