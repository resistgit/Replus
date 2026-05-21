local _, Addon = ...

---@alias CLEUSubEvent
---|"SWING_DAMAGE"
---|"SWING_MISSED"
---|"SPELL_DAMAGE"
---|"SPELL_MISSED"
---|"SPELL_HEAL"
---|"SPELL_HEAL_ABSORBED"
---|"SPELL_ABSORBED"
---|"SPELL_ENERGIZE"
---|"SPELL_DRAIN"
---|"SPELL_LEECH"
---|"SPELL_INTERRUPT"
---|"SPELL_DISPEL"
---|"SPELL_DISPEL_FAILED"
---|"SPELL_STOLEN"
---|"SPELL_EXTRA_ATTACKS"
---|"SPELL_AURA_APPLIED"
---|"SPELL_AURA_REMOVED"
---|"SPELL_AURA_REFRESH"
---|"SPELL_AURA_BROKEN"
---|"SPELL_AURA_BROKEN_SPELL"
---|"SPELL_CAST_START"
---|"SPELL_CAST_SUCCESS"
---|"SPELL_CAST_FAILED"
---|"SPELL_CREATE"
---|"SPELL_SUMMON"

---@alias CLEUMissType
---|"ABSORB"
---|"BLOCK"
---|"DEFLECT"
---|"DODGE"
---|"EVADE"
---|"IMMUNE"
---|"MISS"
---|"PARRY"
---|"REFLECT"
---|"RESIST"

---@class CLEUInfo
---@field timestamp number
---@field subevent CLEUSubEvent
---@field hideCaster boolean
---@field sourceGUID string
---@field sourceName string
---@field sourceFlags number
---@field sourceRaidFlags number
---@field destGUID string
---@field destName string
---@field destFlags number
---@field destRaidFlags number

---@class CLEUInfoSpell : CLEUInfo
---@field spellId number
---@field spellName string
---@field spellSchool number

---@class CLEUInfoSpellMiss : CLEUInfoSpell
---@field missType CLEUMissType
---@field displayText string
---@field isOffHand boolean
---@field amountMissed number
---@field isCritical boolean

---@return CLEUInfo
function Addon.GetCLEUInfo()
	local log = { CombatLogGetCurrentEventInfo() }

	return {
		timestamp = log[1],
		subevent = log[2],
		hideCaster = log[3],
		sourceGUID = log[4],
		sourceName = log[5],
		sourceFlags = log[6],
		sourceRaidFlags = log[7],
		destGUID = log[8],
		destName = log[9],
		destFlags = log[10],
		destRaidFlags = log[11],
	}
end

---@return CLEUInfoSpell
function Addon.GetCLEUInfoSpell()
	local log = { CombatLogGetCurrentEventInfo() }

	return {
		timestamp = log[1],
		subevent = log[2],
		hideCaster = log[3],
		sourceGUID = log[4],
		sourceName = log[5],
		sourceFlags = log[6],
		sourceRaidFlags = log[7],
		destGUID = log[8],
		destName = log[9],
		destFlags = log[10],
		destRaidFlags = log[11],
		spellId = log[12],
		spellName = log[13],
		spellSchool = log[14],
	}
end

local missDisplayText = {
	["ABSORB"] = COMBAT_TEXT_ABSORB,
	["BLOCK"] = COMBAT_TEXT_BLOCK,
	["DEFLECT"] = COMBAT_TEXT_DEFLECT,
	["DODGE"] = COMBAT_TEXT_DODGE,
	["EVADE"] = COMBAT_TEXT_EVADE,
	["IMMUNE"] = COMBAT_TEXT_IMMUNE,
	["MISS"] = COMBAT_TEXT_MISS,
	["PARRY"] = COMBAT_TEXT_PARRY,
	["REFLECT"] = COMBAT_TEXT_REFLECT,
	["RESIST"] = COMBAT_TEXT_RESIST,
}

---@return CLEUInfoSpellMiss
function Addon.GetCLEUInfoSpellMiss()
	local log = { CombatLogGetCurrentEventInfo() }

	return {
		timestamp = log[1],
		subevent = log[2],
		hideCaster = log[3],
		sourceGUID = log[4],
		sourceName = log[5],
		sourceFlags = log[6],
		sourceRaidFlags = log[7],
		destGUID = log[8],
		destName = log[9],
		destFlags = log[10],
		destRaidFlags = log[11],
		spellId = log[12],
		spellName = log[13],
		spellSchool = log[14],
		missType = log[15],
		displayText = missDisplayText[log[15]],
		isOffHand = log[16],
		amountMissed = log[17],
		isCritical = log[18],
	}
end
