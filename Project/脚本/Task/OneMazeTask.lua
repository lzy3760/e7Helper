local Type = {
    Normal = 1,
    Portal = 2,
    JumpArea = 3
}


local Configs =
{
    --[[
        --Normal "W"
        --Portal "W",Type.Portal
        --JumpArea "W",Type.JumpArea,{x,y}
    ]]

    { MazeDir.N }, --Step 1
    { MazeDir.N },
    { MazeDir.S },
    { MazeDir.S },
    { MazeDir.E },
    { MazeDir.E },
    { MazeDir.None, Type.Portal },
    { MazeDir.W },
    { MazeDir.W },
    { MazeDir.S }, --Step 10
    { MazeDir.W },
    { MazeDir.S },
    { MazeDir.None, Type.Portal },
    { MazeDir.N },
    { MazeDir.W },
    { MazeDir.S },
    { MazeDir.W },
    { MazeDir.None, Type.Portal },
    { MazeDir.E },
    { MazeDir.N }, --Step20
    { MazeDir.None, Type.Portal },
    { MazeDir.S },
    { MazeDir.W },
    { MazeDir.W },
    { MazeDir.W },
    { MazeDir.None, Type.Portal },
    { MazeDir.E },
    { MazeDir.E },
    { MazeDir.S },
    { MazeDir.W }, --Step30
    { MazeDir.None, Type.Portal },
    { MazeDir.W },
    { MazeDir.W },
    { MazeDir.S },
    { MazeDir.W },
    { MazeDir.None, Type.Portal },
    { MazeDir.S },
    { MazeDir.E },
    { MazeDir.S },
    { MazeDir.S }, --Step 40
    { MazeDir.S },
    { MazeDir.S },
    { MazeDir.W },
    { MazeDir.S },
    { MazeDir.S },
    { MazeDir.E },
    { MazeDir.E },
    { MazeDir.N },
    { MazeDir.N },
    { MazeDir.W }, -- Step 50
    { MazeDir.S },
    { MazeDir.E },
    { MazeDir.W },
    { MazeDir.W },
    { MazeDir.E },
    { MazeDir.S },
    { MazeDir.S },
    { MazeDir.S },
    { MazeDir.E },
    { MazeDir.N }, --Step 60
    { MazeDir.None, Type.Portal },
    { MazeDir.E },
    { MazeDir.N },
    { MazeDir.S },
    { MazeDir.S },
    { MazeDir.None, Type.Portal },
    { MazeDir.N },
    { MazeDir.N },
    { MazeDir.S },
    { MazeDir.W }, --- Step 70
    { MazeDir.N },
    { MazeDir.S },
    { MazeDir.W },
    { MazeDir.E },
    { MazeDir.S },
    { MazeDir.None, Type.Portal },
    { MazeDir.W },
    { MazeDir.N },
    { MazeDir.None, Type.Portal },
    { MazeDir.N }, --Step 80
    { MazeDir.W },
    { MazeDir.E },
    { MazeDir.N },
    { MazeDir.None, Type.Portal },
    { MazeDir.S },
    { MazeDir.E },
    { MazeDir.N },
    { MazeDir.E },
    { MazeDir.E },
    { MazeDir.W }, --Step 90
    { MazeDir.S },
    { MazeDir.W },
    { MazeDir.E },
    { MazeDir.E },
    { MazeDir.S },
    { MazeDir.N },
    { MazeDir.N },
    { MazeDir.W },
    { MazeDir.None, Type.Portal },
    { MazeDir.W }, --Step 100
    { MazeDir.W },
    { MazeDir.N },
    { MazeDir.W },
    { MazeDir.S },
    { MazeDir.E },
    { MazeDir.S },
    { MazeDir.None, Type.Portal },
    { MazeDir.S },
    { MazeDir.W },
    { MazeDir.S },              --Step 110
    { MazeDir.W },
    { MazeDir.None, Type.Portal }, --Return
}



local BaseTask = require("Task.BaseTask")
---@class OneMazeTask:BaseTask 一票迷宫
local OneMazeTask = class("OneMazeTask", BaseTask)

local MulClickStep = require("Step.MulClickStep")



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
        if self:CheckMazeStone() then
            Util.Click()
        end
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

--检查迷宫石堆
function OneMazeTask:CheckMazeStone()
    return false
end

return OneMazeTask
