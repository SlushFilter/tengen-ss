local CAR_X = 0x57
local CAR_Y = 0x4C
local CAR_COLORS = {}
CAR_COLORS[0] = 0x40FFFF00
CAR_COLORS[1] = 0x400000FF
CAR_COLORS[2] = 0x40FF0000
CAR_COLORS[3] = 0x40FFFFFF

local tracerFrames = 60

local lastCarX = {}
lastCarX[0] = 0
lastCarX[1] = 0
lastCarX[2] = 0
lastCarX[3] = 0

local lastCarY = {}
lastCarY[0] = 0
lastCarY[1] = 0
lastCarY[2] = 0
lastCarY[3] = 0


function drawCarInfo()
   
   for i = 0, 3 do
      local x = lastCarX[i]
      local y = lastCarY[i]
      local x2 = emu.read(CAR_X + i, 0, false) + 8
      local y2 = emu.read(CAR_Y + i, 0, false) + 8
      emu.drawLine(x, y, x2, y2, CAR_COLORS[i], tracerFrames, 0)
      lastCarX[i] = x2
      lastCarY[i] = y2
   end
end

emu.addEventCallback(drawCarInfo, emu.eventType.endFrame)

