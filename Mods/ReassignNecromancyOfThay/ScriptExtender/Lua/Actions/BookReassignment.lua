local BookReassignment = {}

local Utils = Ext.Require("Utils/_init.lua")
local Constants = Utils.Constants
local Helpers = Utils.Helpers

function BookReassignment.RemoveTwistedBinding()
    Osi.RemoveStatus(Constants.S_FOR_DangerousBook_Tome, Constants.FOR_DANGEROUSBOOK_BOUNDTO)
end

--- Reassigns the Book of Thay to a character and sets the appropriate flags
---@param characterName string The name of the character to target
---@param setRead boolean Whether to set the "SuccessfullyRead" and "FailedToRead" flags
---@return boolean success Returns true if reassignment was successful
function BookReassignment.Reassign(characterName, setRead)
    local uuid = Helpers.GetUUID(characterName)
    if not uuid then
        Ext.Utils.Utils.PrintError("Failed to resolve UUID for character: " .. tostring(characterName))
        return false
    end

    if not Helpers.ValidateUUID(uuid) then
        Ext.Utils.PrintError("UUID validation failed for: " .. tostring(uuid))
        return false
    end

    Osi.ToInventory(Constants.S_FOR_DangerousBook_Tome, uuid)

    if not Osi.IsInInventoryOf(Constants.S_FOR_DangerousBook_Tome, uuid) then
        Ext.Utils.PrintError("Failed to move the Book of Thay to " .. uuid)
        return false
    end

    Osi.SetFlag(Constants.FOR_DangerousBook_State_BookOwner, uuid)

    if setRead then
        Osi.ClearFlag(Constants.FOR_DangerousBook_State_FailedToRead, uuid)
        Osi.SetFlag(Constants.FOR_DangerousBook_State_SuccessfullyRead, uuid)
    end

    return true
end

return BookReassignment
