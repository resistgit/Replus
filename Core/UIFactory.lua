local _, Addon = ...

Addon.UIFactory = {}

function Addon.UIFactory:NewFrame(name)
	self.Frame = CreateFrame("Frame", name, UIParent)
	return self.Frame
end

function Addon.UIFactory:NewCheckbox(text)
	local cb = CreateFrame("CheckButton", nil, self.Frame, "UICheckButtonTemplate")
	cb.Text:SetText(text)
	cb.Text:SetFontObject("GameFontNormal")
	cb.Text:SetPoint("LEFT", cb, "RIGHT", 4, 0)

	return cb
end

function Addon.UIFactory:NewButton(text, width)
	local btn = CreateFrame("Button", nil, self.Frame, "UIPanelButtonTemplate")
	btn:SetText(text)
	btn:SetWidth(width)

	return btn
end

-- function Addon.UIFactory:NewSlider(text, min, max)
-- 	local slider = CreateFrame("Slider", nil, f, "OptionsSliderTemplate")
-- 	slider:SetPoint("TOPLEFT", lastEl, 0, -MARGIN * 1.5)
-- 	slider:SetSize(144, 17)
-- 	slider:SetMinMaxValues(min, max)
-- 	slider:SetValue(100)
-- 	slider:SetValueStep(1)
-- 	slider:SetObeyStepOnDrag(true)
-- 	slider.Text:SetText(text)
-- 	slider.Low:SetText(min)
-- 	slider.High:SetText(max)

-- 	return slider
-- end

function Addon.UIFactory:NewInputFrame(label)
	local f = CreateFrame("Frame", nil, self.Frame)
	f:SetSize(200, 26)
	f.Label = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	f.Label:SetPoint("LEFT", f, "LEFT", 4, 0)
	f.Label:SetText(label)

	f.Input = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
	f.Input:SetSize(44, 26)
	f.Input:SetAutoFocus(false)
	f.Input:SetPoint("LEFT", f.Label, "RIGHT", 12, 0)

	return f
end
