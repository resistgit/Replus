local _, Addon = ...

local module = Addon:NewModule()
function module:OnLoad()
  if not Config.meleeRangeCheck then return end

  local _, class = UnitClass("player")
  if class == "MAGE" then return end
  if class == "PRIEST" then return end
  if class == "WARLOCK" then return end

  local INTERVAL = 0.8       -- const
  local ID_ATTACK = 6603     -- const
  local ID_5YD_RANGE = 16114 -- const

  local text = UIParent:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
  text:SetFont(Addon.font, Addon.fontSize * 3, "OUTLINE")
  text:SetTextColor(0.8, 0.2, 0.2)
  text:ClearAllPoints()
  text:SetPoint("CENTER", 0, -40)
  text:Hide()

  local function meleeRangeCheck()
    if not UnitAffectingCombat("player") then
      text:Hide()
      return
    end

    if not UnitCanAttack("player", "target") then
      text:Hide()
      return
    end

    if IsCurrentSpell(ID_ATTACK) and not IsItemInRange(ID_5YD_RANGE, "target") then
      text:SetText("TOO FAR")
      text:Show()
      return
    end

    if (class == "WARRIOR" or class == "ROGUE") and not IsCurrentSpell(ID_ATTACK) then
      text:SetText("NOT ATTACKING")
      text:Show()
      return
    end

    text:Hide()
  end

  C_Timer.NewTicker(INTERVAL, meleeRangeCheck)
end
