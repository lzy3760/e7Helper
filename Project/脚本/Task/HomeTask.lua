local BaseTask = require("Task.BaseTask")
---@class HomeTask:BaseTask 该类负责回退到Home
local HomeTask = class("HomeTask", BaseTask)

local SettingColor = ""
local ClickSettingPos = {
    x = 0,
    y = 0
}

local ToHomeColor = ""
local ClickHomePos = {
    x = 0,
    y = 0
}

function HomeTask:initialize()
    BaseTask.initialize(self, "主界面")
end

function HomeTask:Enter()
    -- self:Completed()
    self.step = 1
end

function HomeTask:Update()
    if self.step == 1 then
        if Util.CompareColor(SettingColor) then
            Util.Click(ClickSettingPos.x, ClickSettingPos.y)
            self:AddStep()
        end
    elseif self.step == 2 then
        if Util.CompareColor(ToHomeColor) then
            Util.Click(ClickHomePos.x, ClickHomePos.y)
            self:Completed()
        end
    end
end

return HomeTask
