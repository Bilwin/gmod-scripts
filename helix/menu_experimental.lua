
/////////////////////////////////////////
//
//              Tips & Vars
//
/////////////////////////////////////////

local schemaTips = {
    [1] = [[Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque consequat, mauris vel bibendum gravida, magna enim auctor ligula, vitae tempus tortor ligula a lectus. Nulla consequat, eros et tincidunt aliquet, urna sem tincidunt erat, tincidunt pulvinar ipsum quam viverra ipsum. Sed sit amet malesuada mauris. Donec sed lorem hendrerit, tincidunt felis vestibulum, sagittis urna. Integer quam sapien, rhoncus sit amet convallis sit amet, dapibus sed tellus. Suspendisse ac eros quis purus blandit sollicitudin. Cras aliquet, nisl et malesuada luctus, ligula lorem vestibulum tellus, in bibendum sapien libero ut odio. Quisque libero felis, lacinia at turpis semper, scelerisque tempor velit. Cras nisi urna, tempus sed hendrerit in, accumsan sit amet tortor. Nunc mi urna, maximus sed pellentesque ac, tincidunt nec tortor. Sed euismod enim eu massa faucibus, ac tempus sapien dictum. Interdum et malesuada fames ac ante ipsum primis in faucibus. Praesent tincidunt turpis et ex tempor maximus.]]
}
local backgrounds = {
    ix.util.GetMaterial('minerva/bg/1.jpg'),
    ix.util.GetMaterial('minerva/bg/2.jpg'),
    ix.util.GetMaterial('minerva/bg/3.jpg'),
    ix.util.GetMaterial('minerva/bg/4.jpg'),
    ix.util.GetMaterial('minerva/bg/5.jpg'),
    ix.util.GetMaterial('minerva/bg/6.jpg')
}
local title = "REUNITED GAMING"
local subTitle = "A SERIOUS HALF-LIFE 2 ROLEPLAY SERVER"
local version = '1.08-RG'
local animationTime = 3

/////////////////////////////////////////
//
//              Fonts
//
/////////////////////////////////////////

surface.CreateFont("ixNewMenuFontTip", {
    font = "Purista",
	size = SScale(12),
	weight = SScale(50),
	blursize = 0,
	scanlines = 2,
	antialias = true,
	shadow = true,
	additive = true,
	outline = true
})

surface.CreateFont("ixNewMenuCredits", {
    font = "Roboto Th",
	size = SScale(10),
	weight = SScale(5000)
})

surface.CreateFont("ixNewMenuFont", {
    font = "Purista SemiBold",
	size = SScale(15),
	weight = SScale(100),
	blursize = 0,
	scanlines = 2,
	antialias = true,
	shadow = true,
	additive = true,
	outline = true
})

surface.CreateFont("ixNewMenuFontTitle", {
    font = "Purista",
	size = SScale(50),
	weight = SScale(900),
	blursize = 0,
	scanlines = 2,
	antialias = true,
	shadow = true,
	additive = true,
	outline = true
})

surface.CreateFont("ixNewMenuFontTitleBlur", {
    font = "Purista",
	size = SScale(50),
	weight = SScale(900),
	blursize = 4,
	scanlines = 2,
	antialias = true,
	shadow = true,
	additive = true,
	outline = true
})

surface.CreateFont("ixNewMenuFontSecondTitle", {
    font = "Purista Light",
	size = SScale(20),
	weight = SScale(750),
	blursize = 0,
	scanlines = 2,
	antialias = true,
	shadow = true,
	additive = true,
    italic = true,
	outline = true
})

surface.CreateFont("ixNewMenuFontSecondTitleBlur", {
    font = "Purista Light",
	size = SScale(20),
	weight = SScale(750),
	blursize = 3,
	scanlines = 2,
	antialias = true,
	shadow = true,
	additive = true,
    italic = true,
	outline = true
})

/////////////////////////////////////////
//
//              VGUI Menu
//
/////////////////////////////////////////

local cc_grain = ix.util.GetMaterial("overlays/cc_grain")
local PANEL = {}

