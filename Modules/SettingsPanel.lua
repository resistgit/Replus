local _, Addon = ...

local module = Addon:NewModule()
function module:OnLoad()
	local category, layout = Settings.RegisterVerticalLayoutCategory("Replus")
	Settings.RegisterAddOnCategory(category)
	Addon.SettingsCategoryId = category:GetID()

	-- Announce Interrupt
	do
		local setting = Settings.RegisterAddOnSetting(
			category,
			"AnnounceInterrupt",
			"AnnounceInterrupt",
			Config,
			type(Addon.ConfigDefaults.AnnounceInterrupt),
			"Announce on Interrupt",
			Addon.ConfigDefaults.AnnounceInterrupt
		)
		local tooltip = "Announce on group after interrupting spells."
		Settings.CreateCheckbox(category, setting, tooltip)
	end

	-- Announce Miss
	do
		local setting = Settings.RegisterAddOnSetting(
			category,
			"AnnounceMiss",
			"AnnounceMiss",
			Config,
			type(Addon.ConfigDefaults.AnnounceMiss),
			"Announce Miss",
			Addon.ConfigDefaults.AnnounceMiss
		)
		local tooltip = "Announce on group after missing important spells, like interrupts, taunts, etc."
		Settings.CreateCheckbox(category, setting, tooltip)
	end

	-- Auto Track
	if not Addon.IsTBC then
		local setting = Settings.RegisterAddOnSetting(
			category,
			"AutoTrack",
			"AutoTrack",
			Config,
			type(Addon.ConfigDefaults.AutoTrack),
			"Auto Track Herbs/Minerals",
			Addon.ConfigDefaults.AutoTrack
		)
		local tooltip = "Cast Find Herbs/Minerals whenever you ressurrect, except on battlegrounds."
		Settings.CreateCheckbox(category, setting, tooltip)
	end

	-- Blue Shaman
	if not Addon.IsTBC then
		local setting = Settings.RegisterAddOnSetting(
			category,
			"ShamanBlue",
			"ShamanBlue",
			Config,
			type(Addon.ConfigDefaults.ShamanBlue),
			"Blue Shaman",
			Addon.ConfigDefaults.ShamanBlue
		)
		Settings.CreateCheckbox(category, setting)
	end

	-- Chat Short Channel
	do
		local setting = Settings.RegisterAddOnSetting(
			category,
			"ChatShortChannel",
			"ChatShortChannel",
			Config,
			type(Addon.ConfigDefaults.ChatShortChannel),
			"Chat Short Channel Names",
			Addon.ConfigDefaults.ChatShortChannel
		)
		local tooltip =
		"Replace 'Trade' with 'T', 'LookingForGroup' with 'LFG', etc., may not work with other chat addon."
		Settings.CreateCheckbox(category, setting, tooltip)
	end

	-- Chat URLs
	do
		local setting = Settings.RegisterAddOnSetting(
			category,
			"ChatURL",
			"ChatURL",
			Config,
			type(Addon.ConfigDefaults.ChatURL),
			"Chat Clickable URLs",
			Addon.ConfigDefaults.ChatURL
		)
		local tooltip = "Add URL to chat box, may not work with other chat addon."
		Settings.CreateCheckbox(category, setting, tooltip)
	end

	-- Energy Tick
	do
		local setting = Settings.RegisterAddOnSetting(
			category,
			"EnergyTick",
			"EnergyTick",
			Config,
			type(Addon.ConfigDefaults.EnergyTick),
			"Energy Tick",
			Addon.ConfigDefaults.EnergyTick
		)
		local tooltip = "Show energy ticks for Rogues and Druids in Cat Form."
		Settings.CreateCheckbox(category, setting, tooltip)
	end

	-- Mana Tick / Five Second Rule
	do
		local setting = Settings.RegisterAddOnSetting(
			category,
			"FiveSecondRule",
			"FiveSecondRule",
			Config,
			type(Addon.ConfigDefaults.FiveSecondRule),
			"Mana Tick / Five Second Rule",
			Addon.ConfigDefaults.FiveSecondRule
		)
		local tooltip = "Show mana tick and five second rule for mana classes."
		Settings.CreateCheckbox(category, setting, tooltip)
	end

	do
		local setting = Settings.RegisterAddOnSetting(
			category,
			"MeleeNotAttacking",
			"MeleeNotAttacking",
			Config,
			type(Addon.ConfigDefaults.MeleeNotAttacking),
			"Melee Not Attacking Check",
			Addon.ConfigDefaults.MeleeNotAttacking
		)
		local tooltip = "Alert whenever you're in combat and not attacking."
		Settings.CreateCheckbox(category, setting, tooltip)
	end

	do
		local setting = Settings.RegisterAddOnSetting(
			category,
			"MeleeRangeCheck",
			"MeleeRangeCheck",
			Config,
			type(Addon.ConfigDefaults.MeleeRangeCheck),
			"Melee Range Check",
			Addon.ConfigDefaults.MeleeRangeCheck
		)
		local tooltip = "Alert whenever you're out of range to attack."
		Settings.CreateCheckbox(category, setting, tooltip)
	end

	do
		local setting = Settings.RegisterAddOnSetting(
			category,
			"MeleeRangeCheckFontSize",
			"MeleeRangeCheckFontSize",
			Config,
			type(Addon.ConfigDefaults.MeleeRangeCheckFontSize),
			"Melee Check Font Size",
			Addon.ConfigDefaults.MeleeRangeCheckFontSize
		)
		local options = Settings.CreateSliderOptions(1, 99, 1)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right)
		Settings.CreateSlider(category, setting, options)
	end

	-- Status Bar
	do
		local cbSetting = Settings.RegisterAddOnSetting(
			category,
			"StatusBar",
			"StatusBar",
			Config,
			type(Addon.ConfigDefaults.StatusBar),
			"Status Bar",
			Addon.ConfigDefaults.StatusBar
		)
		local cbTooltip = "Add a status bar on bottom left corner with FPS, latency, durability, mov. speed and XP/hour."

		local sliderSetting = Settings.RegisterAddOnSetting(
			category,
			"StatusBarFontSize",
			"StatusBarFontSize",
			Config,
			type(Addon.ConfigDefaults.StatusBarFontSize),
			"Status Bar Font Size",
			Addon.ConfigDefaults.StatusBarFontSize
		)
		sliderSetting:SetValueChangedCallback(Addon.OnSettingChange)
		local options = Settings.CreateSliderOptions(1, 99, 1)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right)
		local sliderTooltip = "Status bar font size."

		local initializer = CreateSettingsCheckboxSliderInitializer(
			cbSetting, "Status Bar", cbTooltip,
			sliderSetting, options, "Status Bar", sliderTooltip)
		layout:AddInitializer(initializer)
	end

	-- Target Health
	do
		local setting = Settings.RegisterAddOnSetting(
			category,
			"TargetHealth",
			"TargetHealth",
			Config,
			type(Addon.ConfigDefaults.TargetHealth),
			"Target Health",
			Addon.ConfigDefaults.TargetHealth
		)
		local tooltip = "Show target current/total health, may not work with custom frames."
		Settings.CreateCheckbox(category, setting, tooltip)
	end

	-- Reload button
	do
		local initializer = CreateSettingsButtonInitializer(
			"Reload UI",
			"Reload",
			function() ReloadUI() end,
			"Apply settings and reload interface.",
			false
		)
		layout:AddInitializer(initializer)
	end
end
