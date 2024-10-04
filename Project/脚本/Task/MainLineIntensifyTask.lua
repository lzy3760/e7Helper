local BaseTask = require("Task.BaseTask")

---@type MulClickStep
local MulClickStep = require("Step.MulClickStep")
---@type BattleReadyStep
local BattleReadyStep = require("Step.BattleReadyStep")
---@type BattleAutoStep
local BattleAutoStep = require("Step.BattleAutoStep")
---@type StoreBuyStep
local StoreBuyStep = require("Step.StoreBuyStep")
---@type CommonExitStep
local CommonExitStep = require("Step.CommonExitStep")

---@class MainLineIntensifyTask:BaseTask ����ǿ��ʯ
local Task = class("MainLineIntensifyTask", BaseTask)

local Points = {
    [2] = {
        inPanel = "1231|141|10E3F0,1226|622|F33636"
    },
    [3] = {
        swipeFrom = {131, 127},
        swipeTo = {330, 363},
        clickPos = {733, 578}
    },
    [4] = {
        inPanel = "1009|665|143117,1147|664|163318",
        clickPos = {1080, 666}
    }
}

function Task:initialize()
    BaseTask.initialize(self, "����ǿ��ʯ")
end

function Task:Enter()
    BattleReadyStep:SetTarget(nil, nil)
    StoreBuyStep:SetTarget(BuyType.All)
end

function Task:Update()
    Util.Invoke(self, "Step" .. self.curStep)
end

function Task:Step1()
    if GameUtil.IsInHome() then
        Util.Click(1212, 637)
        self:AddStep()
    end
end

-- ѡ���ͼ
function Task:Step2()
    local config = Points[2]
    if not Util.CompareColor(config.inPanel, 0.9) then
        return
    end

    Util.WaitTime(0.5)
    local points = {{1227, 620}, {278, 332}, {1236, 324}}
    MulClickStep:Execute(points, 1)
    Util.WaitTime(1)
    self:AddStep()
end

-- ����ѡ��ǿ��ʯ�ؿ�
function Task:Step3()
    local config = Points[3]
    for i = 1, 3 do
        Util.Swipe(config.swipeFrom, config.swipeTo, 0.8)
        Util.WaitTime(1)
    end

    Util.Click(config.clickPos[1], config.clickPos[2])
    self:AddStep()
end

-- ����ѡ��������
function Task:Step4()
    local config = Points[4]
    if not Util.CompareColor(config.inPanel) then
        return
    end

    Util.Click(config.clickPos[1], config.clickPos[2])
    self:AddStep()
end

-- ս��׼��
function Task:Step5()
    local result = BattleReadyStep:Execute()
    if result then
        self:AddStep()
    end
end

function Task:Step6()
    Util.WaitTime(1)
    if BattleAutoStep:Execute() then
        self:AddStep()
    end
end

function Task:Step7()
    if not GameUtil.IsInMazeSelect() then
        return
    end

    -- �����Ͻ���
    Util.Click(131, 251)
    -- �ȴ��ߵ�ʱ��
    Util.WaitTime(2.14)
    -- ͣ���Զ�
    Util.Click(1125, 33)

    -- ���̵�
    for i = 1, 3 do
        Util.Click(817, 327)
        Util.WaitTime(0.3)
    end

    self:AddStep()
end

function Task:Step8()
    Util.WaitTime(1)
    local result = StoreBuyStep:Execute()
    if result then
        self:AddStep()
    end
end

function Task:Step9()
    Util.Click(72, 31)
    Util.WaitTime(1)
    CommonExitStep:Execute()
    self:Completed()
end

return Task
