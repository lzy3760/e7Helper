local UIMgr = {}

local PanelType = {
    ["MainPanel"] = require("UI.MainPanel"),
    ["HuntSettingPanel"] = require("UI.HuntSettingPanel")
}

function UIMgr:Init()
    self.curPanel = nil
end

function UIMgr:Enter()
    log("启动UIMgr")
    self:OpenPanel("MainPanel")
end

function UIMgr:OpenPanel(panelName)
    if not PanelType[panelName] then
        logError("没有这个panel界面" .. panelName)
        return
    end

    if self.curPanel then
        self.curPanel:Release()
    end

    log("打开界面->>>>" .. panelName)
    local panel = PanelType[panelName]
    self.curPanel = panel
    self.curPanel:Init()
end

function UIMgr:ClosePanel()
    if self.curPanel then
        self.curPanel:Release() 
    end
end

_G.UIMgr = UIMgr
