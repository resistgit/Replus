local _, Addon = ...

local module = Addon:NewModule()
function module:OnLoad()
	if Addon.IsTBC then return end
	if not Config.shamanBlue then return end

	RAID_CLASS_COLORS["SHAMAN"]["r"] = 0.0
	RAID_CLASS_COLORS["SHAMAN"]["g"] = 0.44
	RAID_CLASS_COLORS["SHAMAN"]["b"] = 0.87
	RAID_CLASS_COLORS["SHAMAN"]["colorStr"] = "ff0070dd"
end
