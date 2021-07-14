local ffi = require("ffi")
require("win32.sdkddkver")
require("win32.errhandlingapi")
require("win32.wingdi")
require("win32.winuser")
require("win32.winerror")
local C = ffi.C
local user32 = ffi.load"user32"
ffi.cdef("size_t strlen(const char *);")

function SendValve001Command(msg)
	local Valve001 = user32.FindWindowA("Valve001", nil)
	local Valve001Num = tonumber(ffi.cast("intptr_t", Valve001))
	if Valve001Num == 0 then return nil, 'Valve001 not found' end

	local copyData = ffi.new("COPYDATASTRUCT[1]", {
		{
			dwData = 0x0,
			cbData = C.strlen(msg) + 1,
			lpData = ffi.cast("void*", msg)
		}
	})

	local ok = user32.SendMessageA(Valve001, C.WM_COPYDATA, ffi.cast("WPARAM", Valve001), ffi.cast("LPARAM", ffi.cast("LPVOID", copyData)))
	if ok == 1 then return true end

	return nil, ok == 0 and "sendmessage failed" or ok
end

print("SendValve001Command", SendValve001Command("say asd"))
