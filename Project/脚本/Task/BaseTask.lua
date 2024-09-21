---@class BaseTask
local Task = class("TaskMgr.BaseTask")

function Task:initialize(taskType)
    self.taskType = taskType
    self.isFinish = false
    self.isPause = false
    self.curStep = 1
end

function Task:Enter()
end

function Task:Update()

end

function Task:Release()
end

-- 暂停该Task
function Task:Pause()
    self.isPause = true
end

-- 该Task是否暂停
function Task:IsPause()
    return self.isPause
end

-- 继续Task
function Task:Resume()
    self.isPause = false
end

-- 是否处于副本中,该判断只判断是否在普通的副本
-- 后期特殊的副本可能采色有问题
function Task:IsInBattle()

end

-- 是否处于主界面
function Task:IsInHome()
end

-- 是否在自动战斗
function Task:IsAutoBattle()

end

-- 设置自动战斗
function Task:SetAutoBattle()
    -- tap
end

-- 一直点击直到满足什么条件
---@param internal number 点击间隔
---@param func function 回调
function Task:ClickUtil(x, y, internal, checkFunc, func)
    if self.loopClick then
        logError("重复点击检测到了冲突!!")
    end

    self.loopClick = true
    self.clickInternal = internal
end

function Task:AddStep()
    self.curStep = self.curStep + 1
end

--跳转到step
function Task:ChangeStep(step)
    self.curStep = step
end

return Task
