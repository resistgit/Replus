local _, Addon = ...

local foodPrio = {
	-- Level 65
	34062, -- Conjured Manna Biscuit
	22019, -- Conjured Croissant
	29394, -- Lyribread
	29448, -- Mag'har Mild Cheese
	29449, -- Bladespire Bagel
	29450, -- Telaari Grapes
	29451, -- Clefthoof Ribs
	29452, -- Zangar Trout
	29453, -- Sporeggar Mushroom
	30355, -- Grilled Shadowmoon Tuber
	32685, -- Ogri'la Chicken Fingers
	33048, -- Stewed Trout
	33053, -- Hot Buttered Trout
	38428, -- Rock-Salted Pretzel

	-- Level 55
	22895, -- Conjured Cinnamon Roll
	28112, -- Underspore Pod
	20031, -- Essence Mango
	19301, -- Alterac Manna Biscuit (Level 51)
	27661, -- Blackened Trout
	27854, -- Smoked Talbuk Venison
	27855, -- Mag'har Grainbread
	27856, -- Skethyl Berries
	27857, -- Garadar Sharp
	27858, -- Sunspring Carp
	27859, -- Zangar Caps
	28486, -- Moser's Magnificent Muffin
	29393, -- Diamond Berries
	29412, -- Jessen's Special Slop
	30458, -- Stromgarde Muenster
	30610, -- Smoked Black Bear Meat
	38427, -- Pickled Egg
}

local drinkPrio = {
	-- Level 65
	34062, -- Conjured Manna Biscuit
	22018, -- Conjured Glacier Water
	27860, -- Purified Draenic Water
	29395, -- Ethermead
	29401, -- Sparkling Southshore Cider
	30457, -- Gilneas Sparkling Water
	32453, -- Star's Tears
	32668, -- Dos Ogris
	33042, -- Black Coffee
	33053, -- Hot Buttered Trout
	38431, -- Blackrock Fortified Water

	-- Level 60
	30703, -- Conjured Mountain Spring Water
	28399, -- Filtered Draenic Water
	29454, -- Silverwine
	38430, -- Blackrock Mineral Water

	-- Level 55
	8079, -- Conjured Crystal Water
	28112, -- Underspore Pod
	20031, -- Essence Mango
	19301, -- Alterac Manna Biscuit (Level 51)
	18300, -- Hyjal Nectar
	32455, -- Star's Lament
}

local module = Addon:NewModule()
function module:OnLoad()
	if not Config.MacroFoodDrink then return end
	if UnitLevel("player") < 55 then return end

	local macroNameFood = "ReplusFood"
	local macroNameDrink = "ReplusDrink"

	local function update()
		local bagItems = Addon:BagItems()

		local icon = "INV_MISC_QUESTIONMARK"
		local perChar = nil

		for _, itemId in ipairs(foodPrio) do
			if bagItems[itemId] then
				local body = "#showtooltip\n/use item:" .. itemId
				local macroId = GetMacroIndexByName(macroNameFood)
				if macroId > 0 then
					EditMacro(macroId, macroNameFood, icon, body)
				else
					CreateMacro(macroNameFood, icon, body, perChar)
				end
				break
			end
		end

		for _, itemId in ipairs(drinkPrio) do
			if bagItems[itemId] then
				local body = "#showtooltip\n/use item:" .. itemId
				local macroId = GetMacroIndexByName(macroNameDrink)
				if macroId > 0 then
					EditMacro(macroId, macroNameDrink, icon, body)
				else
					CreateMacro(macroNameDrink, icon, body, perChar)
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
		if not pending then return end
		if UnitAffectingCombat("player") then return end

		update()
		pending = false
	end)
end
