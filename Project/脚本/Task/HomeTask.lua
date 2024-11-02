local BaseTask = require("Task.BaseTask")
---@class HomeTask:BaseTask 该类负责回退到Home
local HomeTask = class("HomeTask", BaseTask)

---@type MulTapStep
local MulTapStep = require("Step.MulTapStep")

local Point1 = {1219, 31, 1265, 52, "4487EB", "18|0|4487EB", 0, 0.9}
--local Point2 = {1080, 665, 1123, 703, "FFFFFF", "8|3|FFFFFF|15|3|FFFFFF", 0, 0.9}
local Point2 = {1078,663,1164,704,"FFFFFF","7|6|FFFFFF|15|5|FFFFFF|4|-9|0D213B|12|-9|0D213B",0,0.98}

local points = {Point1, Point2}

function HomeTask:initialize()
    BaseTask.initialize(self, "主界面")
end

function HomeTask:Enter()
    MulTapStep:SetPoint(points)
end

function HomeTask:Update()
    Util.WaitTime(1)
    MulTapStep:Execute()
    if MulTapStep:IsComplete() then
        self:Completed()
    end
end

return HomeTask
