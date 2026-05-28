local _, Addon = ...

local module = Addon.NewModule()
function module.OnLoad()
	if not Config.AnnounceTank then
		return
	end

	local TANK_CLASSES = {
		["WARRIOR"] = true,
		["DRUID"] = true,
		["PALADIN"] = true,
	}

	local class = UnitClassBase("player")
	if not TANK_CLASSES[class] then
		return
	end

	-- Localized spell names (for non-english clients)
	local aoeTauntSpellNames = Addon.SpellNames({
		1161, -- Challenging Shout
		5209, -- Challenging Roar
	})

	local CC_LOCTYPE_BY_CLASS = {
		["WARRIOR"] = {
			["CHARM"] = true,
			["CONFUSE"] = true,
			["DISARM"] = true,
			["DISORIENT"] = true,
			["FEAR_MECHANIC"] = true,
			["FEAR"] = true,
			["FREEZE"] = true,
			["HORROR"] = true,
			["INCAPACITATE"] = true,
			["POLYMORPH"] = true,
			["POSSESS"] = true,
			["ROOT"] = true,
			["SLEEP"] = true,
			["STUN_MECHANIC"] = true,
			["STUN"] = true,
		},
		["DRUID"] = {
			["CHARM"] = true,
			["CONFUSE"] = true,
			["DISORIENT"] = true,
			["FEAR_MECHANIC"] = true,
			["FEAR"] = true,
			["FREEZE"] = true,
			["HORROR"] = true,
			["INCAPACITATE"] = true,
			["POLYMORPH"] = true,
			["POSSESS"] = true,
			["ROOT"] = true,
			["SLEEP"] = true,
			["STUN_MECHANIC"] = true,
			["STUN"] = true,
		},
		["PALADIN"] = {
			["CHARM"] = true,
			["CONFUSE"] = true,
			["DISARM"] = true,
			["DISORIENT"] = true,
			["FEAR_MECHANIC"] = true,
			["FEAR"] = true,
			["FREEZE"] = true,
			["HORROR"] = true,
			["INCAPACITATE"] = true,
			["POLYMORPH"] = true,
			["POSSESS"] = true,
			["ROOT"] = true,
			["SILENCE"] = true,
			["SLEEP"] = true,
			["STUN_MECHANIC"] = true,
			["STUN"] = true,
		},
	}

	local MISS_CHECK_DURATION = 5 -- seconds after combat started
	local MISS_TYPES = {
		["MISS"] = true,
		["RESIST"] = true,
		["DODGE"] = true,
		["PARRY"] = true,
	}

	local playerGUID = UnitGUID("player")

	local function announceAoETaunt()
		local info = Addon.GetCLEUInfoSpell()

		if info.sourceGUID ~= playerGUID then
			return
		end

		if info.subevent ~= "SPELL_CAST_SUCCESS" then
			return
		end

		if not aoeTauntSpellNames[info.spellName] then
			return
		end

		local msg = ">> AoE Taunt <<"
		C_ChatInfo.SendChatMessage(msg, Addon.ChannelToSend())
	end

	local function getPlayerCC()
		local count = C_LossOfControl.GetActiveLossOfControlDataCount()
		for i = 1, count do
			local cc = C_LossOfControl.GetActiveLossOfControlData(i)
			if cc and CC_LOCTYPE_BY_CLASS[class][cc.locType] then
				return cc
			end
		end
		return nil
	end

	local function announceCC()
		if not Addon.PlayerIsTank() then
			return
		end

		local cc = getPlayerCC()
		if not cc then
			return
		end

		local msg = format(">> %s <<", cc.displayText)
		C_ChatInfo.SendChatMessage(msg, Addon.ChannelToSend())
	end

	local function announceMiss()
		if not Addon.PlayerIsTank() then
			return
		end

		local info = Addon.GetCLEUInfoSpellMiss()

		if info.sourceGUID ~= playerGUID then
			return
		end

		if info.subevent ~= "SPELL_MISSED" then
			return
		end

		if not MISS_TYPES[info.missType] then
			return
		end

		-- skip if target is being safely tanked by the player?
		-- if UnitThreatSituation("player", "target") == 3 then
		-- 	return
		-- end

		local msg = format(">> %s <<", info.displayText)
		C_ChatInfo.SendChatMessage(msg, Addon.ChannelToSend())
	end

	local enteredCombatAt = 0

	local f = CreateFrame("Frame")
	f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	f:RegisterEvent("LOSS_OF_CONTROL_ADDED")
	f:RegisterEvent("PLAYER_REGEN_DISABLED")
	f:SetScript("OnEvent", function(_, event)
		if Addon.InPvPInstance() then
			return
		end

		if not Addon.InGroupOrRaid() then
			return
		end

		if event == "COMBAT_LOG_EVENT_UNFILTERED" then
			announceAoETaunt()

			if (GetTime() - enteredCombatAt) <= MISS_CHECK_DURATION then
				announceMiss()
			end
		end

		if event == "LOSS_OF_CONTROL_ADDED" then
			announceCC()
		end

		if event == "PLAYER_REGEN_DISABLED" then
			enteredCombatAt = GetTime()
		end
	end)
end
