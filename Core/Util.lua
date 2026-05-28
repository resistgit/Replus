local _, Addon = ...

---@param unit string
---@return boolean
function Addon.IsMaxLevel(unit)
	local max = GetMaxLevelForExpansionLevel(GetExpansionLevel())
	return UnitLevel(unit) == max
end

---@param secs number
---@return string
function Addon.FormatTime(secs)
	local NINETY_MINUTES = 5400
	local ONE_DAY = 86400

	if Addon.IsInf(secs) then
		return "..."
	end

	if secs > ONE_DAY then
		return format("%dd", ceil(secs / 86400))
	end

	if secs > NINETY_MINUTES then
		return format("%dh", ceil(secs / 3600))
	end

	if secs > 90 then
		return format("%dm", ceil(secs / 60))
	end

	return format("%ds", secs)
end

---@param n number
---@return string
function Addon.FormatNumber(n)
	if n < 1000 then
		return format("%d", n)
	end

	return format("%.1fk", n / 1000)
end

---@param value number
---@return boolean
function Addon.IsInf(value)
	return value == math.huge or value == -math.huge
end

---@param value number
---@param min number
---@param max number
---@return number
function Addon.Clamp(value, min, max)
	return math.min(max, math.max(min, value))
end

---@param n number
---@return number
function Addon.Round(n)
	if not n then
		return 0
	end

	if n < 0 then
		return math.ceil(n - 0.5)
	end

	return math.floor(n + 0.5)
end

--- Merge keys in t2 into t1 (t1 has priority)
---@param t1 table
---@param t2 table
---@return table
function Addon.MergeTable(t1, t2)
	local copy = CopyTable(t1)
	for k, v in pairs(t2) do
		if copy[k] == nil then
			copy[k] = v
		end
	end
	return copy
end

--- Returns a table with all bag items id.
---@return table
function Addon.BagItems()
	local items = {}

	for bag = 0, NUM_BAG_SLOTS do
		for slot = 1, C_Container.GetContainerNumSlots(bag) do
			local itemId = C_Container.GetContainerItemID(bag, slot)

			if itemId then
				items[itemId] = true
			end
		end
	end

	return items
end

--- Returns if player is in any kind of group or raid.
---@return boolean
function Addon.InGroupOrRaid()
	return IsInGroup() or IsInRaid()
end

---@return boolean
function Addon.InPvPInstance()
	local inside, type = IsInInstance()
	if not inside then
		return false
	end

	return type == "pvp" or type == "arena"
end

--- Returns "SAY", "RAID" or "GROUP" depending on group and instance type.
---@return string
function Addon.ChannelToSend()
	if IsInInstance() then
		return "SAY"
	end

	if IsInRaid() then
		return "RAID"
	end

	if IsInGroup() then
		return "PARTY"
	end

	return "SAY"
end

---Returns all the localized spell names in a map based on any rank of the spell id.
---@param spellIds number[]
---@return table<string, boolean>
function Addon.SpellNames(spellIds)
	local spellNames = {}
	for _, id in ipairs(spellIds) do
		local info = C_Spell.GetSpellInfo(id)
		if info then
			spellNames[info.name] = true
		end
	end
	return spellNames
end

---@return boolean
function Addon.PlayerIsTank()
	local class = UnitClassBase("player")
	local formId = GetShapeshiftFormID()

	local WARRIOR_DEF_STANCE_ID = 18
	if class == "WARRIOR" and formId == WARRIOR_DEF_STANCE_ID then
		return true
	end

	if class == "DRUID" and formId == BEAR_FORM then
		return true
	end

	local RIGHTEOUS_FURY_ID = 25780
	if class == "PALADIN" and C_UnitAuras.GetPlayerAuraBySpellID(RIGHTEOUS_FURY_ID) then
		return true
	end

	return false
end
