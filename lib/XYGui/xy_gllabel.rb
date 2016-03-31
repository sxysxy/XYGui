=begin
	In fact, This is just only a child window without frame
	
	v1.0.0  by sxysxy           2016.03.30
=end
require 'XYGui/winapi_base.rb'
require 'XYGui/xy_label.rb'
require 'opengl'
require 'XYGui/xy_mainwindow.rb'
require 'XYGui/xy_messagebox.rb'

class XYGLLabel < XYLabel
	
	def initialize(app, parent, arg = {})
		super(app, parent, arg)
		
		
		create
	end
	
	def create
		@handle = WinAPI.call("user32", "CreateWindowEx", 0, @className, @title,  
							WS_CHILDWINDOW | @style,   
							@x, @y, @width, @height,              
							@parent.handle, @id,
							@app.instance, 0)
	end
	
	def onCreate(sender, data)
		XYMessageBox.show("233", "666")
	end
end