-- ��ʼ��
require("HWSDK")

---@class Update
local Update = {}

function Update:Init(sucCb, failCb)
    HWSDK.debug = true;
    HWSDK.init("AppKey", "AppSecret")
    -- ���ذ汾
    self.version = "v1.0.0"
    self.sucCb = sucCb
    self.failCb = failCb
end

-- �ȸ��»ص�����
local function updateCallback(callback)
    if callback < 0 then
        print("���½��ȣ�0%")
        toast("���½��ȣ�0%", 0, 0, 12)
    else
        print("���½��ȣ�" .. callback .. "%")
        toast("���½��ȣ�" .. callback .. "%", 0, 0, 12)
    end
end

function Update:Start()
    -- �ȶ԰汾�� ������Ĭ�Ϸ��ط����汾
    local ret = HWSDK.getSoftwareLatestVersion(self.version)
    -- code ��0 �������°汾
    if ret.code == 0 then
        -- ��������Ƿ������ű�
        local isRestartScript = true
        -- ִ���ȸ�������
        local upRet = HWSDK.updateScript(ret, isRestartScript, updateCallback)
        -- �ж��Ƿ����سɹ�
        if upRet.code == 0 then
            print("���³ɹ�")
            toast("���³ɹ�", 0, 0, 12)
            self.sucCb()
        else
            print("����ʧ��:", upRet.message)
            toast("����ʧ��:" .. upRet.message, 0, 0, 12)
            self.failCb()
        end
    end
end

return Update