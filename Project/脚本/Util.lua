_G.FindDir = {
    -- ���ϵ����²���
    LeftUpToRightDown = 0,
    -- ���������ܲ���
    Center = 1,
    -- ���µ����ϲ���
    RightDownToLeftUp = 2,
    -- ���µ����ϲ���
    LeftDownToRightUp = 3,
    -- ���ϵ����²���
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

-- ��ȡGame����ʱ��
function Util.GetPlayTime()
    return tickCount() / 1000
end

-- �����Ƿ���Ч
function Util.GetInternetValid()
    -- todo
    return true
end

-- �Ƿ���������
function Util.IsEnergyEnough()
    local color = "569|335|E5DCCB,413|533|71582D,618|533|3A712B,871|535|2E5E86"
    return not Util.CompareColor(color)
end

function Util.WaitTime(seconds)
    sleep(seconds * 1000)
end

-- �϶�
-- function Util.Swipe(from, to)
--     -- waitTime = waitTime * 1000 or 0
--     touchDown(1, from[1], from[2])
--     Util.WaitTime(0.05)
--     touchMoveEx(1, to[1], to[2], 500)
--     -- touchMoveEx(1, to[1], to[2], 50)
--     touchUp(1)
--     Util.WaitTime(0.8)
-- end

function Util.Swipe(from, to, time)
    local result = swipe(from[1], from[2], to[1], to[2], time * 1000)
    local msg = result and "�ɹ�" or "ʧ��"
    print("�������->>>" .. msg)
end

-- function Util.Swipe(x1, y1, x2, y2, time)
--     local gesture = Gesture:new()
--     local path = Path:new()
--     path:setStartTime(100)
--     path:setDurTime(3000)
--     path:addPoint(x1, y1)
--     path:addPoint(x2, y2)
--     gesture:addPath(path)
-- end

-- ����ɫ
function Util.CompareColor(msg, sim)
    sim = sim or 0.9
    local result = cmpColorEx(msg, sim)
    -- log("��ɫ���" .. tostring(result))
    return result > 0
end

function Util.FindColor(x1, y1, x2, y2, color, dir, sim)
    sim = sim or 0.9
    local ret, x, y = findColor(x1, y1, x2, y2, color, dir, sim)
    if x ~= -1 and y ~= -1 then
        return true, x, y
    else
        return false
    end
end

-- ���
function Util.Click(x, y)
    -- ��⵽���Ե��ʱ�п��ܻ��ڲ��Ŷ���,�ӳ�һ��
    Util.WaitTime(0.8)
    tap(x, y)
end

-- ��ͼ
function Util.findPic(x1, y1, x2, y2, picName, dir)
    if not x1 or not y1 or not x2 or not y2 then
        logError("ȱ��FindPic������")
        return
    end

    if not picName or picName == "" then
        logError("ȱ��FindPic��PicName����")
        return
    end

    picName = picName .. ".png"
    local ret, x, y = findPic(x1, y1, x2, y2, picName, "000000", 0.7, dir)
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
        logError("�Ҳ����Աȵ�ͼƬ" .. picName)
    end
end

-- ���÷������һ������
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
