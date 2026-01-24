local _, Addon = ...

local module = Addon:NewModule()
function module:OnLoad()
    if not Config.TargetHealth then return end

    local function healthbarUpdate(statusbar, unit)
        if not statusbar then return end
        if statusbar.lockValues then return end
        if unit ~= statusbar.unit then return end
        if not statusbar.showPercentage then return end

        local isPlayerOrPet = UnitIsPlayer(unit) or UnitGUID(unit):find("Pet")
        local isInGroup = UnitPlayerOrPetInRaid(unit) or UnitPlayerOrPetInParty(unit)
        if isPlayerOrPet and not isInGroup then return end

        statusbar.showPercentage = false

        -- Legacy clients
        if TextStatusBar_UpdateTextString then
            TextStatusBar_UpdateTextString(statusbar)
            return
        end

        -- Modern clients
        if statusbar.UpdateTextString then
            statusbar:UpdateTextString()
            return
        end
    end

    hooksecurefunc("UnitFrameHealthBar_Update", healthbarUpdate)
end
