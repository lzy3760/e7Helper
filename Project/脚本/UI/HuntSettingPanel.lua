local SettingPanel = {}
local PanelName = "Ã÷∑•…Ë÷√ΩÁ√Ê"

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
    ui.addTextView(PanelName, "text1", "Ã÷∑•ƒø±Í")
    ui.addSpinner(PanelName, "HuntTargetSpin", {"ªÃ÷∑•", "ƒæÃ÷∑•", "ÀÆÃ÷∑•", "∞µÃ÷∑•", "π‚Ã÷∑•"},
        self.huntSet.huntType - 1)
    ui.addRow(PanelName)
    ui.addSpace(PanelName)
    ui.addTextView(PanelName, "text2", "Ã÷∑•¥Œ ˝")
    ui.addEditText(PanelName, "editText", tostring(self.huntSet.huntCount))

    ui.addRow(PanelName)
    ui.addButton(PanelName, "Save", "±£¥Ê")
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
