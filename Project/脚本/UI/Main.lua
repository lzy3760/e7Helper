-- Main function panel
local MainPanel = {}

local Buttons = {"刷商店", "刷竞技场", "讨伐", "骑士团日常", "刷企鹅", "换叶子", "精灵之森",
                 "水水水水", "霍霍霍霍", "士大夫发射"}

function MainPanel:Init()
    ui.newLayout("MainPanel", 700, 400)
    local index = 1
    for i = 1, 4 do
        ui.newRow("MainPanel", "row" .. i, 700, 100)
        for j = 1, 4 do
            if index <= #Buttons then
                local btnName = Buttons[index]
                ui.addButton("row" .. i, BtnName.StoreName, "刷商店")
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
