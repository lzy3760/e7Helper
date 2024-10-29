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
    {MazeDir.None,Type.JumpArea,{{114,67},{896,361},{743,450}}},
    --{MazeDir.None,Type.JumpArea,{{114,67},{739,525},{743,450}}},
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
    { MazeDir.S },                 --Step 110
    { MazeDir.W },
    --{ MazeDir.None, Type.Portal }, --Return
}

local BaseTask = require("Task.BaseTask")
---@class OneMazeTask:BaseTask
local OneMazeTask = class("OneMazeTask", BaseTask)

local BattleAutoStep = require("Step.BattleAutoStep")
local MulClickStep = require("Step.MulClickStep")

function OneMazeTask:initialize()
    BaseTask.initialize(self, "一票木龙")
end

function OneMazeTask:Enter()
    self.step = 1
    --当前迷宫步骤步数
    -- self.step = 94
    -- self.curStep =3
    self.curConsumeCount = 0
    self.consumeCount = 45
    self.state = MazeDir.N
end

function OneMazeTask:Update()
    Util.Invoke(self, "Step" .. self.curStep)
end

function OneMazeTask:Step1()
    if self.curConsumeCount >= self.consumeCount then
        self:AddStep()
        return
    end

    Util.WaitTime(0.3)
    if self.state == MazeDir.N then
        local suc = GameUtil.ClickMazeDir(MazeDir.N)
        if suc then
            self.state = MazeDir.S
            --log("点击N成功")
        end
    elseif self.state == MazeDir.S then
        local suc = GameUtil.ClickMazeDir(MazeDir.S)
        if suc then
            self.state = MazeDir.N
            self.curConsumeCount = self.curConsumeCount + 1
            --log("点击S成功")
        end
    end
end

function OneMazeTask:Step2()
    if BattleAutoStep:Execute() then
        self:AddStep()
    end
end

function OneMazeTask:Step3()
    if self:CheckMazeStone() then
        Util.Click(610,477)
        log("点击石头")
        return 
    end

    local inMaze = GameUtil.IsInMazeSelect()
    local stepCfg = Configs[self.step]
    local suc = false
    if #stepCfg == 1 and inMaze then
        Util.WaitTime(0.3)
        suc = self:NormalClick(stepCfg)
    elseif #stepCfg == 2 then
        Util.WaitTime(1)
        log("时空闸门判断")
        suc = self:ClickProtal(stepCfg)
    elseif #stepCfg == 3 then
        Util.WaitTime(1)
        suc = self:JumpArea(stepCfg)
    end

    if suc then
        self.step = self.step + 1
        log("当前迷宫步数:" .. tostring(self.step))
        if self.step > #Configs then
            self:Completed()
        end
    end
end

function OneMazeTask:NormalClick(cfg)
    local dir = cfg[1]
    local suc = GameUtil.ClickMazeDir(dir)
    return suc
end

--local points = {{650, 390}, {650, 390}, {744, 478}}
--local PortalColor = {409,423,879,534,"2E2119","169|-3|2E2017|207|-1|142644|383|0|142643",0,0.7}
local PortalColor = {"549|474|FFFFFF,624|475|2E2017,655|477|142644,757|474|FFFFFF", 0.9}

function OneMazeTask:ClickProtal(cfg)
    local inMaze = GameUtil.IsInMazeSelect()
    if not Util.CompareColorByTable(PortalColor) then
        if inMaze then
            if not self.portalState then
                log("没有操作，点击闸门入口")
                Util.Click(650, 390)
            else
                self.portalState = nil
                return true
            end
        end
    else
        log("点击确定按钮")
        Util.Click(744, 478)
        self.portalState = true
    end

    return false
end

function OneMazeTask:JumpArea(cfg)
    local inMaze = GameUtil.IsInMazeSelect()
    if not inMaze then
        return false
    end

    log("在迷宫")
    local points = cfg[3]
    MulClickStep:Execute(points, 2)
    return true
end

local StoneTable = {554,251,668,346,"FFE652","12|2|FFE652|18|1|FFE551|18|7|FFE551|12|-30|FFFFFF|5|-23|FFFFFF|8|-36|FFFFFF",0,0.9}
function OneMazeTask:CheckMazeStone()
    local suc,x,y = Util.FindMulColorByTable(StoneTable)
    return suc
end

return OneMazeTask
