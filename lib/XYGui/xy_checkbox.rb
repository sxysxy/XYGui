=begin

=end

require 'XYGui/winapi_base.rb'
require 'XYGui/xy_widget.rb'

class XYCheckBox < XYWidget
	def initialize(app, parent, arg = {})
		super(app, parent, arg)
		create
	end
	
	def create
		@handle = WinAPI.call("user32", "CreateWindowEx", 0, "BUTTON", @title, 
								WS_CHILD | BS_AUTOCHECKBOX,
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
		"CheckOnMe"
	end
end