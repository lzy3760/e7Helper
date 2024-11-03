import('java.io.File')
import('java.lang.*')
import('java.util.Arrays')
import('android.content.Context')
import('android.hardware.Sensor')
import('android.hardware.SensorEvent')
import('android.hardware.SensorEventListener')
import('android.hardware.SensorManager')
import('com.nx.assist.lua.LuaEngine')
import('com.nx.assist.lua.PaddleOcr')

local OCRUtil = {}

function OCRUtil.findText()
    local r = PaddleOcr.loadModel(true)
    if r then
        local bitmap = LuaEngine.snapShot(988,154,1230,243)
        local str = PaddleOcr.detect(bitmap)
        print(str)
        LuaEngine.releaseBmp(bitmap)
    end
end

_G.OCRUtil = OCRUtil