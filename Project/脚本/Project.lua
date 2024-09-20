_G.class = require("middleclass")
require("EnumConst")
require("Util")
require("Time.TimeMgr")
require("Task.TaskMgr")
require("UI.UIMgr")

setScreenScale(1, 1280, 720, 0)

local Project = {}
local self = Project
self.mgrs = {_G.TaskMgr, -- _G.TimeMgr,
_G.UIMgr}

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

self.Test = function()
    -- 327,159,389,219
    Util.findPicAndClick(327, 159, 389, 219, "游戏中心", FindDir.LeftUpToRightDown)
    Util.WaitTime(3.5)
    print("等待完成,开始滑动")
    Util.Swipe(586, 423, 570, 273, 0.5)
    --Util.Swipe({570, 273}, {586, 423}, 0.5)
end

self.Init()
self.Enter()

-- 每次轮询的时间间隔，因为sleep的存在，只能说是轮询了
local internal = 0.2

while true do
    self.Update()
    Util.WaitTime(internal)

    -- self.isTest = true
    if not self.isTest then
        self.Test()
        self.isTest = true
    end
end
