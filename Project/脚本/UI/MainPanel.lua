-- ��Ҫ���
local MainPanel = {}
local PanelName = "�������"
local Funcs = {
    ["�ַ�"] = "Hunt",
    ["�Թ�ǿ��ʯ"] = "MazeIntensify",
    ["����ǿ��ʯ"] = "MainLineIntensify",
    ["ˢ��ǩ"] = "RandomStore",
    ["������"] = "JJC"
}

local FuncNames = {"�ַ�", "�Թ�ǿ��ʯ", "����ǿ��ʯ", "ˢ��ǩ", "������"}

local Settings = {
    ["�ַ�����"] = "HuntSetting"
}

local SettingNames = {"�ַ�����"}

local Panel

function MainPanelHunt()
    Panel:AddTask("�ַ�")
end

function MainPanelMazeIntensify()
    Panel:AddTask("�Թ�ǿ��ʯ")
end

function MainPanelMainLineIntensify()
    Panel:AddTask("����ǿ��ʯ")
end

function MainPanelRandomStore()
    Panel:AddTask("ˢ��ǩ")
end

function MainPanelJJC()
    Panel:AddTask("������")
end

function MainPanelHuntSetting()
    UIMgr:OpenPanel("HuntSettingPanel")
end

function MainPanelStart()
    UIMgr:ClosePanel()
    TaskMgr:Start(Panel:GetTasks())
end

function MainPanel:Init()
    Panel = self
    self:InitUI()

    -- ����Task�б�
    self.allTask = {}
end

function MainPanel:AddTask(funcName)
    table.insert(self.allTask, funcName)
    self:RefreshTaskUI()
end

function MainPanel:GetTasks()
    local taskStr = ""
    for _, task in pairs(self.allTask) do
        if taskStr == "" then
            taskStr = task
        else
            taskStr = taskStr .. "|" .. task
        end
    end
    return taskStr
end

function MainPanel:RefreshTaskUI()
    ui.setEditText("taskEditText", self:GetTasks())
end

function MainPanel:InitUI()
    local newRow = function()
        ui.addRow(PanelName)
    end

    local addFunc = function(name, funcName)
        ui.addSpace(PanelName)
        ui.addButton(PanelName, name, name)
        ui.setOnClick(name, "MainPanel" .. funcName .. "()")
    end

    local addArea = function(names, table, rowId)
        local rowIndex = 0
        for _, name in pairs(names) do
            rowIndex = rowIndex + 1
            local funcName = table[name]
            addFunc(name, funcName)

            if rowIndex >= 4 then
                newRow()
                rowIndex = 0
            end
        end
    end

    ui.newLayout(PanelName, 700, 500)

    -- Task�б�
    ui.addSpace(PanelName)
    ui.addTextView(PanelName, "text", "�����б�")
    ui.addSpace(PanelName)
    ui.addEditText(PanelName, "taskEditText", "")

    -- func����
    newRow()
    addArea(FuncNames, Funcs, 1)

    -- line
    newRow()
    ui.addLine(PanelName, "line1", -1, 3)
    newRow()

    -- setting����
    addArea(SettingNames, Settings, 2)

    -- last
    newRow()
    ui.addLine(PanelName, "line2", -1, 3)
    newRow()
    ui.addSpace(PanelName)
    ui.addButton(PanelName, "Start", "��ʼ")
    ui.setOnClick("Start", "MainPanelStart()")

    ui.show(PanelName)
end

function MainPanel:Release()
    ui.dismiss(PanelName)
end

return MainPanel
