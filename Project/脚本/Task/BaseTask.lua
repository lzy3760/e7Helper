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

function Task:Completed()
    self.isFinish = true
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

local HomeColor = "55|632|FFFFFF,145|640|EBEBEB,232|650|C3C3C3,334|635|FFFFFF,421|634|FFFFFF"
-- 是否处于主界面
function Task:IsInHome()
    return Util.CompareColor(HomeColor)
end

local QuickBattle = "1214|641|0B0201,1234|662|201D1C,1250|679|090200"

-- 是否关闭快速挑战
function Task:IsQuickBattle()
    return Util.CompareColor(QuickBattle)
    -- todo 修改为findColor
end

-- 设置快速挑战
function Task:SetQuickBattle()
    Util.Click(1233, 664)
end

local ContinueBattle = "5BBB02"
-- 连续挑战
function Task:IsContinueBattle()
    -- return Util.CompareColor(ContinueBattle)
    local suc, x, y = Util.FindColor(574, 540, 605, 565, ContinueBattle, FindDir.LeftUpToRightDown)
    return suc
end

-- 设置连续挑战
function Task:SetContinueBattle()
    Util.Click(582, 559)
end

local Battle = {"1002|698|D6F7FF,1007|693|D6F7FF", "1080|698|D6F7FF,1084|694|D6F7FF", "1158|698|D6F7FF,1163|693|D6F7FF",
                "1237|697|D6F7FF,1241|694|D6F7FF"}

-- 是否在自动战斗
function Task:IsAutoBattle()
    for _, color in pairs(Battle) do
        local suc = Util.CompareColor(color, 0.5)
        if suc then
            log("是在自动战斗")
            return true
        else
            log("不是在自动战斗")
        end
    end
    return false
end

-- 设置自动战斗
function Task:SetAutoBattle()
    Util.Click(1125, 34)
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
    log("进入第" .. self.curStep .. "步")
    Util.WaitTime(1)
end

function Task:ReduceStep()
    self.curStep = self.curStep - 1
end

-- 跳转到step
function Task:ChangeStep(step)
    self.curStep = step
    log("跳转到第" .. self.curStep .. "步")
    Util.WaitTime(1)
end

return Task
