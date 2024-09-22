local UIMgr = {}

local PanelType = {
    ["MainPanel"] = require("UI.MainPanel"),
    ["HuntSettingPanel"] = require("UI.HuntSettingPanel")
}

function UIMgr:Init()
    self.curPanel = nil
end

function UIMgr:Enter()
    log("����UIMgr")
    self:OpenPanel("MainPanel")
end

function UIMgr:OpenPanel(panelName)
    if not PanelType[panelName] then
        logError("û�����panel����" .. panelName)
        return
    end

    if self.curPanel then
        self.curPanel:Release()
    end

    log("�򿪽���->>>>" .. panelName)
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
