local _, Addon = ...

local module = Addon.NewModule()
function module.OnLoad()
	if not Config.AnnounceInterrupt then
		return
	end

	local playerGUID = UnitGUID("player")

	local function announceInterrupt()
		local info = Addon.GetCLEUInfoSpell()

		if info.subevent ~= "SPELL_INTERRUPT" then
			return
		end

		if info.sourceGUID ~= playerGUID then
			return
		end

		local spell = GetSpellLink(info.spellId) or info.spellName

		local msg = format("%s %s", INTERRUPTED, spell or info.destName)
		C_ChatInfo.SendChatMessage(msg, Addon.ChannelToSend())
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

		announceInterrupt()
	end)
end
