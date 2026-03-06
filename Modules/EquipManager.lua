local _, Addon = ...

SLASH_REPLUS1 = "/replus"
SlashCmdList["REPLUS"] = function()
	Settings.OpenToCategory(Addon.SettingsCategoryId)

	DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[Replus]|r help:")

	DEFAULT_CHAT_FRAME:AddMessage("- |cffff8000/showsets|r - Show all sets")
	DEFAULT_CHAT_FRAME:AddMessage("- |cffff8000/delset|r |cffffff00name|r - Delete a set")
	DEFAULT_CHAT_FRAME:AddMessage("- |cffff8000/saveset|r |cffffff00name|r - Save current gear as a set")
	DEFAULT_CHAT_FRAME:AddMessage("- |cffff8000/saveweapons|r |cffffff00name|r - Save current weapons as a set")
	DEFAULT_CHAT_FRAME:AddMessage("- |cffff8000/equipset|r |cffffff00name|r - Equip a set")
end

SLASH_SHOWSETS1 = "/showsets"
SLASH_SHOWSETS2 = "/getsets"
SLASH_SHOWSETS3 = "/allsets"
SlashCmdList["SHOWSETS"] = function()
	DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[Replus]|r showing all sets:")

	for _, id in pairs(C_EquipmentSet.GetEquipmentSetIDs()) do
		local name = C_EquipmentSet.GetEquipmentSetInfo(id)
		DEFAULT_CHAT_FRAME:AddMessage("- |cff00ff00" .. name .. "|r")
	end
end

SLASH_DELSET1 = "/delset"
SlashCmdList["DELSET"] = function(set)
	C_EquipmentSet.DeleteEquipmentSet(C_EquipmentSet.GetEquipmentSetID(set))

	DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[Replus]|r |cff00ff00" .. set .. "|r set deleted")
end

SLASH_SAVESET1 = "/saveset"
SlashCmdList["SAVESET"] = function(set)
	C_EquipmentSet.ClearIgnoredSlotsForSave()
	C_EquipmentSet.CreateEquipmentSet(set)
	C_EquipmentSet.SaveEquipmentSet(C_EquipmentSet.GetEquipmentSetID(set))

	DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[Replus]|r |cff00ff00" .. set .. "|r set saved")
end

SLASH_SAVEWEAPONS1 = "/savew"
SLASH_SAVEWEAPONS2 = "/saveweap"
SLASH_SAVEWEAPONS3 = "/saveweapon"
SLASH_SAVEWEAPONS4 = "/saveweapons"
SlashCmdList["SAVEWEAPONS"] = function(set)
	C_EquipmentSet.ClearIgnoredSlotsForSave()
	C_EquipmentSet.CreateEquipmentSet(set)
	for i = 1, 19 do
		if i ~= 16 and i ~= 17 then C_EquipmentSet.IgnoreSlotForSave(i) end
	end
	C_EquipmentSet.SaveEquipmentSet(C_EquipmentSet.GetEquipmentSetID(set))

	DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[Replus]|r |cff00ff00" .. set .. "|r weapons set saved")
end
