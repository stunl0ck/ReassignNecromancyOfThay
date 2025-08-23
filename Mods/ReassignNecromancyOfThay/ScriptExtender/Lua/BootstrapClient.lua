Ext.Require("Globals.lua")

local statusText
local danseStatusText
local tharchiateStatusText
local forbiddenKnowledgeStatusText
local cheekyQuasitStatusText

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

Mods.BG3MCM.IMGUIAPI:InsertModMenuTab(RNOT.UUID, "Danse Macabre", function(tabHeader)
    tabHeader:AddText("Status:")
    danseStatusText = Mods.BG3MCM.TextIMGUIWidget:new(tabHeader, { Id = "RNOT_DanseStatus" }, "Ready", RNOT.UUID)
    
    -- Add Button
    local addSpellButton = tabHeader:AddButton("Add Spell")
    addSpellButton.OnClick = function()
        local character = MCM.Get("danse_macabre_character")

        if character == "Select a character" then
            danseStatusText:UpdateCurrentValue("No character selected!")
            return
        end

        danseStatusText:UpdateCurrentValue("Adding spell...")
        Ext.ClientNet.PostMessageToServer("update_danse_macabre", Ext.Json.Stringify({ character = character, action = "Add" }))

        MCM.Set("danse_macabre_character", "Select a character") -- Reset dropdown
    end

    -- Remove Button
    local removeSpellButton = tabHeader:AddButton("Remove Spell")
    removeSpellButton.OnClick = function()
        local character = MCM.Get("danse_macabre_character")

        if character == "Select a character" then
            danseStatusText:UpdateCurrentValue("No character selected!")
            return
        end

        danseStatusText:UpdateCurrentValue("Removing spell...")
        Ext.ClientNet.PostMessageToServer("update_danse_macabre", Ext.Json.Stringify({ character = character, action = "Remove" }))
        
        MCM.Set("danse_macabre_character", "Select a character") -- Reset dropdown
    end
end)

Mods.BG3MCM.IMGUIAPI:InsertModMenuTab(RNOT.UUID, "Tharchiate Blessing", function(tabHeader)
    tabHeader:AddText("Status:")
    tharchiateStatusText = Mods.BG3MCM.TextIMGUIWidget:new(tabHeader, { Id = "RNOT_TharchiateStatus" }, "Ready", RNOT.UUID)
    
    -- Add Button
    local addBlessingButton = tabHeader:AddButton("Add Blessing")
    addBlessingButton.OnClick = function()
        local character = MCM.Get("tharchiate_blessing_character")

        if character == "Select a character" then
            tharchiateStatusText:UpdateCurrentValue("No character selected!")
            return
        end

        tharchiateStatusText:UpdateCurrentValue("Adding blessing...")
        Ext.ClientNet.PostMessageToServer("update_tharchiate_blessing", Ext.Json.Stringify({ character = character, action = "Add" }))

        MCM.Set("tharchiate_blessing_character", "Select a character") -- Reset dropdown
    end

    -- Remove Button
    local removeBlessingButton = tabHeader:AddButton("Remove Blessing")
    removeBlessingButton.OnClick = function()
        local character = MCM.Get("tharchiate_blessing_character")

        if character == "Select a character" then
            tharchiateStatusText:UpdateCurrentValue("No character selected!")
            return
        end

        tharchiateStatusText:UpdateCurrentValue("Removing blessing...")
        Ext.ClientNet.PostMessageToServer("update_tharchiate_blessing", Ext.Json.Stringify({ character = character, action = "Remove" }))
        
        MCM.Set("tharchiate_blessing_character", "Select a character") -- Reset dropdown
    end
end)

