require("Project.重云.Util")
require("Project.重云.Task.TaskMgr")
require("Project.重云.Time.TimeMgr")

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
while true do
    self.Update()
end
