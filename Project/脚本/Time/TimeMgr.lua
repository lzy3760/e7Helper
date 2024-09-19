local Timer = require("Project.½Å±¾.Time.Timer")

local TimeMgr = {}

function TimeMgr:Init()
    self.timers = {}
end

function TimeMgr:Enter()
end

function TimeMgr:Update()
    for k, v in pairs(self.timers) do
        if v.stop then
            self.timers[k] = nil
        else
            v:UpdateTimer(Util.GetNowTime())
            if v:TryDelete() then
                self.timers[k] = nil
            end
        end
    end
end

function TimeMgr:Release()
    self.timers = {}
end

function TimeMgr:DelayTime(time, func, caller)
    if not time or time == 0 then
        return
    end

    local timer = Timer:new(Timer.TimerType.DelayTime, time, func, caller)
    table.insert(self.timers, timer)
    return timer
end

function TimerMgr:LoopTime(interval, func, loopCount)
    if not interval or interval == 0 then
        return
    end

    if not func then
        return
    end

    local timer = Timer:new(Timer.TimerType.LoopTime, interval, func, Util.GetNowTime(), loopCount)
    table.insert(self.timers, timer)
    return timer
end

_G.TimeMgr = TimeMgr