local function PaintButton(panel, w, h)
    if panel:IsHovered() then
        panel.Color.a = Lerp(0.075, panel.Color.a , ix.gui.newMenu.currentAlpha * 155)
    else
        panel.Color.a = Lerp(0.075, panel.Color.a , ix.gui.newMenu.currentAlpha * 90)
    end

    if panel:IsDown() then
        panel.Color.a = Lerp(0.075, panel.Color.a , ix.gui.newMenu.currentAlpha * 255)
    end

    ix.util.DrawBlur(panel, ix.gui.newMenu.currentAlpha * 2)
    surface.SetDrawColor(panel.Color)
    surface.DrawRect(0, 0, w, h)

    surface.SetDrawColor(255, 255, 255, ix.gui.newMenu.currentAlpha * 255)
    surface.SetMaterial(cc_grain)
    surface.DrawTexturedRect(0, 0, w, h)

    surface.SetFont("ixNewMenuFont")
    surface.SetTextColor(255, 255, 255, ix.gui.newMenu.currentAlpha * 255)
    surface.SetTextPos(SScale(5), VScale(30/6)) 
    surface.DrawText(panel.PrimaryText)

    surface.SetDrawColor(panel.Color)
    surface.DrawOutlinedRect(0, 0, w, h, 1)
end

function PANEL:Init()
    if IsValid(ix.gui.newMenu) then
        ix.gui.newMenu:Remove()
    end

    ix.gui.newMenu = self

    self.currentAlpha = 1
    self.ffClosing = false
    self.ffUsingCharacter = LocalPlayer().GetCharacter and LocalPlayer():GetCharacter()
    self.ffHasCharacters = #ix.characters > 0
    self.backgroundImage = table.random(backgrounds)
    self.backgroundAlpha = 1
    self:SetSize(ScrW(), ScrH())
    self:MakePopup()
    self:CreateButtons()
    self:CreateTipsPanel()

    self.notice = self:Add("ixNoticeBar")

    if (self.ffUsingCharacter) then
        self.disconnect.PrimaryText = "RETURN"
    end

    timer.create("ixNewMenu.BackgroundChanger", 10, 0, function()
        if !IsValid(ix.gui.newMenu) then
            timer.remove("ixNewMenu.BackgroundChanger")
            return
        end

        if !self.ffClosing then
            self:ChangeBackground()
        else
            timer.remove("ixNewMenu.BackgroundChanger")
        end
    end)
end

