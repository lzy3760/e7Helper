local GameUtil = {}

local HomeColor = "55|632|FFFFFF,145|640|EBEBEB,232|650|C3C3C3,334|635|FFFFFF,421|634|FFFFFF"
-- �Ƿ���������
function GameUtil.IsInHome()
    return Util.CompareColor(HomeColor)
end

local QuickBattle = "1221|639|E6DFED,1259|681|E6DFED"

-- �Ƿ�رտ�����ս
function GameUtil.IsQuickBattle()
    return Util.CompareColor(QuickBattle)
    -- todo �޸�ΪfindColor
end

-- ���ÿ�����ս
function GameUtil.SetQuickBattle()
    Util.Click(1233, 664)
end

local ContinueBattle = {564, 538, 602, 574, "60BE01", 0, 0.9}
-- ������ս
function GameUtil.IsContinueBattle()
    -- return Util.CompareColor(ContinueBattle)
    local suc, x, y = Util.FindColor(ContinueBattle)
    return suc
end

-- ����������ս
function GameUtil.SetContinueBattle()
    Util.Click(582, 559)
end

-- ����ɶԺ��ϰ�ɫ,��ɫ�����ǰ�͸ͼ,������Ϸ������Ӱ��
local Battle = {"1002|698|D6F7FF,1007|693|D6F7FF", "1080|698|D6F7FF,1084|694|D6F7FF", "1158|698|D6F7FF,1163|693|D6F7FF",
                "1237|697|D6F7FF,1241|694|D6F7FF"}

-- �Ƿ����Զ�ս��
function GameUtil.IsAutoBattle()
    for _, color in pairs(Battle) do
        local suc = Util.CompareColor(color, 0.9)
        if suc then
            log("�����Զ�ս��")
            return true
        else
            log("�������Զ�ս��")
        end
    end
    return false
end

-- �����Զ�ս��
function GameUtil.SetAutoBattle()
    Util.Click(1125, 34)
end

-- �����Ƿ���Ч
function GameUtil.GetInternetValid()
    -- todo
    return true
end

-- �Ƿ���������
function GameUtil.IsEnergyEnough()
    local color = "569|335|E5DCCB,413|533|71582D,618|533|3A712B,871|535|2E5E86"
    return not Util.CompareColor(color)
end

-- �Ƿ���Դ����
function GameUtil.IsResEnough(resType)
    if resType == ResType.Energy then
        return GameUtil.IsEnergyEnough()
    else
        print("��ȡδ֪������Դ")
    end
end

-- �Ƿ����Թ�ѡ��
function GameUtil.IsInMazeSelect()
    for i = 1, 4 do
        local suc = GameUtil.HasMazeDir(i)
        if suc then
            return true
        end
    end

    return false
end

-- �����Թ�����
function GameUtil.HasMazeDir(mazeDir)
    local size
    local picName
    if mazeDir == MazeDir.N then
        size = {13, 133, 252, 334}
        picName = "N.png"
    elseif mazeDir == MazeDir.W then
        size = {39, 430, 219, 589}
        picName = "W.png"
    elseif mazeDir == MazeDir.E then
        size = {1071, 152, 1243, 336}
        picName = "E.png"
    elseif mazeDir == MazeDir.S then
        size = {1068, 425, 1251, 599}
        picName = "S.png"
    end

    local ret, x, y = findPicEx(size[1], size[2], size[3], size[4], picName, 0.8)
    local suc = x ~= -1 and y ~= -1
    return suc, x, y
end

function GameUtil.ClickMazeDir(mazedir)
    local suc, x, y = GameUtil.HasMazeDir(mazedir)
    if suc then
        Util.Click(x, y)
    else
        log("û�л�ȡ����Ӧ���Թ�����ű�")
    end
end

local DecorTable = {"602|629|FFFFFF,614|629|FFFFFF,628|629|FFFFFF,595|669|C6C6C6,619|669|C6C6C6", 0.9}
-- {576,477,610,512,"201B1A","16|26|DE7152",0,0.9}
-- 1-->��ͨ״̬
-- 2-->װ��״̬
function GameUtil.GetHomeState()
    local result = Util.CompareColorByTable(DecorTable)
    if result then
        return RoomState.DecorateState
    else
        return RoomState.NormalState
    end
end

_G.GameUtil = GameUtil
