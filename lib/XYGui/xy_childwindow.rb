=begin

	v1.0.0  by sxysxy           2016.03.30
=end

require 'XYGui/winapi_base.rb'
require 'XYGui/xy_mainwindow.rb'

class XYChildWindow < XYWindow
	
	def initialize(app, parent, arg = {})
		super(app, parent, arg)
		@style = WS_CHILDWINDOW 
		@style |= arg[:style] if arg[:style]
		if self.class == XYChildWindow
			create 
			yield(self) if block_given?
		end
	end
	
	def create
		childCreate(@style | WS_OVERLAPPEDWINDOW)
	end
	
	def onDestroy(sender, data)

	end
	
	private
	def childCreate(createStyle)
		@handle = WinAPI.call("user32", "CreateWindowEx", 0, @className, @title,  
							createStyle,   
							@x, @y, @width, @height,              
							@parent.handle, @id,
							@app.instance, selfval)
	end
end