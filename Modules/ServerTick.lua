local _, Addon = ...

local module = Addon.NewModule()
function module.OnLoad()
	if not Config.ServerTick then return end

	local _, class = UnitClass("player")
	if class == "WARRIOR" then return end

	local TICK_INTERVAL = 2
	local lastPower = UnitPower("player")
	local lastTick = 0
	local expirationTime = 0
	local enabled = false

	local function tickHandler(self, _, unit, type)
		if unit ~= "player" then return end
		if type == "RAGE" then return end

		local ts = GetTime()
		local currPower = UnitPower("player")
		local maxPower = UnitPowerMax("player")
		local fullPower = currPower >= maxPower

		if fullPower then return end

		local hasGained = currPower > lastPower
		local isAligned = ts - lastTick > TICK_INTERVAL - 0.25
		if hasGained and isAligned then
			lastTick = ts
			expirationTime = ts + TICK_INTERVAL
			if not enabled then
				enabled = true
				self:Show()
				self.Spark:Show()
			end
		end

		lastPower = currPower
	end

	local function updateHandler(self)
		if not enabled then return end

		local ts = GetTime()

		local powerType = UnitPowerType("player")
		if powerType == Enum.PowerType.Rage then
			enabled = false
			self:Hide()
			self.Spark:Hide()
			return
		end

		local timeLeft = expirationTime - ts
		if timeLeft <= 0 then
			local currPower = UnitPower("player")
			local maxPower = UnitPowerMax("player")
			local fullPower = currPower >= maxPower
			if fullPower then
				expirationTime = ts + TICK_INTERVAL
				lastTick = ts
			end
			return
		end

		local progress = Addon.Clamp((TICK_INTERVAL - timeLeft) / TICK_INTERVAL, 0, 1)
		self:SetValue(progress * 100)

		local sparkX = progress * self:GetWidth()
		self.Spark:SetPoint("CENTER", self, "LEFT", sparkX, 0)
	end

	local f = CreateFrame("StatusBar")
	f:RegisterEvent("UNIT_POWER_FREQUENT")
	f:SetScript("OnEvent", tickHandler)
	f:SetScript("OnUpdate", updateHandler)

	f:SetAllPoints(PlayerFrameManaBar)
	f:SetWidth(PlayerFrameManaBar:GetWidth())
	f:SetHeight(PlayerFrameManaBar:GetHeight())
	f:SetMinMaxValues(0, 100)
	f:SetStatusBarColor(1, 0.5, 0.1, 1)
	f:SetValue(0)

	f.Spark = f:CreateTexture(nil, "OVERLAY")
	f.Spark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
	f.Spark:SetWidth(12)
	f.Spark:SetHeight(f:GetHeight() * 2)
	f.Spark:SetBlendMode("ADD")
end
