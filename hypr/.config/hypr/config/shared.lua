TERMINAL = "ghostty +new-window"
MENU = "nc -U /run/user/1000/walker/walker.sock"
POWER = "walker -m menus:power"

---@param keys string
---@param dispatcher HL.Dispatcher|function
---@param opts? HL.BindOptions
---@return HL.Keybind
function MAIN_BIND(keys, dispatcher, opts)
	return hl.bind("SUPER + " .. keys, dispatcher, opts)
end

DSP = hl.dispatch
