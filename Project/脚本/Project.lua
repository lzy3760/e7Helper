                     _G.class = require("middleclass")
require("EnumConst")
require("Util")
require("GameUtil")
require("Time.TimeMgr")
require("Task.TaskMgr")
require("Setting.SettingMgr")
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
    -- Util.findPicAndClick(327, 159, 389, 219, "游戏中心", FindDir.LeftUpToRightDown)
    -- Util.WaitTime(3.5)
    -- print("等待完成,开始滑动")
    -- Util.Swipe(586, 423, 570, 273, 0.5)
    -- Util.Swipe({570, 273}, {586, 423}, 0.5)
    -- 1086,682,1172,707

    -- {"55|670|C9C9C9,145|637|F9F9F9,228|636|F8F8F8,333|631|FFFFFF,408|646|DEDEDE",0.9}
    -- local suc = Util.cmpColorEx("55|670|C9C9C9,145|637|F9F9F9,228|636|F8F8F8,333|631|FFFFFF,408|646|DEDEDE")
    -- if suc then
    --     log("这是主界面") 
    -- end

    -- local handle = createOcr()
    -- local text = ocrTextEx(handle, 1086, 682, 1172, 707, 8, 150, 255)
    -- if text ~= nil then
    --     print("ocr text:" .. text)
    -- end
    -- releaseOcr(handle)

    -- local result = Util.IsEnergyEnough()
    -- if not result then
    --     log("体力不足")
    -- end

    -- local from = {848, 690}
    -- local to = {836, 68}
    -- Util.Swipe(from, to, 0.5)

    -- local ContinueBattle = "5BBB02"

    -- log("连续挑战比色")
    -- -- local suc, x, y = Util.FindColor(574, 540, 605, 565, ContinueBattle, FindDir.LeftUpToRightDown, 0.2)
    -- local suc, x, y = Util.FindColor(591, 634, 712, 686, "38520B", FindDir.LeftUpToRightDown, 0.9)
    -- if suc then
    --     log("查找成功")
    -- else
    --     log("查找失败")
    -- end

    -- local MulClick = require("Step.MulClickStep")
    -- local points = {{650, 393}, {744, 478}}
    -- MulClick:Execute(points, 1)
end

self.Init()
self.Enter()

-- 每次轮询的时间间隔，因为sleep的存在，只能说是轮询了
local internal = 0.2

while true do
    self.Update()
    Util.WaitTime(internal)

    self.isTest = true
    if not self.isTest then
        self.Test()
        self.isTest = true
    end
end
