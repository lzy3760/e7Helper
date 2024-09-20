_G.class = require("middleclass")
require("EnumConst")
require("Util")
require("Time.TimeMgr")
require("Task.TaskMgr")
require("UI.UIMgr")

setScreenScale(1,1280,720,0)

local Project = {}
local self = Project
self.mgrs = 
{
    _G.TaskMgr, 
    --_G.TimeMgr,
    --_G.UIMgr
}

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

--测试每次轮询的时间间隔，但因为受到sleep的影响，不是
local internal = 0.2
local time = Util.GetPlayTime() + internal

while true do
    -- if Util.GetPlayTime() >= time then
    --     self.Update()
    --     time = time + internal
    -- end
    self.Update()
    Util.WaitTime(internal)
end
