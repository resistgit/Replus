local _, Addon = ...

SLASH_REPLUS1 = "/replus"
SlashCmdList["REPLUS"] = function()
	Settings.OpenToCategory(Addon.SettingsCategoryId)

	DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[Replus]|r help:")

	DEFAULT_CHAT_FRAME:AddMessage("- |cffff8000/showsets|r - Show all sets")
	DEFAULT_CHAT_FRAME:AddMessage("- |cffff8000/delset|r |cffffff00name|r - Delete a set")
	DEFAULT_CHAT_FRAME:AddMessage("- |cffff8000/saveset|r |cffffff00name|r - Save current gear as a set")
	DEFAULT_CHAT_FRAME:AddMessage("- |cffff8000/saveweapons|r |cffffff00name|r - Save current weapons as a set")
	DEFAULT_CHAT_FRAME:AddMessage("- |cffff8000/saveslots|r |cffffff00name|r |cffffff00slots|r - Save slots as a set")
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
	C_EquipmentSet.IgnoreSlotForSave(INVSLOT_BODY) -- ignore shirt
	C_EquipmentSet.IgnoreSlotForSave(INVSLOT_TABARD) -- ignore tabard
	C_EquipmentSet.SaveEquipmentSet(C_EquipmentSet.GetEquipmentSetID(set))

	DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[Replus]|r |cff00ff00" .. set .. "|r set saved")
end

---@param set string
---@param slots table
local function saveSlots(set, slots)
	C_EquipmentSet.ClearIgnoredSlotsForSave()
	C_EquipmentSet.CreateEquipmentSet(set)
	for i = 1, 19 do
		if slots[i] == nil then
			C_EquipmentSet.IgnoreSlotForSave(i)
		end
	end
	C_EquipmentSet.SaveEquipmentSet(C_EquipmentSet.GetEquipmentSetID(set))
end

SLASH_SAVEWEAPONS1 = "/savew"
SLASH_SAVEWEAPONS1 = "/savewp"
SLASH_SAVEWEAPONS3 = "/saveweapon"
SLASH_SAVEWEAPONS4 = "/saveweapons"
SlashCmdList["SAVEWEAPONS"] = function(set)
	saveSlots(set, { 16, 17 })
	DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[Replus]|r |cff00ff00" .. set .. "|r weapons set saved")
end

---@param opts string
---@return string?
---@return table?
local function parseSlots(opts)
	local set = ""
	local slots = {}
	local i = 1
	for str in string.gmatch(opts, "[^,%s]+") do
		if i == 1 then
			set = str
		else
			local slot = tonumber(str)
			if slot == nil or slot < 1 or slot > 19 then
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[Replus]|r slot number not recognized")
				return nil, nil
			end

			slots[slot] = 0
		end
		i = i + 1
	end
	return set, slots
end

SLASH_SAVESLOTS1 = "/saveslots"
SlashCmdList["SAVESLOTS"] = function(opts)
	local set, slots = parseSlots(opts)
	if set == nil or slots == nil then
		return
	end

	saveSlots(set, slots)
	DEFAULT_CHAT_FRAME:AddMessage("|cffffff00[Replus]|r |cff00ff00" .. set .. "|r set saved")
end
