Constants = Ext.Require("Utils/Constants.lua")

local Helpers = {}

function Helpers.ValidateUUID(uuid)
    if not uuid or uuid == "" then
        return false
    end
    return true
end

function Helpers.GetUUID(characterName)
    local uuid
    if characterName == "Host Character" then
        uuid = Osi.GetHostCharacter()
    elseif characterName == "Tav" then
        uuid = Osi.DB_Avatars:Get(nil)[1][1]
    else
        uuid = Constants.CharacterNames[characterName]
    end
    Ext.Utils.Print("Resolved '" .. tostring(characterName) .. "' to UUID: " .. (type(uuid) == "string" and uuid or TableToString(uuid or "nil")))
    return uuid
end

function Helpers.HasTwistedBinding()
    return Osi.HasActiveStatus(Constants.S_FOR_DangerousBook_Tome, Constants.FOR_DANGEROUSBOOK_BOUNDTO) == 1
end

return Helpers
