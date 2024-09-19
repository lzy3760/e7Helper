-- Main function panel
local MainPanel = {}

local Buttons = {"ˢ�̵�", "ˢ������", "�ַ�", "��ʿ���ճ�", "ˢ���", "��Ҷ��", "����֮ɭ",
                 "ˮˮˮˮ", "��������", "ʿ�����"}

function MainPanel:Init()
    ui.newLayout("MainPanel", 700, 400)
    local index = 1
    for i = 1, 4 do
        ui.newRow("MainPanel", "row" .. i, 700, 100)
        for j = 1, 4 do
            if index <= #Buttons then
                local btnName = Buttons[index]
                ui.addButton("row" .. i, BtnName.StoreName, "ˢ�̵�")
                ui.setButton("MainPanel_Btn" .. index, btnName, 100, 100)
                index = index + 1
            end
        end
    end
    ui.show("MainPanel")
end

function MainPanel:Release()
    ui.dismiss("MainPanel")
end

return MainPanel
