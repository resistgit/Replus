local _, Addon = ...

local module = Addon:NewModule()
function module:OnLoad()
    if not StanceBar then return end

    local function stanceBarFix()
        if StanceBar.BackgroundArtMiddle then
            StanceBar.BackgroundArtMiddle:Hide()
            StanceBar.BackgroundArtMiddle:SetAlpha(0)
        end
        if StanceBar.BackgroundArtLeft then
            StanceBar.BackgroundArtLeft:Hide()
            StanceBar.BackgroundArtLeft:SetAlpha(0)
        end
        if StanceBar.BackgroundArtRight then
            StanceBar.BackgroundArtRight:Hide()
            StanceBar.BackgroundArtRight:SetAlpha(0)
        end
    end

    stanceBarFix()
    hooksecurefunc(StanceBar, "Show", stanceBarFix)
end
