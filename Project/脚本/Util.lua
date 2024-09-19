local Util = {}

-- 获取运行时间
function Util.GetPlayTime()
    return tickCount() / 1000
end

--获取是否断网
function Util.GetInternetValid()
    --todo 
    return false
end

---@class Util
_G.Util = Util
