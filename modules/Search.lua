local P = unpack(select(2, ...))

local FONT = [[Interface\AddOns\Backpack\assets\semplice.ttf]]
local TEXTURE = [[Interface\ChatFrame\ChatFrameBackground]]
local BACKDROP = {bgFile = TEXTURE, edgeFile = TEXTURE, edgeSize = 1}

local function OnEnter(self)
	self:SetAlpha(0.4)
end

local function OnLeave(self)
	self:SetAlpha(0)
end

local function OpenSearch(self)
	self:SetScript('OnEnter', nil)
	self:SetScript('OnLeave', nil)
	self:SetAlpha(1)
	self.Icon:Hide()

	local Editbox = self.Editbox
	Editbox:SetText('')
	Editbox:Show()
end

local function CloseSearch(self)
	self:Hide()

	local Parent = self:GetParent()
	Parent:SetScript('OnEnter', OnEnter)
	Parent:SetScript('OnLeave', OnLeave)
	Parent.Icon:Show()

	if(not MouseIsOver(Parent)) then
		Parent:SetAlpha(0)
	end
end

local function Search(self, text)
	-- TODO
end

local function Init(self)
	local Frame = CreateFrame('Button', '$parentSearch', self)
	Frame:SetPoint('BOTTOMLEFT', 4, 4)
	Frame:SetPoint('BOTTOMRIGHT', -4, 4)
	Frame:SetHeight(20)
	Frame:SetAlpha(0)
	Frame:SetBackdrop(BACKDROP)
	Frame:SetBackdropColor(0, 0, 0, 0.9)
	Frame:SetBackdropBorderColor(0, 0, 0)
	Frame:RegisterForClicks('AnyUp')
	Frame:SetScript('OnClick', OpenSearch)
	Frame:SetScript('OnEnter', OnEnter)
	Frame:SetScript('OnLeave', OnLeave)

	local FrameIcon = Frame:CreateTexture('$parentIcon', 'OVERLAY')
	FrameIcon:SetPoint('CENTER')
	FrameIcon:SetSize(14, 14)
	FrameIcon:SetTexture([[Interface\Common\UI-Searchbox-Icon]])
	Frame.Icon = FrameIcon

	local Editbox = CreateFrame('EditBox', '$parentEditBox', Frame)
	Editbox:SetPoint('TOPLEFT', 25, 0)
	Editbox:SetPoint('BOTTOMRIGHT', -5, 0)
	Editbox:SetFont(FONT, 8, 'OUTLINEMONOCHROME')
	Editbox:SetScript('OnTextChanged', Search)
	Editbox:SetScript('OnEscapePressed', CloseSearch)
	Editbox:SetAutoFocus(true)
	Editbox:Hide()
	Frame.Editbox = Editbox

	local EditboxIcon = Editbox:CreateTexture('$parentIcon', 'OVERLAY')
	EditboxIcon:SetPoint('RIGHT', Editbox, 'LEFT', -4, 0)
	EditboxIcon:SetSize(14, 14)
	EditboxIcon:SetTexture([[Interface\Common\UI-Searchbox-Icon]])
end

P.AddModule(Init)