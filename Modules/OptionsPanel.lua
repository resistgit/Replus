local _, Addon = ...

local module = Addon:NewModule()
function module:OnLoad()
	local f = Addon.UIFactory:NewFrame("Replus")

	local category = Settings.RegisterCanvasLayoutCategory(f, "Replus")
	Settings.RegisterAddOnCategory(category)

	do -- Announce Interrupt
		local cb = Addon.UIFactory:NewCheckbox("Announce on Interrupt")
		cb:HookScript("OnClick", function()
			Config.announceInterrupt = cb:GetChecked()
		end)
		cb:SetChecked(Config.announceInterrupt)
	end

	do -- Announce Miss
		local cb = Addon.UIFactory:NewCheckbox("Announce on Important Missed Spells")
		cb:HookScript("OnClick", function()
			Config.announceMiss = cb:GetChecked()
		end)
		cb:SetChecked(Config.announceMiss)
	end

	do -- Auto Track
		local cb = Addon.UIFactory:NewCheckbox(
			"Auto Track |c00c8c8c8cast Find Herbs/Minerals whenever you ressurrect, except on battlegrounds|r"
		)
		cb:HookScript("OnClick", function()
			Config.autoTrack = cb:GetChecked()
		end)
		cb:SetChecked(Config.autoTrack)
	end

	-- Blue Shaman
	if not Addon.IsTBC then
		local cb = Addon.UIFactory:NewCheckbox("Blue Shaman")
		cb:HookScript("OnClick", function()
			Config.shamanBlue = cb:GetChecked()
		end)
		cb:SetChecked(Config.shamanBlue)
	end

	do -- Energy Tick
		local cb = Addon.UIFactory:NewCheckbox("Energy Tick")
		cb:HookScript("OnClick", function()
			Config.energyTick = cb:GetChecked()
		end)
		cb:SetChecked(Config.energyTick)
	end

	do -- Five Second Rule
		local cb = Addon.UIFactory:NewCheckbox("Mana Tick / Five Second Rule")
		cb:HookScript("OnClick", function()
			Config.fiveSecondRule = cb:GetChecked()
		end)
		cb:SetChecked(Config.fiveSecondRule)
	end

	do -- Melee Range Check
		local cb = Addon.UIFactory:NewCheckbox("Melee Range Check")
		cb:HookScript("OnClick", function()
			Config.meleeRangeCheck = cb:GetChecked()
		end)
		cb:SetChecked(Config.meleeRangeCheck)
	end

	do -- Reload button
		local btn = Addon.UIFactory:NewButton("Reload UI", 80)
		btn:SetScript("OnClick", function()
			ReloadUI()
		end)
	end
end
