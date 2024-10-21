---@class BaseTask
local Task = class("TaskMgr.BaseTask")

function Task:initialize(taskType)
    self.taskType = taskType
    self.isFinish = false
    self.isPause = false
    self.curStep = 1
    self.operation = false
end

function Task:Enter()
end

function Task:Update()
end

function Task:Release()
end

function Task:Completed()
    self.isFinish = true
end

-- 暂停该Task
function Task:Pause(isReduceStep)
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
    self.operation = false
    log(self.taskType .. "进入第" .. self.curStep .. "步")
    Util.WaitTime(1)
end

function Task:ReduceStep()
    self.curStep = self.curStep - 1
end

-- 跳转到step
function Task:ChangeStep(step)
    self.curStep = step
    self.operation = false
    log(self.taskType .. "跳转到第" .. self.curStep .. "步")
    Util.WaitTime(1)
end

function Task:MarkOperation()
    self.operation = true
end

function Task:HasOperation()
    return self.operation
end

return Task
