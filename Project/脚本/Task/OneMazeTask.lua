local BaseTask = require("Task.BaseTask")
---@class OneMazeTask:BaseTask 一票迷宫
local OneMazeTask = class("OneMazeTask", BaseTask)

local MulClickStep = require("Step.MulClickStep")

local Type = {
    Normal = 1,
    Portal = 2,
    JumpArea = 3
}

local Configs =
{
    --[[
        --普通跳转 "W"
        --传送门跳转 "W",Type.Portal
        --点击传送 "W",Type.JumpArea,{x,y}
    ]]
    { MazeDir.W },
    { MazeDir.S },
    { MazeDir.S, Type.Portal },

}

function OneMazeTask:Enter()
    self.step = 1
end

function OneMazeTask:Update()
    Util.Invoke(self, "Step" .. self.curStep)
end

function OneMazeTask:Step1()
    -- 消耗体力
    for i = 0, 35 do
        Util.WaitTime(0.5)
        GameUtil.ClickMazeDir(MazeDir.N)
        Util.WaitTime(0.5)
        GameUtil.ClickMazeDir(MazeDir.S)
    end

    self:AddStep()
end

function OneMazeTask:Step2()
    if not GameUtil.IsInMazeSelect() then
        return
    end

    local stepCfg = Configs[self.step]
    if #stepCfg == 1 then
        self:NormalClick(stepCfg)
    elseif #stepCfg == 2 then
        self:ClickProtal(stepCfg)
    elseif #stepCfg == 3 then
        self:JumpArea(stepCfg)
    end

    self.step = self.step + 1
    if self.step > #Configs then
        self:Completed()
    end
end

-- 普通点击
function OneMazeTask:NormalClick(cfg)
    local dir = cfg[1]
    GameUtil.ClickMazeDir(dir)
end

-- 点击传送门
function OneMazeTask:ClickProtal(cfg)
    local points = {{}, {}}
    MulClickStep:Execute(points, 0.5)
end

-- 点击地图传送
function OneMazeTask:JumpArea(cfg)
    local points = {{}, {}}
    local jumpPos = cfg[3]
    table.insert(points, 2, jumpPos)
    MulClickStep:Execute(points, 0.5)
end

return OneMazeTask
