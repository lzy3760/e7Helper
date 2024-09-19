---@class Timer
local Timer = class("Timer")
local xpcall = xpcall

Timer.TimerType = {
    DelayTime = 1,
    DelayFrame = 2,
    LoopTime = 3,
    LoopFrame = 4
}

function Timer:initialize(timerType, ...)
    if timerType == Timer.TimerType.DelayTime then
        self:NewTime(...)
    elseif timerType == Timer.TimerType.LoopTime then
        self:LoopTimeNew(...)
        -- elseif timerType == Timer.TimerType.DelayFrame then
        --     self:NewFrame(...)
        -- elseif timerType == Timer.TimerType.LoopFrame then
        --     self:NewLoopFrame(...)
    end

    self.timerType = timerType
end

function Timer:UpdateTimer(nowTime)
    if self.timerType == Timer.TimerType.DelayTime then
        self:UpdateTime(nowTime)
    elseif self.timerType == Timer.TimerType.LoopTime then
        self:UpdateLoopTime(nowTime)
        -- elseif self.timerType == Timer.TimerType.DelayFrame then
        --     self:UpdateFrame(deltaTime, realDeltaTime)
        -- elseif self.timerType == Timer.TimerType.LoopFrame then
        --     self:UpdateLoopFrame(deltaTime, realDeltaTime)
    end
end

function Timer:TryDelete()
    if self.timerType == Timer.TimerType.DelayTime then
        return self:DeleteTime()
    elseif self.timerType == Timer.TimerType.LoopTime then
        return self:DeleteLoopTime()
        -- elseif self.timerType == Timer.TimerType.DelayFrame then
        --     return self:DeleteFrame()
        -- elseif self.timerType == Timer.TimerType.LoopFrame then
        --     return self:DeleteLoopFrame()
    end
end

function Timer:Invoke()
    if self.caller then
        self.func(self.caller)
    else
        self.func()
    end
end

function Timer:Stop()
    self.stop = true
end

-- region NewTimer 延迟几秒走一次
function Timer:NewTime(...)
    local param = {...}
    self.endTime = param[1]
    self.func = param[2]
    self.caller = param[3]
end

function Timer:UpdateTime(nowTime)
    if nowTime >= self.endTime then
        self:Invoke()
        self.endTime = -1
    end
end

function Timer:DeleteTime()
    return self.endTime <= 0
end

-- endregion

-- region LoopTimer 每多少秒走一次，一共走几次
function Timer:LoopTimeNew(...)
    local param = {...}
    self.interval = param[1]
    self.func = param[2]
    self.caller = param[3]
    local nowTime = param[4]
    self.loopCount = param[5]

    self.endTime = self.interval + nowTime
    if self.loopCount and self.loopCount > 0 then
        self.loopCount = self.loopCount - 1
    end
end

function Timer:UpdateLoopTime(nowTime)
    if nowTime >= self.endTime then
        self:Invoke()
        if not self.loopCount then
            self.endTime = self.interval + nowTime
        elseif self.loopCount > 0 then
            self.loopCount = self.loopCount - 1
            self.endTime = self.interval + nowTime

            if self.loopCount == 0 then
                self.endTime = -1
            end
        end
    end
end

function Timer:DeleteLoopTime()
    if not self.loopCount then
        return false
    end

    return self.endTime <= 0 and self.loopCount == 0
end

-- endregion

-- region FrameTimer 延迟多少帧走一次

-- function Timer:NewFrame(...)
--     local param = {...}
--     self.loopCount = param[1]
--     self.func = param[2]
--     self.caller = param[3]
-- end

-- function Timer:UpdateFrame(deltaTime, realDeltaTime)
--     self.loopCount = self.loopCount - 1
--     if self.loopCount <= 0 then
--         self:Invoke()
--     end
-- end

-- function Timer:DeleteFrame()
--     return self.loopCount <= 0
-- end

-- endregion

-- region LoopFrameTimer 每帧走一次

-- function Timer:NewLoopFrame(...)
--     local param = {...}
--     self.frameCount = param[1]
--     self.func = param[2]
--     self.caller = param[3]
-- end

-- function Timer:UpdateLoopFrame(deltaTime, realDeltaTime)
--     self:Invoke()
--     self.frameCount = self.frameCount - 1
-- end

-- function Timer:DeleteLoopFrame()
--     return self.frameCount <= 0
-- end

-- endregion

return Timer
