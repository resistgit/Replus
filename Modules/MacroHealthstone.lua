local _, Addon = ...

local prio = {
	-- Master Healthstone
	22105,
	22104,
	22103,

	-- Major Healthstone
	19013,
	19012,
	9421,

	-- Greater Healthstone
	19011,
	19010,
	5510,

	-- Healthstone
	19009,
	19008,
	5509,

	-- Lesser Healthstone
	19007,
	19006,
	5511,

	-- Minor Healthstone
	19005,
	19004,
	5512,
}

local module = Addon.NewModule()
function module.OnLoad()
	if not Config.MacroHealthstone then
		return
	end

	local macroName = "ReplusHS"
	local icon = "INV_MISC_QUESTIONMARK"
	local perChar = nil

	local function update()
		local bagItems = Addon.BagItems()

		for _, itemId in ipairs(prio) do
			if bagItems[itemId] then
				local body = "#showtooltip\n/stopcasting\n/use item:" .. itemId
				local macroId = GetMacroIndexByName(macroName)
				if macroId > 0 then
					EditMacro(macroId, macroName, icon, body)
				else
					CreateMacro(macroName, icon, body, perChar)
				end
				break
			end
		end
	end

	local pending = true

	local f = CreateFrame("Frame")
	f:RegisterEvent("BAG_UPDATE")
	f:SetScript("OnEvent", function()
		pending = true
	end)

	C_Timer.NewTicker(0.4, function()
		if not pending then
			return
		end

		if InCombatLockdown() then
			return
		end

		update()
		pending = false
	end)
end
