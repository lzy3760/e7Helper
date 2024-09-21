_G.FindDir = {
    -- 左上到右下查找
    LeftUpToRightDown = 0,
    -- 中心向四周查找
    Center = 1,
    -- 右下到左上查找
    RightDownToLeftUp = 2,
    -- 左下到右上查找
    LeftDownToRightUp = 3,
    -- 右上到左下查找
    RightUpToLeftDown = 4
}

local LogType = {
    VERBOSE = 1,
    DEBUG = 2,
    INFO = 3,
    WARN = 4,
    ERROR = 5,
    ASSERT = 6
}

local Util = {}

-- 获取Game运行时间
function Util.GetPlayTime()
    return tickCount() / 1000
end

-- 网络是否有效
function Util.GetInternetValid()
    -- todo
    return true
end

function Util.WaitTime(seconds)
    sleep(seconds * 1000)
end

-- 拖动
function Util.Swipe(from, to)
    -- waitTime = waitTime * 1000 or 0
    touchDown(1, from[1], from[2])
    Util.WaitTime(0.05)
    touchMoveEx(1, to[1], to[2], 500)
    -- touchMoveEx(1, to[1], to[2], 50)
    touchUp(1)
    Util.WaitTime(0.8)
end

-- function Util.Swipe(x1, y1, x2, y2, time)
--     local result = swipe(x1, y1, x2, y2, time * 1000)
--     local msg = result and "成功" or "失败"
--     print("滑动结果->>>" .. msg)
-- end

-- function Util.Swipe(x1, y1, x2, y2, time)
--     local gesture = Gesture:new()
--     local path = Path:new()
--     path:setStartTime(100)
--     path:setDurTime(3000)
--     path:addPoint(x1, y1)
--     path:addPoint(x2, y2)
--     gesture:addPath(path)
-- end

-- 多点比色
function Util.CompareColor(msg, sim)
    sim = sim or 0.9
    local result = cmpColorEx(msg, sim)
    return result > 0
end

-- 点击
function Util.Click(x, y)
    tap(x, y)
end

-- 找图
function Util.findPic(x1, y1, x2, y2, picName, dir)
    if not x1 or not y1 or not x2 or not y2 then
        logError("缺少FindPic的坐标")
        return
    end

    if not picName or picName == "" then
        logError("缺少FindPic的PicName名称")
        return
    end

    picName = picName .. ".png"
    ret, x, y = findPic(x1, y1, x2, y2, picName, "000000", 0.7, dir)
    if x ~= -1 and y ~= -1 then
        return true, x, y
    else
        return false
    end
end

function Util.findPicAndClick(x1, y1, x2, y2, picName, dir)
    local suc, x, y = Util.findPic(x1, y1, x2, y2, picName, dir)
    if suc then
        tap(x, y)
    else
        logError("找不到对比的图片" .. picName)
    end
end

---@class Util
_G.Util = Util

string.split = function(str, param)
    return splitStr(str, param)
end

ui.addSpace = function(layout, spaceCount)
    spaceCount = spaceCount or 1
    for i = 1, spaceCount do
        ui.addTextView(layout, "Space", " ")
    end
end

local enableLog = true

function log(msg)
    if not enableLog then
        return
    end

    -- console.println(msg, LogType.INFO)
    -- print("<color=#7FB7FF>"..tostring(msg).."</color>")
    print(msg)
end

function logError(msg)
    if not enableLog then
        return
    end

    -- --console.println(msg, LogType.ERROR)
    -- print("<color=#FF0008>" .. tostring(msg) .. "</color>")
    log(msg)
    exitScript()
end
