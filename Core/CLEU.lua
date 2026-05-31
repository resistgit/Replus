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
---@field sourceSpellId number
---@field sourceSpellName string
---@field sourceSpellSchool number
---@field destGUID string
---@field destName string
---@field destFlags number
---@field destRaidFlags number

---@class CLEUInfoMiss : CLEUInfo
---@field missType CLEUMissType
---@field displayText string
---@field isOffHand boolean
---@field amountMissed number
---@field isCritical boolean

---@class CLEUInfoInterrupt : CLEUInfo
---@field destSpellId number
---@field destSpellName string
---@field destSpellSchool number

---@return CLEUInfo
function Addon.GetCLEUInfo()
	local log = { CombatLogGetCurrentEventInfo() }

	local info = {}
	info.timestamp = log[1]
	info.subevent = log[2]
	info.hideCaster = log[3]
	info.sourceGUID = log[4]
	info.sourceName = log[5]
	info.sourceFlags = log[6]
	info.sourceRaidFlags = log[7]
	info.destGUID = log[8]
	info.destName = log[9]
	info.destFlags = log[10]
	info.destRaidFlags = log[11]

	local prefix = string.sub(info.subevent, 1, 5)
	if prefix == "SPELL" then
		info.sourceSpellId = log[12]
		info.sourceSpellName = log[13]
		info.sourceSpellSchool = log[14]
	end

	return info
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

---@return CLEUInfoMiss
function Addon.GetCLEUInfoMiss()
	local log = { CombatLogGetCurrentEventInfo() }

	local info = {}
	info.timestamp = log[1]
	info.subevent = log[2]
	info.hideCaster = log[3]
	info.sourceGUID = log[4]
	info.sourceName = log[5]
	info.sourceFlags = log[6]
	info.sourceRaidFlags = log[7]
	info.destGUID = log[8]
	info.destName = log[9]
	info.destFlags = log[10]
	info.destRaidFlags = log[11]
	info.missType = log[12]
	info.displayText = missDisplayText[info.missType] or info.missType
	info.isOffHand = log[13]
	info.amountMissed = log[14]
	info.isCritical = log[15]

	if info.subevent == "SPELL_MISSED" then
		info.sourceSpellId = log[12]
		info.sourceSpellName = log[13]
		info.sourceSpellSchool = log[14]
		info.missType = log[15]
		info.displayText = missDisplayText[info.missType] or info.missType
		info.isOffHand = log[16]
		info.amountMissed = log[17]
		info.isCritical = log[18]
	end

	return info
end

---@return CLEUInfoInterrupt
function Addon.GetCLEUInfoInterrupt()
	local log = { CombatLogGetCurrentEventInfo() }

	local info = {}
	info.timestamp = log[1]
	info.subevent = log[2]
	info.hideCaster = log[3]
	info.sourceGUID = log[4]
	info.sourceName = log[5]
	info.sourceFlags = log[6]
	info.sourceRaidFlags = log[7]
	info.destGUID = log[8]
	info.destName = log[9]
	info.destFlags = log[10]
	info.destRaidFlags = log[11]
	info.sourceSpellId = log[12]
	info.sourceSpellName = log[13]
	info.sourceSpellSchool = log[14]
	info.destSpellId = log[15]
	info.destSpellName = log[16]
	info.destSpellSchool = log[17]

	return info
end
