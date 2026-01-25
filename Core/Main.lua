local _, Addon = ...

Addon.modules = {}
Addon.ConfigDefaults = {
	AnnounceInterrupt = true,
	AnnounceMiss = true,
	AutoTrack = true,
	ChatShortChannel = true,
	ChatURL = true,
	EnergyTick = true,
	FiveSecondRule = true,
	Font = "Fonts\\FRIZQT__.TTF",
	MeleeNotAttacking = true,
	MeleeRangeCheck = true,
	MeleeRangeCheckFontSize = 36,
	ShamanBlue = true,
	StatusBar = true,
	StatusBarFontSize = 12,
	TargetHealth = true,
}

local interfaceVersion = select(4, GetBuildInfo())
Addon.IsTBC = 20000 <= interfaceVersion and interfaceVersion <= 29999

function Addon:NewModule(name)
	local module = {}
	module.name = name
	table.insert(Addon.modules, module)
	return module
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function()
	Config = Config or {}
	Config = Addon:MergeTable(Config, Addon.ConfigDefaults)

	for _, module in pairs(Addon.modules) do
		module:OnLoad()
	end

	f:UnregisterAllEvents()
end)
