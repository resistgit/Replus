local _, Addon = ...

local module = Addon:NewModule()
function module:OnLoad()
	if not Config.MeleeCheck then return end

	local INTERVAL = 0.4    -- const
	local ID_ATTACK = 6603  -- const
	local ID_5YD_RANGE = 16114 -- const

	local _, class = UnitClass("player")

	local text = UIParent:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	text:SetFont(Config.Font, Config.MeleeCheckFontSize, "OUTLINE")
	text:SetTextColor(0.8, 0.2, 0.2)
	text:ClearAllPoints()
	text:SetPoint("CENTER", 0, -40)
	text:Hide()

	local function meleeCheck()
		if not UnitAffectingCombat("player") then
			text:Hide()
			return
		end

		if not UnitCanAttack("player", "target") then
			text:Hide()
			return
		end

		local attacking = IsCurrentSpell(ID_ATTACK)
		local inRange = C_Item.IsItemInRange(ID_5YD_RANGE, "target")
		local mustAttack = class == "WARRIOR" or class == "ROGUE"

		if mustAttack and not attacking then
			text:SetText("NOT ATTACKING")
			text:Show()
			return
		end

		if attacking and not inRange then
			text:SetText("TOO FAR")
			text:Show()
			return
		end

		text:Hide()
	end

	C_Timer.NewTicker(INTERVAL, meleeCheck)
end
