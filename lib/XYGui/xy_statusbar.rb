=begin
	
	v1.0.0  by sxysxy           2016.03.30
=end

require 'XYGui/winapi_base.rb'
require 'XYGui/xy_widget.rb'

class XYStatusBar < XYWidget
	def initialize(app, parent, arg = {})
		super(app, parent, arg)
		create if self.class == XYStatusBar
		
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
		0
	end
	
	def defaultText
		"Ready"
	end

end