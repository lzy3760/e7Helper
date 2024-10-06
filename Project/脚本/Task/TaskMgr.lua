local remove = table.remove
local insert = table.insert
-- local BaseTask = require("Task.BaseTask")
local HomeTask = require("Task.HomeTask")

-- todo ���ܷ���Դ����Ľ���д��Step��,�ڵ��֮�����Step�ж�һ��

local TaskType = {
    -- ������task
    -- �������
    ["�������"] = require("Task.InternetErrorTask"),
    -- ["��Դ����"] = require("")
    -- ["��ǲ����"] = require("")

    -- ͨ��Task
    -- ����Home����
    ["������"] = require("Task.HomeTask"),

    -- ����Task
    ["ˢ��ǩ"] = require("Task.RandomStoreTask"),
    ["�ַ�"] = require("Task.HuntTask"),
    ["�Թ�ǿ��ʯ"] = require("Task.MazeIntensifyTask"),
    ["����ǿ��ʯ"] = require("Task.MainLineIntensifyTask"),
    ["������"] = require("Task.JJCTask")
}

local InternetState = {
    -- ����˹
    WaitLaSi = 1,
    -- �ȴ��������
    WaitReConnect = 2,
    -- û������
    Right = 3
}

local TaskMgr = {}

-- ����˹
local WaitLaSi =
    {"560|348|FFFFFF,575|347|FFFFFF,591|348|FFFFFF,608|348|FFFFFF,625|348|FFFFFF,637|348|FFFFFF,657|348|FFFFFF,667|348|FFFFFF,673|347|FFFFFF,690|347|FFFFFF",
     0.9}

local WaitReConnect =
    {"519|303|808080,533|303|7F7F7F,518|318|858585,532|318|7C7C7C,538|317|858585,545|317|858585,552|317|878787,565|304|878787,579|306|888888,604|306|7A7A7A,624|305|888888",
     0.9}

function TaskMgr:Init()
    self.tasks = {}
    self.curTask = nil
    self.pause = true
end

function TaskMgr:Enter()
    -- self:Start("�ַ�")
end

function TaskMgr:Update()
    if self.pause then
        return
    end

    if not self.curTask then
        return
    end

    local internetState = self:GetInternatState()
    if internetState ~= InternetState.Right then
        print("������󣬵����Ļ")
        Util.Click(627, 348)
        return
    end

    self.curTask:Update()

    -- ��ǰ�����Ѿ�����,������һ������
    if self.curTask.isFinish then
        self.curTask:Release()
        remove(self.tasks, 1)

        if #self.tasks == 0 then
            logError("�����˳�")
        else
            self.curTask = self.tasks[1]
            if self.curTask then
                -- �����������;��ͣ��,�ͼ������������¿�ʼ
                if self.curTask:IsPause() then
                    log("����Task" .. self.curTask.taskType)
                    self.curTask:Resume()
                else
                    log("��ʼTask" .. self.curTask.taskType)
                    self.curTask:Enter()
                end
            end
        end
    end
end

function TaskMgr:GetInternatState()
    if Util.CompareColorByTable(WaitLaSi) then
        return InternetState.WaitLaSi
    elseif Util.CompareColorByTable(WaitReConnect) then
        return InternetState.WaitReConnect
    else
        return InternetState.Right
    end
    -- elseif Util.
end

function TaskMgr:Release()
end

-- �������
function TaskMgr:AddTask(taskType)
    local taskClass = TaskType[taskType]
    if not taskClass then
        logError("not find the task->>>>>>" .. taskType)
        return
    end

    local task = taskClass:new()
    insert(self.tasks, task)

    local homeTask = HomeTask:new()
    insert(self.tasks, homeTask)
end

-- �������������ִ��,һ����ڲ����Ĳ�����task
function TaskMgr:PauseTask(isReduce)
    isReduce = isReduce or false
    if self.curTask then
        self.curTask:Pause(isReduce)
    end
end

function TaskMgr:Start(cmds)
    self.pause = false
    self:CreateTask(cmds)
    self.curTask = self.tasks[1]
    self.curTask:Enter()
end

function TaskMgr:CreateTask(cmds)
    local strArr = string.split(cmds, "|")
    for _, cmd in pairs(strArr) do
        self:AddTask(cmd)
    end
end

_G.TaskMgr = TaskMgr
