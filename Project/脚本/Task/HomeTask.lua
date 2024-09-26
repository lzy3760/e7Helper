local BaseTask = require("Task.BaseTask")
---@class HomeTask:BaseTask 该类负责回退到Home
local HomeTask = class("HomeTask", BaseTask)

local MulTapStep = require("Step.MulTapStep")

function HomeTask:initialize()
    BaseTask.initialize(self, "主界面")
end

function HomeTask:Enter()
    MulTapStep:SetPoint({}, 1)
end

function HomeTask:Update()
    MulTapStep:Execute()
    if MulTapStep:IsComplete() then
        self:Completed()
    end
end

return HomeTask
