Ext.Require("Globals.lua")

local statusText

Mods.BG3MCM.IMGUIAPI:InsertModMenuTab(RNOT.UUID, "General", function(tabHeader)
    tabHeader:AddText("Status:")
    statusText = Mods.BG3MCM.TextIMGUIWidget:new(tabHeader, { Id = "RBOT_ReassignStatus" }, "Ready", RNOT.UUID)
    local reassignButton = tabHeader:AddButton("Execute")

    reassignButton.OnClick = function()
        local character = MCM.Get("reassign_to")

        if character == "Select a character" then
            statusText:UpdateCurrentValue("No character selected!")
            return
        end

        statusText:UpdateCurrentValue("Processing...")
        Ext.ClientNet.PostMessageToServer("reassign_thay", character)
    end
end)

Ext.RegisterNetListener("reassign_status_update", function(_, payload)
    local newStatus = Ext.Json.Parse(payload).status
    statusText:UpdateCurrentValue(newStatus)
end)
