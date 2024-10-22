local BaseTask = require("Task.BaseTask")
---@class OneMazeTask:BaseTask һƱ�Թ�
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
        --��ͨ��ת "W"
        --��������ת "W",Type.Portal
        --������� "W",Type.JumpArea,{x,y}
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
    -- ��������
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

-- ��ͨ���
function OneMazeTask:NormalClick(cfg)
    local dir = cfg[1]
    GameUtil.ClickMazeDir(dir)
end

-- ���������
function OneMazeTask:ClickProtal(cfg)
    local points = {{}, {}}
    MulClickStep:Execute(points, 0.5)
end

-- �����ͼ����
function OneMazeTask:JumpArea(cfg)
    local points = {{}, {}}
    local jumpPos = cfg[3]
    table.insert(points, 2, jumpPos)
    MulClickStep:Execute(points, 0.5)
end

return OneMazeTask
