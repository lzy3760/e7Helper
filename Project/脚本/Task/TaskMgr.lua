local remove = table.remove
local insert = table.insert
-- local BaseTask = require("Task.BaseTask")
local HomeTask = require("Task.HomeTask")

local TaskType = {
    -- 插入型task
    -- 网络错误
    ["网络错误"] = require("Task.InternetErrorTask"),

    -- ["派遣界面"] = require("")

    -- 通用Task
    -- 返回Home界面
    ["主界面"] = require("Task.HomeTask"),

    -- 功能Task
    ["刷书签"] = require("Task.RandomStoreTask"),
    ["讨伐"] = require("Task.HuntTask")
}

local TaskMgr = {}

function TaskMgr:Init()
    self.tasks = {}
    self.curTask = nil
    self.pause = true
end

function TaskMgr:Enter()
    -- self:Start("讨伐")
end

function TaskMgr:Update()
    if self.pause then
        return
    end

    if not self.curTask then
        return
    end

    self.curTask:Update()

    -- 当前任务已经结束,进行下一个任务
    if self.curTask.isFinish then
        self.curTask:Release()
        remove(self.tasks, 1)

        if #self.tasks == 0 then
            logError("程序退出")
        else
            self.curTask = self.tasks[1]
            if self.curTask then
                -- 如果任务是中途暂停的,就继续，否则重新开始
                if self.curTask:IsPause() then
                    log("继续Task" .. self.curTask.taskType)
                    self.curTask:Resume()
                else
                    log("开始Task" .. self.curTask.taskType)
                    self.curTask:Enter()
                end
            end
        end
    end

    if not Util.GetInternetValid() then
        if self.curTask and self.curTask.taskType ~= "网络错误" then
            self:AddTaskAndRun("网络错误")
        end
    end
end

function TaskMgr:Release()
end

-- 添加任务
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

-- 添加任务并且立即执行,一般放在不定的插入型task
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