function PANEL:CreateButtons()
    self.buttonList = self:Add("Panel")
    self.buttonList:SetSize(SScale(151), VScale(170))
    self.buttonList:SetPos(ScrW()*.08, ScrH()*.55)

    self.newChar = self.buttonList:Add("DButton")
    self.newChar:SetSize(self.buttonList:GetWide(), VScale(30))
    self.newChar:SetText('')
    self.newChar:Dock(TOP)
    self.newChar.Color = Color(56, 180, 202, self.currentAlpha * 90)
    self.newChar.PrimaryText = "CREATE NEW CHARACTER"
    self.newChar.Paint = PaintButton
    function self.newChar:DoClick()
        surface.play_sound("minerva/ui/pano_ui_select_01.wav")
        local maximum = hook.run("GetMaxPlayerCharacter", LocalPlayer()) or ix.config.Get("maxCharacters", 5)

        if #ix.characters >= maximum then
			ix.gui.newMenu:ShowNotice(3, L("maxCharacters"))
			return
		end

        if !IsValid(ix.gui.newCharCreate) then
            vgui.Create("ixNewCharCreating")
        end
    end

    self.loadChar = self.buttonList:Add("DButton")
    self.loadChar:SetSize(self.buttonList:GetWide(), VScale(30))
    self.loadChar:SetText('')
    self.loadChar:Dock(TOP)
    self.loadChar:DockMargin(0, VScale(4/3), 0, 0)
    self.loadChar.Color = Color(56, 180, 202, self.currentAlpha * 90)
    self.loadChar.PrimaryText = "LOAD CHARACTER"
    self.loadChar.Paint = PaintButton
    function self.loadChar:DoClick()
        surface.play_sound("minerva/ui/pano_ui_select_01.wav")
    end

    if !self.ffHasCharacters then
        self.loadChar.Color = Color(255, 0, 0, 90)
        self.loadChar:SetDisabled(true)
    end

    self.content = self.buttonList:Add("DButton")
    self.content:SetSize(self.buttonList:GetWide(), VScale(30))
    self.content:SetText('')
    self.content:Dock(TOP)
    self.content:DockMargin(0, VScale(4/3), 0, 0)
    self.content.Color = Color(56, 180, 202, self.currentAlpha * 90)
    self.content.PrimaryText = "CONTENT"
    self.content.Paint = PaintButton
    function self.content:DoClick()
        surface.play_sound("minerva/ui/pano_ui_select_01.wav")
        gui.OpenURL('https://steamcommunity.com/sharedfiles/filedetails/?id=2349357641')
    end

    self.disconnect = self.buttonList:Add("DButton")
    self.disconnect:SetSize(self.buttonList:GetWide(), VScale(30))
    self.disconnect:SetText('')
    self.disconnect:Dock(BOTTOM)
    self.disconnect.Color = Color(56, 180, 202, self.currentAlpha * 90)
    self.disconnect.PrimaryText = "DISCONNECT"
    self.disconnect.Paint = PaintButton
    function self.disconnect:DoClick()
        surface.play_sound("minerva/ui/pano_ui_select_01.wav")
        if (self.PrimaryText == "RETURN") then
            if IsValid(ix.gui.newMenu) then
                ix.gui.newMenu.buttonList:Remove()
                ix.gui.newMenu:Close()
            end
        elseif (self.PrimaryText == "DISCONNECT") then
            self.PrimaryText = "ARE YOU SURE?"
            timer.Simple(5, function()
                if IsValid(ix.gui.newMenu) then
                    self.PrimaryText = "DISCONNECT"
                end
            end)
        elseif (self.PrimaryText == "ARE YOU SURE?") then
            if IsValid(ix.gui.newMenu) then
                ix.gui.newMenu:Remove()
            end
            RunConsoleCommand("disconnect")
        end
    end
end

function PANEL:UpdateDisconnectButton()
    if (self.ffUsingCharacter) then
        self.disconnect.PrimaryText = "RETURN"
    end
end

function PANEL:CreateTipsPanel()
    self.tipsPanel = self:Add("Panel")
    self.tipsPanel:SetSize( SScale(200), VScale(170) )
    self.tipsPanel:SetPos( ScrW()*.318, ScrH()*.55 ) -- ScrW()*.6
    self.tipsPanel.Paint = function(self, w, h)
        surface.SetDrawColor(56, 180, 202, ix.gui.newMenu.currentAlpha * 90)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(255, 255, 255, ix.gui.newMenu.currentAlpha * 255)
        surface.SetMaterial(cc_grain)
        surface.DrawTexturedRect(0, 0, w, h)

        surface.SetDrawColor(56, 180, 202, ix.gui.newMenu.currentAlpha * 90)
        surface.DrawOutlinedRect(0, 0, w, h, 1)
    end

    self.tipsText = self.tipsPanel:Add("RichText")
    self.tipsText:Dock(FILL)
    self.tipsText:InsertColorChange(255, 255, 255, self.currentAlpha * 255)
    self.tipsText:AppendText(table.random(schemaTips))
    function self.tipsText:PerformLayout()
        self:SetFontInternal("ixNewMenuFontTip")
    end
end

