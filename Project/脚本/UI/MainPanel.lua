-- ��Ҫ���
local MainPanel = {}
local PanelName = "�������"
local Funcs = {
    RandomStore = "ˢ��ǩ",
    EveryDayStore = "ÿ���̳ǹ���",
    ShuaQiE = "ˢ���",
    TaoFa = "�ַ�����",
    MuLongMiGong = "һƱľ��",
    MiGong = "�Թ�",
    Test1 = "����1",
    Test2 = "����2"
}

function MainPanel:Init()
    ui.newLayout(PanelName, 700, 400)
    ui.addButton(PanelName, Funcs.RandomStore, "ˢ�̵�")
    ui.addButton(PanelName, Funcs.EveryDayStore, "ÿ���̳�")
    ui.addButton(PanelName, Funcs.ShuaQiE, "ˢ���")
    ui.addButton(PanelName, Funcs.TaoFa, "�ַ�")
    ui.newRow(PanelName, "Row1")
    ui.addButton(PanelName, Funcs.MuLongMiGong, "ľ���Թ�")
    ui.addButton(PanelName, Funcs.MiGong, "�Թ�")
    ui.addButton(PanelName, Funcs.Test1, "Test1")
    ui.addButton(PanelName, Funcs.Test2, "Test2")
    ui.show(PanelName)
end

function MainPanel:Release()
    ui.dismiss(PanelName)
end

return MainPanel
