local remove = table.remove
local insert = table.insert
-- local BaseTask = require("Task.BaseTask")
local HomeTask = require("Task.HomeTask")

local TaskType = {
    -- ������task
    -- �������
    ["�������"] = require("Task.InternetErrorTask"),

    -- ["��ǲ����"] = require("")

    -- ͨ��Task
    -- ����Home����
    ["������"] = require("Task.HomeTask"),

    -- ����Task
    ["ˢ��ǩ"] = require("Task.RandomStoreTask"),
    ["�ַ�"] = require("Task.HuntTask")
}

local TaskMgr = {}

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

    if not Util.GetInternetValid() then
        if self.curTask and self.curTask.taskType ~= "�������" then
            self:AddTaskAndRun("�������")
        end
    end
end

function TaskMgr:Release()
end

-- �������
function TaskMgr:AddTask(taskType)
    local taskClass = TaskType[taskType]
    if not taskClass then
        log("not find the task->>>>>>" .. taskType)
        return
    end

    local task = taskClass:new()
    insert(self.tasks, task)

    local homeTask = HomeTask:new()
    insert(self.tasks, homeTask)
end

-- �������������ִ��,һ����ڲ����Ĳ�����task
function TaskMgr:AddTaskAndRun(taskType)
    local taskClass = TaskType[taskType]
    local task = taskClass:new()
    if self.curTask then
        self.curTask:Pause()
    end

    insert(self.tasks, 1, task)
    self.curTask = task
    self.curTask:Enter()
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
