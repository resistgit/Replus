local _, Addon = ...

local module = Addon:NewModule()
function module:OnLoad()
	local frame = Addon.UIFactory:NewFrame("ReplusOptionsPanel")
	local h = -8
	local margin = 32

	local category = Settings.RegisterCanvasLayoutCategory(frame, "Replus")
	Settings.RegisterAddOnCategory(category)

	local fs = frame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
	fs:SetText("Replus")
	fs:SetPoint("TOPLEFT", 0, h)

	h = h - 24
	fs = frame:CreateFontString("ARTWORK", nil, "GameFontNormal")
	fs:SetText(
		"|c00c8c8c8Some options are intended to use with default Blizzard UI, other addons may change the behavior.|r"
	)
	fs:SetPoint("TOPLEFT", 0, h)

	do -- Announce Interrupt
		local cb = Addon.UIFactory:NewCheckbox("Announce on Interrupt")
		h = h - margin
		cb:SetPoint("TOPLEFT", frame, 0, h)
		cb:HookScript("OnClick", function()
			Config.AnnounceInterrupt = cb:GetChecked()
		end)
		cb:SetChecked(Config.AnnounceInterrupt)
	end

	do -- Announce Miss
		local cb = Addon.UIFactory:NewCheckbox("Announce on Important Missed Spells")
		h = h - margin
		cb:SetPoint("TOPLEFT", frame, 0, h)
		cb:HookScript("OnClick", function()
			Config.AnnounceMiss = cb:GetChecked()
		end)
		cb:SetChecked(Config.AnnounceMiss)
	end

	-- Auto Track
	if not Addon.IsTBC then
		local cb = Addon.UIFactory:NewCheckbox("Auto Track Herbs/Minerals")
		h = h - margin
		cb:SetPoint("TOPLEFT", frame, 0, h)
		cb:HookScript("OnClick", function()
			Config.AutoTrack = cb:GetChecked()
		end)
		cb:SetChecked(Config.AutoTrack)

		cb.Text:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
			GameTooltip:ClearLines()
			GameTooltip:AddLine("Cast Find Herbs/Minerals whenever you ressurrect, except on battlegrounds")
			GameTooltip:Show()
		end)
		cb.Text:SetScript("OnLeave", function() GameTooltip:Hide() end)
	end

	-- Blue Shaman
	if not Addon.IsTBC then
		local cb = Addon.UIFactory:NewCheckbox("Blue Shaman")
		h = h - margin
		cb:SetPoint("TOPLEFT", frame, 0, h)
		cb:HookScript("OnClick", function()
			Config.ShamanBlue = cb:GetChecked()
		end)
		cb:SetChecked(Config.ShamanBlue)
	end

	do -- Chat Short Channel
		local cb = Addon.UIFactory:NewCheckbox("Chat Short Channel Names")
		h = h - margin
		cb:SetPoint("TOPLEFT", frame, 0, h)
		cb:HookScript("OnClick", function()
			Config.ChatShortChannel = cb:GetChecked()
		end)
		cb:SetChecked(Config.ChatShortChannel)
	end

	do -- Chat URL
		local cb = Addon.UIFactory:NewCheckbox("Chat Clickable URLs")
		h = h - margin
		cb:SetPoint("TOPLEFT", frame, 0, h)
		cb:HookScript("OnClick", function()
			Config.ChatURL = cb:GetChecked()
		end)
		cb:SetChecked(Config.ChatURL)
	end

	do -- Energy Tick
		local cb = Addon.UIFactory:NewCheckbox("Energy Tick")
		h = h - margin
		cb:SetPoint("TOPLEFT", frame, 0, h)
		cb:HookScript("OnClick", function()
			Config.EnergyTick = cb:GetChecked()
		end)
		cb:SetChecked(Config.EnergyTick)
	end

	do -- Five Second Rule
		local cb = Addon.UIFactory:NewCheckbox("Mana Tick / Five Second Rule")
		h = h - margin
		cb:SetPoint("TOPLEFT", frame, 0, h)
		cb:HookScript("OnClick", function()
			Config.FiveSecondRule = cb:GetChecked()
		end)
		cb:SetChecked(Config.FiveSecondRule)
	end

	do -- Melee Not Attacking Check
		local cb = Addon.UIFactory:NewCheckbox("Melee Not Attacking Check")
		h = h - margin
		cb:SetPoint("TOPLEFT", frame, 0, h)
		cb:HookScript("OnClick", function()
			Config.MeleeNotAttacking = cb:GetChecked()
		end)
		cb:SetChecked(Config.MeleeNotAttacking)

		cb.Text:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
			GameTooltip:ClearLines()
			GameTooltip:AddLine("Alert whenever you're in combat and not attacking")
			GameTooltip:Show()
		end)
		cb.Text:SetScript("OnLeave", function() GameTooltip:Hide() end)
	end

	do -- Melee Range Check
		local cb = Addon.UIFactory:NewCheckbox("Melee Range Check")
		h = h - margin
		cb:SetPoint("TOPLEFT", frame, 0, h)
		cb:HookScript("OnClick", function()
			Config.MeleeRangeCheck = cb:GetChecked()
		end)
		cb:SetChecked(Config.MeleeRangeCheck)

		cb.Text:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
			GameTooltip:ClearLines()
			GameTooltip:AddLine("Alert whenever you're out of range to attack")
			GameTooltip:Show()
		end)
		cb.Text:SetScript("OnLeave", function() GameTooltip:Hide() end)
	end

	do -- Melee Check Font Size
		local f = Addon.UIFactory:NewInputFrame("Melee Check Font Size")
		h = h - margin
		f:SetPoint("TOPLEFT", frame, 32, h)
		f.Input:SetNumeric(true)
		f.Input:SetText(Config.MeleeRangeCheckFontSize)
		f.Input:SetCursorPosition(0)

		f.Input:SetScript("OnEnterPressed", function(self)
			Config.MeleeRangeCheckFontSize = self:GetText()
			self:ClearFocus()
		end)

		f.Input:SetScript("OnEditFocusLost", function(self)
			Config.MeleeRangeCheckFontSize = self:GetText()
		end)
	end

	do -- Status Bar
		local cb = Addon.UIFactory:NewCheckbox("Status Bar")
		h = h - margin
		cb:SetPoint("TOPLEFT", frame, 0, h)
		cb:HookScript("OnClick", function()
			Config.StatusBar = cb:GetChecked()
		end)
		cb:SetChecked(Config.StatusBar)

		cb.Text:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
			GameTooltip:ClearLines()
			GameTooltip:AddLine(
				"Add a Status Bar on bottom left corner with FPS, Latency, Durability, Mov. Speed and XP/hour.")
			GameTooltip:Show()
		end)
		cb.Text:SetScript("OnLeave", function() GameTooltip:Hide() end)
	end

	do -- Status Bar Font Size
		local f = Addon.UIFactory:NewInputFrame("Status Bar Font Size")
		h = h - margin
		f:SetPoint("TOPLEFT", frame, 32, h)
		f.Input:SetNumeric(true)
		f.Input:SetText(Config.StatusBarFontSize)
		f.Input:SetCursorPosition(0)

		f.Input:SetScript("OnEnterPressed", function(self)
			Config.StatusBarFontSize = self:GetText()
			self:ClearFocus()
		end)

		f.Input:SetScript("OnEditFocusLost", function(self)
			Config.StatusBarFontSize = self:GetText()
		end)
	end

	do -- Target Health
		local cb = Addon.UIFactory:NewCheckbox("Target Health")
		h = h - margin
		cb:SetPoint("TOPLEFT", frame, 0, h)
		cb:HookScript("OnClick", function()
			Config.TargetHealth = cb:GetChecked()
		end)
		cb:SetChecked(Config.TargetHealth)
	end

	do -- Reload button
		local btn = Addon.UIFactory:NewButton("Reload UI", 80)
		h = h - margin * 2
		btn:SetPoint("TOPLEFT", frame, 0, h)
		btn:SetScript("OnClick", function()
			ReloadUI()
		end)
	end
end