function PANEL:ChangeBackground()
    if (self.backgroundImage) then
        local ffStatus = self.ffClosing
        if ffStatus then return end
        local currentBG = self.backgroundImage
        local randomList = {}

        for _, bg in ipairs(backgrounds) do
            if bg == currentBG then continue end
            randomList[#randomList + 1] = bg
        end

        self:CreateAnimation(animationTime, {
            target = {backgroundAlpha = 0},
            easing = "linear",
            bIgnoreConfig = true,
            OnComplete = function(_, panel)
                if IsValid(ix.gui.newMenu) then
                    panel.backgroundImage = table.random(randomList)
                end
            end
        })

        timer.simple(animationTime + (animationTime*.2), function()
            if IsValid(ix.gui.newMenu) and !self.ffClosing then
                self:CreateAnimation(animationTime, {
                    target = {backgroundAlpha = 1},
                    easing = "linear",
                    bIgnoreConfig = true
                })
            end
        end)
    end
end

function PANEL:Paint(w, h)
    if (self.backgroundImage) then
        surface.SetDrawColor(0, 0, 0, self.currentAlpha * 255)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(255, 255, 255, self.backgroundAlpha * 255)
        surface.SetMaterial(self.backgroundImage)
        surface.DrawTexturedRect(0, 0, w, h)

        surface.SetDrawColor(255, 255, 255, self.currentAlpha * 255)
        surface.SetMaterial(cc_grain)
        surface.DrawTexturedRect(0, 0, w, h)

        surface.SetDrawColor(0, 0, 0, self.currentAlpha * 180)
        surface.DrawRect(0, 0, w, h)
    else
        ix.util.DrawBlur(self, 10)
    end

    surface.SetFont("ixNewMenuFontTitle")
    surface.SetTextColor(255, 255, 255, self.currentAlpha * 255)
    surface.SetTextPos(ScrW()*.078, ScrH()*.15) 
    surface.DrawText(title)

    surface.SetFont("ixNewMenuFontTitleBlur")
    surface.SetTextColor(255, 255, 255, self.currentAlpha * 255)
    surface.SetTextPos(ScrW()*.078, ScrH()*.15) 
    surface.DrawText(title)

    surface.SetFont("ixNewMenuFontSecondTitle")
    surface.SetTextColor(255, 0, 0, self.currentAlpha * 255)
    surface.SetTextPos(ScrW()*.078, ScrH()*.27) 
    surface.DrawText(subTitle)

    surface.SetFont("ixNewMenuFontSecondTitleBlur")
    surface.SetTextColor(255, 0, 0, self.currentAlpha * 255)
    surface.SetTextPos(ScrW()*.078, ScrH()*.27) 
    surface.DrawText(subTitle)

    draw.SimpleText(version, 'ixNewMenuFontSecondTitle', ScrW()*.5, ScrH()*.95, Color(255, 0, 0, self.currentAlpha * 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    draw.SimpleText(version, 'ixNewMenuFontSecondTitleBlur', ScrW()*.5, ScrH()*.95, Color(255, 0, 0, self.currentAlpha * 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    draw.SimpleText('Client logged into "'..LocalPlayer():SteamName()..'" account', 'ixNewMenuCredits', ScrW()*.997, ScrH()*.001, Color(161, 161, 161, self.currentAlpha * 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
    draw.SimpleText(os.date("%H:%M:%S - %d/%m/%Y", os.time()), 'ixNewMenuCredits', ScrW()*.997, ScrH()*.027, Color(161, 161, 161, self.currentAlpha * 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
end

function PANEL:ShowNotice(_type, text)
	self.notice:SetType(_type)
	self.notice:SetText(text)
	self.notice:Show()
end

function PANEL:HideNotice()
	if (IsValid(self.notice) and !self.notice:GetHidden()) then
		self.notice:Slide("up", 0.5, true)
	end
end

function PANEL:Close()
    CloseDermaMenus()
    self:SetMouseInputEnabled(false)
	self:SetKeyboardInputEnabled(false)
    gui.EnableScreenClicker(false)
    self.ffClosing = true

    if IsValid(self.tipsPanel) then
        self.tipsPanel:Remove()
    end

    self:CreateAnimation(1, {
        target = {currentAlpha = 0, backgroundAlpha = 0},
        easing = "outQuint",
        bIgnoreConfig = true,
        OnComplete = function(_, panel)
            panel:Remove()
        end
    })
end

vgui.Register('ixNewMenu', PANEL, 'Panel')

concommand.Add("f1", function()
    if !IsValid(ix.gui.newMenu) then
        vgui.Create('ixNewMenu')
    end
end)

concommand.Add("f1a", function()
    if IsValid(ix.gui.newMenu) then
        ix.gui.newMenu:Remove()
    end
end)