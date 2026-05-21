local _, Addon = ...

local module = Addon.NewModule()
function module.OnLoad()
	if not Config.AnnounceMiss then
		return
	end

	local spellIds = {
		-- Rogue
		1766, -- Kick
		6770, -- Sap
		2094, -- Blind
		1776, -- Gouge
		408, -- Kidney Shot

		-- Warrior
		72, -- Shield Bash
		355, -- Taunt
		694, -- Mocking Blow
		6552, -- Pummel
		12809, -- Concussion Blow

		-- Mage
		2139, -- Counterspell

		-- Druid
		5211, -- Bash
		6795, -- Growl
		9005, -- Pounce
		22570, -- Maim

		-- Hunter
		5384, -- Feign Death
		19386, -- Wyvern Sting
		19503, -- Scatter Shot
		19577, -- Intimidation
		19801, -- Tranquilizing Shot
		34490, -- Silencing Shot

		-- Warlock
		6789, -- Death Coil
		19647, -- Spell Lock

		-- Priest
		605, -- Mind Control
		15487, -- Silence

		-- Paladin
		853, -- Hammer of Justice
		20066, -- Repentance
	}

	-- Localized spell names (for non-english clients)
	local spellNames = Addon.SpellNames(spellIds)

	local playerGUID = UnitGUID("player")

	local f = CreateFrame("Frame")
	f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	f:SetScript("OnEvent", function()
		if Addon.InPvPInstance() then
			return
		end

		if not Addon.InGroupOrRaid() then
			return
		end

		local info = Addon.GetCLEUInfoSpellMiss()

		if info.subevent ~= "SPELL_MISSED" then
			return
		end

		if info.sourceGUID ~= playerGUID and info.sourceGUID ~= UnitGUID("pet") then
			return
		end

		if not spellNames[info.spellName] then
			return
		end

		local msg = format(">> %s %s << ", info.spellName, info.displayText)
		C_ChatInfo.SendChatMessage(msg, Addon.ChannelToSend())
	end)
end
