=begin
	
	v1.0.0  by sxysxy           2016.03.30
=end

require 'XYGui/winapi_base.rb'
require 'XYGui/xy_widget.rb'

class XYRadioButton < XYWidget
	def initialize(app, parent, arg = {})
		super(app, parent, arg)
		create if self.class == XYRadioButton
	end
	
	def create
		@handle = WinAPI.call("user32", "CreateWindowEx", 0, "BUTTON", @title, 
								WS_CHILD | BS_AUTORADIOBUTTON,
								@x, @y, @width, @height, 
								@parent.handle,@id, 
								@app.instance,
								0)
	end
	
	def defaultWidth
		100
	end
	
	def defaultHeight
		30
	end
	
	def defaultTitle
		"ClickMe"
	end
end