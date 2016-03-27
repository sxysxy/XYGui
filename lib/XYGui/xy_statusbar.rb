=begin
	
=end

require 'XYGui/winapi_base.rb'
require 'XYGui/xy_widget.rb'

class XYStatusBar < XYWidget
	def initialize(app, parent, arg = {})
		super(app, parent, arg)
		create
		
		setText(@text)
	end
	
	def create
		@handle = WinAPI.call("user32", "CreateWindowEx", 0, "msctls_statusbar32", "", 
								WS_CHILD,
								@x, @y, @width, @height, 
								@parent.handle,@id, 
								@app.instance,
								0)
	end
	
	def defaultWidth
		@parent.width
	end
	
	def defaultHeight
		30
	end
	
	def defaultText
		"Ready"
	end

end