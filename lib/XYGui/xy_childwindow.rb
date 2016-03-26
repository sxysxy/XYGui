=begin

=end

require 'XYGui/winapi_base.rb'
require 'XYGui/xy_mainwindow.rb'

class XYChildWindow < XYMainWindow
	
	def initialize(app, parent, arg = {})
		super(app, parent, arg)
		
		create
	end
	
	def create
		@handle = WinAPI.call("user32", "CreateWindowEx", 0, @className, @title,  
							WS_OVERLAPPEDWINDOW | WS_CHILDWINDOW | @style,   
							@x, @y, @width, @height,              
							@parent.handle, @id,
							@app.instance, 0)
	end
	
	def onDestroy(sender, data)

	end
end