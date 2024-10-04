local BaseTask = require("Task.BaseTask")
-- ˢ��ǩ��Task
---@class RandomStoreTask:BaseTask
local Task = class("RandomStoreTask", BaseTask)

---@type StoreBuyStep
local StoreBuyStep = require("Step.StoreBuyStep")
---@type MulClickStep
local MulClickStep = require("Step.MulClickStep")

local State = {
    -- ��ͨ
    NormalState = 1,
    -- װ��
    DecorateState = 2
}

local Points = {
    [2] = {
        storePanel = {180, 627, 225, 697, "102D17", "-2|27|2E5D25", 0, 0.9}

    },
    [3] = {
        switchPanel = {639, 404, 847, 482, "172B49", "79|-1|162A48", 0, 0.9}
    }
}

function Task:initialize()
    BaseTask.initialize(self, "ˢ��ǩ")
end

-- {576,477,610,512,"201B1A","16|26|DE7152",0,0.9}
-- 1-->��ͨ״̬
-- 2-->װ��״̬
local function GetHomeState()
    local result = Util.FindMulColor(576, 477, 610, 515, "201B1A", "16|26|DE7152")
    if result then
        return State.DecorateState
    else
        return State.NormalState
    end
end

function Task:Enter()
    self.buyCount = 100
    self.curBuyCount = 0
    -- ��ǩ
    self.blueRes = 0
    -- ����
    self.redRes = 0
    self.hudId = createHUD()
    self:RefreshHUD()
    StoreBuyStep:SetTarget(BuyType.Res, function(type)
        if type == 1 then
            self.blueRes = self.blueRes + 1
        elseif type == 2 then
            self.redRes = self.redRes + 1
        end

        self:RefreshHUD()
    end)
end

function Task:Update()
    Util.Invoke(self, "Step" .. self.curStep)
end

function Task:Step1()
    local state = GetHomeState()
    if state == State.NormalState then
        Util.Click(567, 186)
    else
        Util.Click(55, 164)
    end

    Util.WaitTime(1)
    StoreBuyStep:ResetBuyIndex()
    self:ChangeStep(4)
end

function Task:Step2()
    self:RefreshHUD()
    local config = Points[2]
    local storePanel = config.storePanel

    if Util.FindMulColorByTable(storePanel) then
        Util.Click(220, 660)
    else
        self:AddStep()
    end
end

function Task:Step3()
    local config = Points[3]
    local switchPanel = config.switchPanel

    if Util.FindMulColorByTable(switchPanel) then
        Util.Click(743, 442)
    else
        StoreBuyStep:ResetBuyIndex()
        self:AddStep()
    end
end

function Task:Step4()
    local result = StoreBuyStep:Execute()
    if result then
        Util.WaitTime(1)
        self.curBuyCount = self.curBuyCount + 1
        if self.curBuyCount >= self.buyCount then
            self:Completed()
        else
            self:ChangeStep(2)
        end
    end
end

function Task:RefreshHUD()
    local Countcontent = "ˢ�´���:" .. tostring(self.curBuyCount) .. "/" .. tostring(self.buyCount)
    local blueContent = "��ǩ:" .. tostring(self.blueRes)
    local redContent = "����:" .. tostring(self.redRes)
    local str = Countcontent .. "\n" .. blueContent .. "\n" .. redContent

    showHUD(self.hudId, str, 12, "#FF000000", "#FFFFFFFF", 0, 0, 720, 170, 100, 0, 0, 0, 0, 1)
end

return Task
