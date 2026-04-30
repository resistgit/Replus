local _, Addon = ...

local function setup()
	SetCVar("previewTalentsOption", Config.CVarPreviewTalents)
	SetCVar("UnitNamePlayerPVPTitle", Config.CVarUnitTitle)
end

local module = Addon.NewModule()
function module.OnLoad()
	setup()
end

function module.OnChange()
	setup()
end
