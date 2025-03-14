---@alias OsirisEventType "before" | "after"

local Actions = Ext.Require("Actions/_init.lua")
local Utils = Ext.Require("Utils/_init.lua")
local Helpers = Utils.Helpers

local BookReassignment = Actions.BookReassignment

local INITIAL_REASSIGNMENT_DELAY = 1000
local RECHECK_INTERVAL = 500

-- Deferred reassignment state
local REASSIGNMENT_TIMER = "ReassignmentTimer"
local ReassignmentCharacter = nil
local ReassignmentSetRead = false

local function updateStatus(msg)
    Ext.ServerNet.BroadcastMessage("reassign_status_update", Ext.Json.Stringify({ status = msg }))
end

local function setReassignmentInfo(character, set_read)
    ReassignmentCharacter, ReassignmentSetRead = character, set_read
end

local function resetReassignmentInfo()
    ReassignmentCharacter, ReassignmentSetRead = nil, false
end

local function performReassignment(character, set_read)
    local success = BookReassignment.Reassign(character, set_read)
    if success then
        resetReassignmentInfo()
        updateStatus("Assigned to " .. character)
    else
        updateStatus("Reassignment failed!")
    end
end

Ext.RegisterNetListener("reassign_thay", function(_, _)
    local character = MCM.Get("reassign_to")
    local set_read = MCM.Get("set_read")
    
    Ext.Utils.Print("Processing reassignment for: " .. character)

    if Helpers.HasTwistedBinding() then
        setReassignmentInfo(character, set_read)
        BookReassignment.RemoveTwistedBinding()
        Osi.TimerLaunch(REASSIGNMENT_TIMER, INITIAL_REASSIGNMENT_DELAY)
        updateStatus("Removing Twisted Binding...")
    else
        performReassignment(character, set_read)
    end

    MCM.Set("reassign_to", "Select a character")
end)

Ext.Osiris.RegisterListener("TimerFinished", 1, "before", function(timerName)
    if timerName ~= REASSIGNMENT_TIMER then return end

    if not ReassignmentCharacter then
        Ext.Utils.PrintWarn(REASSIGNMENT_TIMER .. " called with no character!")
        return
    end

    Ext.Utils.Print("Timer triggered. Checking if status is removed...")

    -- Check if the Twisted Binding status is gone
    if not Helpers.HasTwistedBinding() then
        performReassignment(ReassignmentCharacter, ReassignmentSetRead)            
    else
        Ext.Utils.Print("Status still active. Restarting timer.")
        Osi.TimerLaunch(REASSIGNMENT_TIMER, RECHECK_INTERVAL)
        updateStatus("Waiting...")
    end
end)
