Ext.Require("Globals.lua")

if not Ext.Mod.IsModLoaded(MCMUUID) then
    Ext.Utils.PrintError(RNOT.modTableKey .. " requires Mod Configuration Menu (MCM) to function.")
end

Ext.Require("Listeners/_init.lua") 