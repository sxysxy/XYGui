=begin
	Calender...
=end

require 'XYGui/winapi_base.rb'
require 'XYGui/xy_widget.rb'

class XYCalender < XYWidget
	
	def initialize(app, parent, arg = {})
		super(app, parent, arg)
		create
	end
	
	def create
		@handle = WinAPI.call("user32", "CreateWindowEx", 0, "SysMonthCal32", "", 
							WS_CHILD,
							@x, @y, @width, @height, 
							@parent.handle, @id,
							@app.instance, 0)
	end
	
	def defaultHeight
		220
	end
	
	def defaultWidth
		280
	end
end