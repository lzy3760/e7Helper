local BaseTask = require("Task.BaseTask")
--�ַ�
local HuntTask = class("BaseTask")

--[[
    1.�������ս������
    2.���Hunt���
    3.�ж��ַ�����Ƿ����,�������»�(while ѭ��)
    4.�Ѷ��ж�,ĿǰĬ��ѡ���ַ�13,������밴ť
    5.�ж�ս����ڣ����ս����ť
    6.�ж��Ƿ���ս������,û���Զ�ս������Զ�ս��
    7.�ж��Ƿ���ʤ������,ʶ����ɫ���ǵĻ������Ļ
    8.���ս�����ȷ�ϰ�ť��ť
    9.���TryAgain��ť
    10.��ת��5
]]

function HuntTask:initialize()
    BaseTask.initialize(self,"�ַ�")

end

return HuntTask