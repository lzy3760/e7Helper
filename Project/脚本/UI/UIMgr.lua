local UIMgr = {}

local PanelType = 
{
    ["MainPanel"] = require("UI.MainPanel"),
}

function UIMgr:Init()
end

function UIMgr:Enter()
    print("����UIMgr")
    MainPanel:Init()
end

function UIMgr:OpenPanel(panelType)

end

_G.UIMgr = UIMgr