local _, Addon = ...

---@param unit string
---@return boolean
function Addon:IsMaxLevel(unit)
	local max = GetMaxLevelForExpansionLevel(GetExpansionLevel())
	return UnitLevel(unit) == max
end

---@param secs number
function Addon:FormatTime(secs)
	local NINETY_MINUTES = 5400 -- const
	local ONE_DAY = 86400    -- const

	if Addon:IsInf(secs) then
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

---@param value number
function Addon:IsInf(value)
	return value == math.huge or value == -math.huge
end

---@param value number
---@param min number
---@param max number
function Addon:Clamp(value, min, max)
	return math.min(max, math.max(min, value))
end

---@param spellId number any rank
---@return boolean hasBuff, number rank
function Addon:PlayerHasBuff(spellId)
	-- localized spell name (for non-english clients)
	local spell = C_Spell.GetSpellInfo(spellId)

	if spell == nil then
		return false, 0
	end

	for i = 1, 40 do
		local aura = C_UnitAuras.GetAuraDataByIndex("player", i, "HELPFUL")
		if aura == nil then break end

		if aura.name == spell.name then
			local subtext = GetSpellSubtext(aura.spellId)
			if not subtext then
				return true, 1
			end

			-- rank from text, did not find an API to get it
			local rank = tonumber(string.match(subtext, "%d+")) or 1
			return true, rank
		end
	end

	return false, 0
end

--- Merge keys in t2 into t1 (t1 has priority)
---@param t1 table
---@param t2 table
---@return table
function Addon:MergeTable(t1, t2)
	local copy = CopyTable(t1)
	for k, v in pairs(t2) do
		if copy[k] == nil then
			copy[k] = v
		end
	end
	return copy
end
