-- Main function panel
local MainPanel = {}

local Buttons = {"Shua Shang Dian", "JJC", "Qi Shi Tuan", "Shua Qi E", "Shua Ye Zi", "Huo Huo Huo", "Shui Shui Shui"}

function MainPanel:Init()
    ui.newLayout("MainPanel", 700, 400)
    ui.addButton("MainPanel", "btn", "hello1")
    ui.addButton("MainPanel", "btn1", "hello2")
    ui.newRow("MainPanel", "row1")
    ui.addButton("layout1", "btn2", "hello3")
    ui.show("MainPanel")
end

function MainPanel:Release()
    ui.dismiss("MainPanel")
end

return MainPanel
