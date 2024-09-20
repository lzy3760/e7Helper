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

--ÿ����ѯ��ʱ��������Ϊsleep�Ĵ��ڣ�ֻ��˵����ѯ��
local internal = 0.2

while true do
    self.Update()
    Util.WaitTime(internal)
end
