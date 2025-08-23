local CheekyQuasitActions = {}

--- Adds the Find Familiar: Cheeky Quasit spell to a character
---@param characterUUID string The UUID of the target character
---@param spellId string The ID of the spell to add
function CheekyQuasitActions.Add(characterUUID, spellId)
    Osi.AddSpell(characterUUID, spellId)
end

--- Removes the Find Familiar: Cheeky Quasit spell from a character
---@param characterUUID string The UUID of the target character
---@param spellId string The ID of the spell to remove
function CheekyQuasitActions.Remove(characterUUID, spellId)
    Osi.RemoveSpell(characterUUID, spellId)
end

return CheekyQuasitActions