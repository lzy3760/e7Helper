-- 初始化
require("HWSDK")

---@class Update
local Update = {}

function Update:Init(sucCb, failCb)
    HWSDK.debug = true;
    HWSDK.init("AppKey", "AppSecret")
    -- 本地版本
    self.version = "v1.0.0"
    self.sucCb = sucCb
    self.failCb = failCb
end

-- 热更新回调函数
local function updateCallback(callback)
    if callback < 0 then
        print("更新进度：0%")
        toast("更新进度：0%", 0, 0, 12)
    else
        print("更新进度：" .. callback .. "%")
        toast("更新进度：" .. callback .. "%", 0, 0, 12)
    end
end

function Update:Start()
    -- 比对版本号 留空则默认返回发布版本
    local ret = HWSDK.getSoftwareLatestVersion(self.version)
    -- code 是0 就是有新版本
    if ret.code == 0 then
        -- 更新完毕是否重启脚本
        local isRestartScript = true
        -- 执行热更新下载
        local upRet = HWSDK.updateScript(ret, isRestartScript, updateCallback)
        -- 判断是否下载成功
        if upRet.code == 0 then
            print("更新成功")
            toast("更新成功", 0, 0, 12)
            self.sucCb()
        else
            print("更新失败:", upRet.message)
            toast("更新失败:" .. upRet.message, 0, 0, 12)
            self.failCb()
        end
    end
end

return Update