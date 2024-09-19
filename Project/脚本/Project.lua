_G.class = require("middleclass")
require("Util")
require("Time.TimeMgr")
require("Task.TaskMgr")

local Project = {}
local self = Project
self.mgrs = {_G.TaskMgr, _G.TimeMgr}

self.Init = function()
    for _, mgr in pairs(self.mgrs) do
        if mgr.Init then
            mgr:Init()
        end
    end
end

self.Enter = function()
    for _, mgr in pairs(self.mgrs) do
        if mgr.Enter then
            mgr:Enter()
        end
    end
end

self.Release = function()
    for _, mgr in pairs(self.mgrs) do
        if mgr.Release then
            mgr:Release()
        end
    end
end

self.Update = function()
    for _, mgr in pairs(self.mgrs) do
        if mgr.Update then
            mgr:Update()
        end
    end
end

self.Init()
self.Enter()

--简单计时器
local internal = 0.2
local time = Util.GetPlayTime() + internal

--为了节省性能,0.1s走一次
while true do
    if Util.GetPlayTime() >= time then
        self.Update()
        time = time + internal
    end
end
