local UIMgr = {}

local PanelType = 
{
    ["MainPanel"] = require("UI.MainPanel"),
}

function UIMgr:Init()
    self.curPanel = nil
end

function UIMgr:Enter()
    log("启动UIMgr")
    --self:OpenPanel("MainPanel")
end

function UIMgr:OpenPanel(panelName)
    if not PanelType[panelName] then
        return
    end

    if self.curPanel then
        self.curPanel:Release() 
    end

	log("打开界面->>>>"..panelName)
    local panel = PanelType[panelName]
    self.curPanel = panel
    self.curPanel:Init()
end

_G.UIMgr = UIMgr