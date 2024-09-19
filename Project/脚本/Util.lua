local Util = {}

-- 获取当前时间
function Util.GetNowTime()
    return tickCount() / 1000
end

--获取是否断网
function Util.GetInternetValid()
    --todo 
    return false
end

---@class Util
_G.Util = Util
