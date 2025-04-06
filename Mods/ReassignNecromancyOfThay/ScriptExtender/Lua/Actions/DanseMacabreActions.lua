local DanseMacabreActions = {}

--- Adds the Danse Macabre spell to a character
---@param characterUUID string The UUID of the target character
---@param spellId string The ID of the spell to add
function DanseMacabreActions.Add(characterUUID, spellId)
    Osi.AddSpell(characterUUID, spellId)
end

--- Removes the Danse Macabre spell from a character
---@param characterUUID string The UUID of the target character
---@param spellId string The ID of the spell to remove
function DanseMacabreActions.Remove(characterUUID, spellId)
    Osi.RemoveSpell(characterUUID, spellId)
end

return DanseMacabreActions 