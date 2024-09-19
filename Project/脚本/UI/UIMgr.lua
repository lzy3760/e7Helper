local UIMgr = {}
local MainPanel = require("UI.MainPanel")

function UIMgr:Init()
end

function UIMgr:Enter()
    print("Æô¶¯UIMgr")
    MainPanel:Init()
end

_G.UIMgr = UIMgr