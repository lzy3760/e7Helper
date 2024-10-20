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

function Util.WaitTime(seconds)
    sleep(seconds * 1000)
end

function Util.Swipe(from, to, time)
    time = time or 0.5
    local result = swipe(from[1], from[2], to[1], to[2], time * 1000)
    local msg = result and "成功" or "失败"
    print("滑动结果->>>" .. msg)
end

-- 多点比色,后面不要再用这个方法了,用Ext后缀的比较方便
function Util.CompareColor(msg, sim)
    sim = sim or 0.9
    local result = cmpColorEx(msg, sim)
    -- log("比色结果" .. tostring(result))
    return result > 0
end

-- 通过table多点比色
function Util.CompareColorByTable(table)
    local result = cmpColorExT(table)
    return result > 0
end

function Util.FindColor(table)
    local ret, x, y = findColorT(table)
    if x ~= -1 and y ~= -1 then
        return true, x, y
    else
        return false
    end
end

-- 点击
function Util.Click(x, y)
    tap(x, y)
end

-- 找图
function Util.findPic(x1, y1, x2, y2, picName, sim)
    if not x1 or not y1 or not x2 or not y2 then
        logError("缺少FindPic的坐标")
        return
    end

    if not picName or picName == "" then
        logError("缺少FindPic的PicName名称")
        return
    end

    sim = sim or 0.98
    local ret, x, y = findPicEx(x1, y1, x2, y2, picName, sim)
    if x ~= -1 and y ~= -1 then
        return true, x, y
    else
        return false
    end
end

function Util.findPicAndClick(x1, y1, x2, y2, picName)
    local suc, x, y = Util.findPic(x1, y1, x2, y2, picName)
    if suc then
        tap(x, y)
    else
        logError("找不到对比的图片" .. picName)
    end
end

-- 多颜色比对并点击对应区域
function Util.FindMulColorAndClick(table)
    local x, y = findMultiColorT(table)
    if x ~= -1 and y ~= -1 then
        Util.Click(x, y)
        return true
    else
        return false
    end
end

function Util.FindMulColorByTable(table)
    local x, y = findMultiColorT(table)
    if x ~= -1 and y ~= -1 then
        return true, x, y
    else
        return false
    end
end

-- 利用反射调用一个方法
function Util.Invoke(table, funcName, ...)
    local env = {
        self = table,
        arg = {...}
    }

    setmetatable(env, {
        __index = _G
    })

    local str
    if #env.arg == 0 then
        str = "return self:" .. funcName .. "()"
    else
        str = "return self:" .. funcName .. "(table.unpack(arg))"
    end

    local chunk, err = load(str, funcName, "bt", env)

    if not chunk then
        error("Failed to load function: " .. err)
    end

    return chunk()
end

function Util.IsDisplayDead(time)
    return isDisplayDead(0, 0, 1280, 720, time)
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

ui.addRow = function(layout)
    ui.newRow(layout, "Row")
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
