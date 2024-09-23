local GameUtil = {}

local HomeColor = "55|632|FFFFFF,145|640|EBEBEB,232|650|C3C3C3,334|635|FFFFFF,421|634|FFFFFF"
-- 是否处于主界面
function GameUtil.IsInHome()
    return Util.CompareColor(HomeColor)
end

local QuickBattle = "1214|641|0B0201,1234|662|201D1C,1250|679|090200"

-- 是否关闭快速挑战
function GameUtil.IsQuickBattle()
    return Util.CompareColor(QuickBattle)
    -- todo 修改为findColor
end

-- 设置快速挑战
function GameUtil.SetQuickBattle()
    Util.Click(1233, 664)
end

local ContinueBattle = "5BBB02"
-- 连续挑战
function GameUtil.IsContinueBattle()
    -- return Util.CompareColor(ContinueBattle)
    local suc, x, y = Util.FindColor(574, 540, 605, 565, ContinueBattle, FindDir.LeftUpToRightDown)
    return suc
end

-- 设置连续挑战
function GameUtil.SetContinueBattle()
    Util.Click(582, 559)
end

local Battle = {"1002|698|D6F7FF,1007|693|D6F7FF", "1080|698|D6F7FF,1084|694|D6F7FF", "1158|698|D6F7FF,1163|693|D6F7FF",
                "1237|697|D6F7FF,1241|694|D6F7FF"}

-- 是否在自动战斗
function GameUtil.IsAutoBattle()
    for _, color in pairs(Battle) do
        local suc = Util.CompareColor(color, 0.5)
        if suc then
            log("是在自动战斗")
            return true
        else
            log("不是在自动战斗")
        end
    end
    return false
end

-- 设置自动战斗
function GameUtil.SetAutoBattle()
    Util.Click(1125, 34)
end

_G.GameUtil = GameUtil
