local UIMgr = {}

local PanelType = 
{
    ["MainPanel"] = require("UI.MainPanel"),
}

function UIMgr:Init()
    self.curPanel = nil
end

function UIMgr:Enter()
    log("Æô¶¯UIMgr")
    self:OpenPanel("MainPanel")
end

function UIMgr:OpenPanel(panelName)
    if not PanelType[panelName] then
        return
    end

    if self.curPanel then
        self.curPanel:Release() 
    end

    local panel = PanelType[panelName]
    self.curPanel = panel
    self.curPanel:Init()
end

_G.UIMgr = UIMgr