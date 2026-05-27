local _, Addon = ...

local em = C_EquipmentSet

local REPLUS = "|cffffff00[Replus]|r"
local SETNAME = "|cff00ff00%s|r"
local SET_SAVED = "|cffffff00[Replus]|r |cff00ff00%s|r set saved"
local SET_NOT_FOUND = "|cffffff00[Replus]|r ERROR: |cff00ff00%s|r set not found"
local SET_DELETED = "|cffffff00[Replus]|r |cff00ff00%s|r set deleted"
local SET_WEAPONS_SAVED = "|cffffff00[Replus]|r |cff00ff00%s|r weapons set saved"
local WRONG_SLOT = "|cffffff00[Replus]|r ERROR: slot number '%s' not recognized"

---@param set string
---@param slots table
local function saveSlots(set, slots)
	local id = em.GetEquipmentSetID(set)
	if not id then
		em.CreateEquipmentSet(set)
		id = em.GetEquipmentSetID(set)
	end

	em.ClearIgnoredSlotsForSave()

	for i = 1, 19 do
		if not slots[i] then
			em.IgnoreSlotForSave(i)
		end
	end

	em.SaveEquipmentSet(id)
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
				DEFAULT_CHAT_FRAME:AddMessage(WRONG_SLOT:format(str))
				return nil, nil
			end

			slots[slot] = true
		end
		i = i + 1
	end
	return set, slots
end

SLASH_REPLUS1 = "/replus"
SlashCmdList["REPLUS"] = function()
	Settings.OpenToCategory(Addon.SettingsCategoryId)

	DEFAULT_CHAT_FRAME:AddMessage(REPLUS .. " help:")

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
	DEFAULT_CHAT_FRAME:AddMessage(REPLUS .. "showing all sets:")

	for _, id in pairs(em.GetEquipmentSetIDs()) do
		local name = em.GetEquipmentSetInfo(id)
		DEFAULT_CHAT_FRAME:AddMessage("- " .. SETNAME:format(name))
	end
end

SLASH_DELSET1 = "/delset"
SlashCmdList["DELSET"] = function(set)
	local id = em.GetEquipmentSetID(set)
	if not id then
		DEFAULT_CHAT_FRAME:AddMessage(SET_NOT_FOUND:format(set))
		return
	end

	em.DeleteEquipmentSet(id)
	DEFAULT_CHAT_FRAME:AddMessage(SET_DELETED:format(set))
end

SLASH_SAVESET1 = "/saveset"
SlashCmdList["SAVESET"] = function(set)
	local id = em.GetEquipmentSetID(set)
	if not id then
		em.CreateEquipmentSet(set)
		id = em.GetEquipmentSetID(set)
	end

	em.ClearIgnoredSlotsForSave()

	em.IgnoreSlotForSave(INVSLOT_BODY) -- ignore shirt
	em.IgnoreSlotForSave(INVSLOT_TABARD) -- ignore tabard
	em.SaveEquipmentSet(id)

	DEFAULT_CHAT_FRAME:AddMessage(SET_SAVED:format(set))
end

SLASH_SAVEWEAPONS1 = "/savew"
SLASH_SAVEWEAPONS2 = "/savewp"
SLASH_SAVEWEAPONS3 = "/saveweapon"
SLASH_SAVEWEAPONS4 = "/saveweapons"
SlashCmdList["SAVEWEAPONS"] = function(set)
	saveSlots(set, { [16] = true, [17] = true })
	DEFAULT_CHAT_FRAME:AddMessage(SET_WEAPONS_SAVED:format(set))
end

SLASH_SAVESLOTS1 = "/saveslots"
SlashCmdList["SAVESLOTS"] = function(opts)
	local set, slots = parseSlots(opts)
	if set == nil or slots == nil then
		return
	end

	saveSlots(set, slots)
	DEFAULT_CHAT_FRAME:AddMessage(SET_SAVED:format(set))
end
