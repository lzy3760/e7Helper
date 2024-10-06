local remove = table.remove
local insert = table.insert
-- local BaseTask = require("Task.BaseTask")
local HomeTask = require("Task.HomeTask")

-- todo 看能否将资源不足的界面写到Step里,在点击之后进行Step判断一下

local TaskType = {
    -- 插入型task
    -- 网络错误
    ["网络错误"] = require("Task.InternetErrorTask"),
    -- ["资源不足"] = require("")
    -- ["派遣界面"] = require("")

    -- 通用Task
    -- 返回Home界面
    ["主界面"] = require("Task.HomeTask"),

    -- 功能Task
    ["刷书签"] = require("Task.RandomStoreTask"),
    ["讨伐"] = require("Task.HuntTask"),
    ["迷宫强化石"] = require("Task.MazeIntensifyTask"),
    ["主线强化石"] = require("Task.MainLineIntensifyTask"),
    ["竞技场"] = require("Task.JJCTask")
}

local InternetState = {
    -- 跑拉斯
    WaitLaSi = 1,
    -- 等待点击重连
    WaitReConnect = 2,
    -- 没有问题
    Right = 3
}

local TaskMgr = {}

-- 跑拉斯
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
    -- self:Start("讨伐")
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
        print("网络错误，点击屏幕")
        Util.Click(627, 348)
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

-- 添加任务
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

-- 添加任务并且立即执行,一般放在不定的插入型task
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
