local _, Addon = ...

local module = Addon.NewModule()
function module.OnLoad()
	if not Config.MeleeCheck then return end

	local INTERVAL = 0.4
	local ID_ATTACK = 6603
	local ID_5YD_RANGE = 16114
	local COLOR_YELLOW = CreateColor(0.9, 0.4, 0) -- yellow
	local COLOR_RED = CreateColor(0.9, 0.3, 0.1) -- red

	local _, class = UnitClass("player")

	local text = UIParent:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	text:SetFont(Config.Font, Config.MeleeCheckFontSize, "OUTLINE")
	text:ClearAllPoints()
	text:SetPoint("CENTER", 0, -40)
	text:Hide()

	local function meleeCheck()
		if not InCombatLockdown() then
			text:Hide()
			return
		end

		if not UnitCanAttack("player", "target") then
			text:Hide()
			return
		end

		local attacking = C_Spell.IsCurrentSpell(ID_ATTACK)
		local inRange = C_Item.IsItemInRange(ID_5YD_RANGE, "target")
		local mustAttack = class == "WARRIOR" or class == "ROGUE"

		if mustAttack and not attacking then
			text:SetTextColor(COLOR_YELLOW:GetRGBA())
			text:SetText("NOT ATTACKING")
			text:Show()
			return
		end

		if attacking and not inRange then
			text:SetTextColor(COLOR_RED:GetRGBA())
			text:SetText("TOO FAR")
			text:Show()
			return
		end

		text:Hide()
	end

	C_Timer.NewTicker(INTERVAL, meleeCheck)
end
