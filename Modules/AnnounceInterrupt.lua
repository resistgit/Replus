local _, Addon = ...

local module = Addon.NewModule()
function module.OnLoad()
	if not Config.AnnounceInterrupt then
		return
	end

	local f = CreateFrame("Frame")
	f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	f:SetScript("OnEvent", function()
		if Addon.InPvPInstance() then
			return
		end

		if not Addon.InGroupOrRaid() then
			return
		end

		-- See: https://wowpedia.fandom.com/wiki/COMBAT_LOG_EVENT
		local log = { CombatLogGetCurrentEventInfo() }
		local event = log[2]
		local sourceGUID = log[4]
		local destName = log[9]
		local spellId = log[15]
		local spellName = log[16]
		local spellLink = GetSpellLink(spellId)

		if event ~= "SPELL_INTERRUPT" then
			return
		end

		if sourceGUID ~= UnitGUID("player") then
			return
		end

		local msg = "Interrupted " .. (spellLink or spellName or destName)
		C_ChatInfo.SendChatMessage(msg, Addon.ChannelToSend())
	end)
end
