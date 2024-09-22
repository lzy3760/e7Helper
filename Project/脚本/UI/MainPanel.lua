-- ��Ҫ���
local MainPanel = {}
local PanelName = "�������"
local Funcs = {
    ["�ַ�"] = "Hunt"
}

local Settings = {
    ["�ַ�����"] = "HuntSetting"
}

local Panel

function MainPanelHunt()
    Panel:AddTask("�ַ�")
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

    local addArea = function(funcs, rowId)
        local rowIndex = 0
        for name, funcName in pairs(funcs) do
            rowIndex = rowIndex + 1
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
    addArea(Funcs, 1)

    -- line
    newRow()
    ui.addLine(PanelName, "line1", -1, 3)
    newRow()

    -- setting����
    addArea(Settings, 2)

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
