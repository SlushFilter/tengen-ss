local Addr_BlockMapPtr_Lo = 0xF470
local Addr_BlockMapPtr_Hi = 0xF477
local Addr_ScreenIndex = 0x14

local xOfs = -8
local yOfs = 24
local width = 8
local height = 8

function update()
  local si = emu.read(Addr_ScreenIndex, emu.memType.cpu, false)
  if si > 7 then return end
  local bmPtr = getPointer(Addr_BlockMapPtr_Lo, Addr_BlockMapPtr_Hi, si)
  for y=1, 24, 1 do
    for x=1, 32, 1 do
      local b = getColor(emu.read(bmPtr, emu.memType.cpu, false))
      emu.drawRectangle((x * width) + xOfs, (y * height) + yOfs, width, height, b, true)
      bmPtr = bmPtr + 1
    end
   end
end

function getColor(fromByte)
   local color = 0xFF00FFFF
   color = color - (fromByte << 24)
   return color
end

function getPointer(loAddr, hiAddr, ofs)
  loAddr = loAddr + ofs
  hiAddr = hiAddr + ofs
  local lo = emu.read(loAddr, emu.memType.cpu, false)
  local hi = emu.read(hiAddr, emu.memType.cpu, false)
  return (hi << 8) + lo
end
emu.addEventCallback(update, emu.eventType.endFrame)