local _, Addon = ...

local function register()
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
			Settings.VarType.Boolean,
			"Announce: Interrupt",
			Addon.ConfigDefaults.AnnounceInterrupt
		)
		local tooltip = "Announce on group after interrupting or reflecting spells."
		Settings.CreateCheckbox(category, setting, tooltip)
	end

	-- Announce Miss
	do
		local setting = Settings.RegisterAddOnSetting(
			category,
			"AnnounceMiss",
			"AnnounceMiss",
			Config,
			Settings.VarType.Boolean,
			"Announce: Spell Miss",
			Addon.ConfigDefaults.AnnounceMiss
		)
		local tooltip = "Announce on group after missing important spells, like interrupts, taunts, etc."
		Settings.CreateCheckbox(category, setting, tooltip)
	end

	-- Announce Tank Protection
	do
		local setting = Settings.RegisterAddOnSetting(
			category,
			"AnnounceTank",
			"AnnounceTank",
			Config,
			Settings.VarType.Boolean,
			"Announce: Tank Protection",
			Addon.ConfigDefaults.AnnounceTank
		)
		local tooltip = "Announce on group when CC'd, when missing spells at combat start, and when using AoE taunts."
		Settings.CreateCheckbox(category, setting, tooltip)
	end

	-- Auto Track
	if not Addon.IsTBC then
		local setting = Settings.RegisterAddOnSetting(
			category,
			"AutoTrack",
			"AutoTrack",
			Config,
			Settings.VarType.Boolean,
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
			Settings.VarType.Boolean,
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
			Settings.VarType.Boolean,
			"Chat: Short Channel Names",
			Addon.ConfigDefaults.ChatShortChannel
		)
		local tooltip = "Replace 'Trade' with 'T', 'LookingForGroup' with 'LFG', etc., may not work with other chat addon."
		Settings.CreateCheckbox(category, setting, tooltip)
	end

	-- Chat URLs
	do
		local setting = Settings.RegisterAddOnSetting(
			category,
			"ChatURL",
			"ChatURL",
			Config,
			Settings.VarType.Boolean,
			"Chat: Clickable URLs",
			Addon.ConfigDefaults.ChatURL
		)
		local tooltip = "Add URL to chat box, may not work with other chat addon."
		Settings.CreateCheckbox(category, setting, tooltip)
	end

	-- Server Tick
	do
		local setting = Settings.RegisterAddOnSetting(
			category,
			"ServerTick",
			"ServerTick",
			Config,
			Settings.VarType.Boolean,
			"Energy/Mana Tick",
			Addon.ConfigDefaults.ServerTick
		)
		local tooltip = "Show energy and/or mana tick."
		Settings.CreateCheckbox(category, setting, tooltip)
	end

	-- Macro Food/Drink
	do
		local setting = Settings.RegisterAddOnSetting(
			category,
			"MacroFoodDrink",
			"MacroFoodDrink",
			Config,
			Settings.VarType.Boolean,
			"Macro: Food/Drink",
			Addon.ConfigDefaults.MacroFoodDrink
		)
		local tooltip = "Create macros for food and drink to use the best available (Level 55+)."
		Settings.CreateCheckbox(category, setting, tooltip)
	end

	-- Macro Healthstone
	do
		local setting = Settings.RegisterAddOnSetting(
			category,
			"MacroHealthstone",
			"MacroHealthstone",
			Config,
			Settings.VarType.Boolean,
			"Macro: Healthstone",
			Addon.ConfigDefaults.MacroHealthstone
		)
		local tooltip = "Create macro for healthstone to use the best available."
		Settings.CreateCheckbox(category, setting, tooltip)
	end

	-- Melee Check
	do
		local cbSetting = Settings.RegisterAddOnSetting(
			category,
			"MeleeCheck",
			"MeleeCheck",
			Config,
			Settings.VarType.Boolean,
			"Melee Check",
			Addon.ConfigDefaults.MeleeCheck
		)
		local cbTooltip = "Alert whenever you're out of range for auto attacks."

		local sliderSetting = Settings.RegisterAddOnSetting(
			category,
			"MeleeCheckFontSize",
			"MeleeCheckFontSize",
			Config,
			Settings.VarType.Number,
			"Melee Check: Font Size",
			Addon.ConfigDefaults.MeleeCheckFontSize
		)
		sliderSetting:SetValueChangedCallback(Addon.OnSettingChange)
		local options = Settings.CreateSliderOptions(1, 99, 1)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right)
		local sliderTooltip = "Melee check font size."

		local initializer = CreateSettingsCheckboxSliderInitializer(
			cbSetting,
			"Melee Check",
			cbTooltip,
			sliderSetting,
			options,
			"Melee Check",
			sliderTooltip
		)
		layout:AddInitializer(initializer)
	end

	-- Status Bar
	do
		local cbSetting = Settings.RegisterAddOnSetting(
			category,
			"StatusBar",
			"StatusBar",
			Config,
			Settings.VarType.Boolean,
			"Status Bar",
			Addon.ConfigDefaults.StatusBar
		)
		local cbTooltip = "Add a status bar on bottom left corner with FPS, latency, durability, mov. speed and XP/hour."

		local sliderSetting = Settings.RegisterAddOnSetting(
			category,
			"StatusBarFontSize",
			"StatusBarFontSize",
			Config,
			Settings.VarType.Number,
			"Status Bar: Font Size",
			Addon.ConfigDefaults.StatusBarFontSize
		)
		sliderSetting:SetValueChangedCallback(Addon.OnSettingChange)
		local options = Settings.CreateSliderOptions(1, 99, 1)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right)
		local sliderTooltip = "Status bar font size."

		local initializer = CreateSettingsCheckboxSliderInitializer(
			cbSetting,
			"Status Bar",
			cbTooltip,
			sliderSetting,
			options,
			"Status Bar",
			sliderTooltip
		)
		layout:AddInitializer(initializer)
	end

	-- Target Health
	do
		local setting = Settings.RegisterAddOnSetting(
			category,
			"TargetHealth",
			"TargetHealth",
			Config,
			Settings.VarType.Boolean,
			"Target Health",
			Addon.ConfigDefaults.TargetHealth
		)
		local tooltip = "Show target current/total health, may not work with custom frames."
		Settings.CreateCheckbox(category, setting, tooltip)
	end

	-- Preview Talents
	do
		local function getter()
			return GetCVarBool("previewTalentsOption")
		end

		local function setter(value)
			return SetCVar("previewTalentsOption", value)
		end

		local defaultValue = true
		local setting = Settings.RegisterProxySetting(
			category,
			"ProxyPreviewTalentsOption",
			Settings.VarType.Boolean,
			"Preview Talents",
			defaultValue,
			getter,
			setter
		)
		local tooltip = "Allows to plan character talent builds before committing."
		Settings.CreateCheckbox(category, setting, tooltip)
	end

	-- Players Titles
	do
		local function getter()
			return GetCVarBool("unitNamePlayerPVPTitle")
		end

		local function setter(value)
			return SetCVar("unitNamePlayerPVPTitle", value)
		end

		local defaultValue = true
		local setting = Settings.RegisterProxySetting(
			category,
			"ProxyUnitNamePlayerPVPTitle",
			Settings.VarType.Boolean,
			"Players Titles",
			defaultValue,
			getter,
			setter
		)
		local tooltip = "Show title of all players."
		Settings.CreateCheckbox(category, setting, tooltip)
	end

	-- Reload button
	do
		local initializer = CreateSettingsButtonInitializer("Reload UI", "Reload", function()
			ReloadUI()
		end, "Apply settings and reload interface.", false)
		layout:AddInitializer(initializer)
	end
end

SettingsRegistrar:AddRegistrant(register)
