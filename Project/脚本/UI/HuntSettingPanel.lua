local SettingPanel = {}
local PanelName = "�ַ����ý���"

local Panel

function HuntSettingPanelSave()
    Panel:Save()
    UIMgr:OpenPanel("MainPanel")
end

function SettingPanel:Init()
    Panel = self
    self.huntSet = SettingMgr:GetSet("HuntSet")
    self:InitUI()
end

function SettingPanel:InitUI()
    ui.newLayout(PanelName, 400, 350)
    ui.addSpace(PanelName)
    ui.addTextView(PanelName, "text1", "�ַ�Ŀ��")
    ui.addSpinner(PanelName, "HuntTargetSpin", {"���ַ�", "ľ�ַ�", "ˮ�ַ�", "���ַ�", "���ַ�"},
        self.huntSet.huntType - 1)
    ui.addRow(PanelName)
    ui.addSpace(PanelName)
    ui.addTextView(PanelName, "text2", "�ַ�����")
    ui.addEditText(PanelName, "editText", tostring(self.huntSet.huntCount))

    ui.addRow(PanelName)
    ui.addButton(PanelName, "Save", "����")
    ui.setOnClick("Save", "HuntSettingPanelSave()")

    ui.show(PanelName)
end

function SettingPanel:Save()
    self.huntSet.huntType = tonumber(ui.getValue("HuntTargetSpin")) + 1
    self.huntSet.huntCount = tonumber(ui.getValue("editText"))
end

function SettingPanel:Release()
    ui.dismiss(PanelName)
end

return SettingPanel
