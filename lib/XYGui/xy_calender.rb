=begin
	Calender...
	
	v1.0.0  by sxysxy           2016.03.30
=end

require 'XYGui/winapi_base.rb'
require 'XYGui/xy_widget.rb'

class XYCalender < XYWidget
	
	def initialize(app, parent, arg = {})
		super(app, parent, arg)
		create if self.class == XYCalender
	end
	
	def create
		@handle = WinAPI.call("user32", "CreateWindowEx", 0x204, "SysMonthCal32", "", 
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