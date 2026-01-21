local _, Addon = ...

Addon.fontSize = 12
Addon.font = "Fonts\\FRIZQT__.TTF"

Addon.modules = {}
Addon.cfgDefaults = {
	announceInterrupt = true,
	announceMiss = true,
	autoTrack = true,
	shamanBlue = true,
	energyTick = true,
	fiveSecondRule = true,
	meleeRangeCheck = true,
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
	Config = Addon:MergeTable(Config, Addon.cfgDefaults)

	for _, module in pairs(Addon.modules) do
		module:OnLoad()
	end

	f:UnregisterAllEvents()
end)