Mods.BG3MCM.IMGUIAPI:InsertModMenuTab(RNOT.UUID, "Forbidden Knowledge", function(tabHeader)
    tabHeader:AddText("Status:")
    forbiddenKnowledgeStatusText = Mods.BG3MCM.TextIMGUIWidget:new(tabHeader, { Id = "RNOT_ForbiddenKnowledgeStatus" }, "Ready", RNOT.UUID)
    
    -- Add Button
    local addPassiveButton = tabHeader:AddButton("Add Passive")
    addPassiveButton.OnClick = function()
        local character = MCM.Get("forbidden_knowledge_character")

        if character == "Select a character" then
            forbiddenKnowledgeStatusText:UpdateCurrentValue("No character selected!")
            return
        end

        forbiddenKnowledgeStatusText:UpdateCurrentValue("Adding passive...")
        Ext.ClientNet.PostMessageToServer("update_forbidden_knowledge", Ext.Json.Stringify({ character = character, action = "Add" }))

        MCM.Set("forbidden_knowledge_character", "Select a character") -- Reset dropdown
    end

    -- Remove Button
    local removePassiveButton = tabHeader:AddButton("Remove Passive")
    removePassiveButton.OnClick = function()
        local character = MCM.Get("forbidden_knowledge_character")

        if character == "Select a character" then
            forbiddenKnowledgeStatusText:UpdateCurrentValue("No character selected!")
            return
        end

        forbiddenKnowledgeStatusText:UpdateCurrentValue("Removing passive...")
        Ext.ClientNet.PostMessageToServer("update_forbidden_knowledge", Ext.Json.Stringify({ character = character, action = "Remove" }))
        
        MCM.Set("forbidden_knowledge_character", "Select a character") -- Reset dropdown
    end
end)

Mods.BG3MCM.IMGUIAPI:InsertModMenuTab(RNOT.UUID, "Cheeky Quasit", function(tabHeader)
    tabHeader:AddText("Status:")
    cheekyQuasitStatusText = Mods.BG3MCM.TextIMGUIWidget:new(tabHeader, { Id = "RNOT_CheekyQuasitStatus" }, "Ready", RNOT.UUID)
    
    -- Add Button
    local addSpellButton = tabHeader:AddButton("Add Spell")
    addSpellButton.OnClick = function()
        local character = MCM.Get("cheeky_quasit_character")

        if character == "Select a character" then
            cheekyQuasitStatusText:UpdateCurrentValue("No character selected!")
            return
        end

        cheekyQuasitStatusText:UpdateCurrentValue("Adding spell...")
        Ext.ClientNet.PostMessageToServer("update_cheeky_quasit", Ext.Json.Stringify({ character = character, action = "Add" }))

        MCM.Set("cheeky_quasit_character", "Select a character") -- Reset dropdown
    end

    -- Remove Button
    local removeSpellButton = tabHeader:AddButton("Remove Spell")
    removeSpellButton.OnClick = function()
        local character = MCM.Get("cheeky_quasit_character")

        if character == "Select a character" then
            cheekyQuasitStatusText:UpdateCurrentValue("No character selected!")
            return
        end

        cheekyQuasitStatusText:UpdateCurrentValue("Removing spell...")
        Ext.ClientNet.PostMessageToServer("update_cheeky_quasit", Ext.Json.Stringify({ character = character, action = "Remove" }))
        
        MCM.Set("cheeky_quasit_character", "Select a character") -- Reset dropdown
    end
end)

Ext.RegisterNetListener("reassign_status_update", function(_, payload)
    local newStatus = Ext.Json.Parse(payload).status
    statusText:UpdateCurrentValue(newStatus)
end)

Ext.RegisterNetListener("danse_macabre_status_update", function(_, payload)
    local newStatus = Ext.Json.Parse(payload).status
    -- Ensure status text widget exists before updating
    if danseStatusText then
        danseStatusText:UpdateCurrentValue(newStatus)
    end
end)

Ext.RegisterNetListener("tharchiate_blessing_status_update", function(_, payload)
    local newStatus = Ext.Json.Parse(payload).status
    -- Ensure status text widget exists before updating
    if tharchiateStatusText then
        tharchiateStatusText:UpdateCurrentValue(newStatus)
    end
end)

Ext.RegisterNetListener("forbidden_knowledge_status_update", function(_, payload)
    local newStatus = Ext.Json.Parse(payload).status
    if forbiddenKnowledgeStatusText then
        forbiddenKnowledgeStatusText:UpdateCurrentValue(newStatus)
    end
end)

Ext.RegisterNetListener("cheeky_quasit_status_update", function(_, payload)
    local newStatus = Ext.Json.Parse(payload).status
    if cheekyQuasitStatusText then
        cheekyQuasitStatusText:UpdateCurrentValue(newStatus)
    end
end)
