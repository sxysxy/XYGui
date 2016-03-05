=begin

=end

require 'XYGui/xy_window.rb'
require 'XYGui/xy_app.rb'
require 'XYGui/winapi_base.rb'
require 'XYGui/xy_layout.rb'

class XYMainWindow < XYWindow
	attr_reader :style
	attr_reader :type
	
	def initialize(app, parent = nil, arg = {})
		super(app, parent, arg)
		
		@style = arg[:style]? arg[:style]: 0
		@type = arg[:type]? arg[:type]: 0


		wndcls = [@type, wndproc, 0, 0, app.instance, WinAPI.call("user32", "LoadIcon", app.instance, IDI_APPLICATION),
					WinAPI.call("user32", "LoadCursor", app.instance, IDC_ARROW), 5 + 1,
					0, @className].pack("lllllllllp")
		
		r = WinAPI.call("user32", "RegisterClass", wndcls)
		raise XYWidgetError, "Fail to rgister MainWindow's Window Class" if r == 0
		app.instance_eval{@nameRegistered = true}

		connect(:ON_DESTROY) {|a,b| onDestroy(a, b)}
		create
	end
	
	def create
		@handle = WinAPI.call("user32", "CreateWindowEx", 0, @className, @title,  
							WS_OVERLAPPEDWINDOW,   
							@x, @y, @width, @height,              
							0, 0,
							@app.instance, 0)
	end
	
	def style=(new_style)
		
	end
	
	def defaultHeight
		return 300
	end
	def defaultWidth
		return 300
	end
	def defaultX
		return 100
	end
	def defaultY
		return 100
	end
	def defaultTitle
		return "Window"
	end
	
	def addChild(c)
		super(c)
		@layout.replace
	end
	
	def onDestroy(wp, lp)
		@app.exit
	end
end