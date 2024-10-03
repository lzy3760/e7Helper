local BaseTask = require("Task.BaseTask")
---@class HomeTask:BaseTask 该类负责回退到Home
local HomeTask = class("HomeTask", BaseTask)

local MulTapStep = require("Step.MulTapStep")

local points = {{1221, 14, 1262, 52, "4487EB", "8|8|4487EB"}, {1074, 664, 1171, 706, "FFFFFF", "14|7|FFFFFF"}}

function HomeTask:initialize()
    BaseTask.initialize(self, "主界面")
end

function HomeTask:Enter()
    MulTapStep:SetPoint(points)
end

function HomeTask:Update()
    MulTapStep:Execute()
    if MulTapStep:IsComplete() then
        self:Completed()
    end
end

return HomeTask
