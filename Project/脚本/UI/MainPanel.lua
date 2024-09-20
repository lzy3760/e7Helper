-- 主要面板
local MainPanel = {}
local PanelName = "功能面板"
local Funcs = {
    RandomStore = "刷书签",
    EveryDayStore = "每日商城购买",
    ShuaQiE = "刷企鹅",
    TaoFa = "讨伐开启",
    MuLongMiGong = "一票木龙",
    MiGong = "迷宫",
    Test1 = "测试1",
    Test2 = "测试2"
}

function MainPanel:Init()
    ui.newLayout(PanelName, 700, 400)
    ui.addButton(PanelName, Funcs.RandomStore, "刷商店")
    ui.addButton(PanelName, Funcs.EveryDayStore, "每日商城")
    ui.addButton(PanelName, Funcs.ShuaQiE, "刷企鹅")
    ui.addButton(PanelName, Funcs.TaoFa, "讨伐")
    ui.newRow(PanelName, "Row1")
    ui.addButton(PanelName, Funcs.MuLongMiGong, "木龙迷宫")
    ui.addButton(PanelName, Funcs.MiGong, "迷宫")
    ui.addButton(PanelName, Funcs.Test1, "Test1")
    ui.addButton(PanelName, Funcs.Test2, "Test2")
    ui.show(PanelName)
end

function MainPanel:Release()
    ui.dismiss(PanelName)
end

return MainPanel
