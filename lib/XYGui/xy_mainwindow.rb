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

		wndcls = [@type, wndproc.to_i, 0, 0, app.instance, WinAPI.call("user32", "LoadIcon", app.instance, IDI_APPLICATION),
					WinAPI.call("user32", "LoadCursor", app.instance, IDC_ARROW), 5 + 1,
					0, app.name].pack("lllllllllp")
		
		unless app.instance_eval{@name_registered}
			r = WinAPI.call("user32", "RegisterClass", wndcls)
			raise XYWidgetError, "Fail to rgister MainWindow's Window Class" if r == 0
			app.instance_eval{@name_registered = true}
		end
		
		connect(:ON_DESTROY) {|a,b| onDestroy(a, b)}
		
		create
		show
	end
	
	def create
		@handle = WinAPI.call("user32", "CreateWindowEx", 0, app.name, @title,  
							WS_VISIBLE | WS_OVERLAPPEDWINDOW,   
							@x, @y, @width, @height,              
							0, 0,
							app.instance, 0)
	end
	
	def style=(new_style)
		
	end

	def defualtHeight
		return 300
	end
	def defualtWidth
		return 300
	end
	def defualtX
		return 100
	end
	def defualtY
		return 100
	end
	def defualtTitle
		return "Window"
	end
	
	def addChild(c)
		super(c)
		@layout.replace
	end
	
	def onDestroy(wp, lp)
		WinAPI.call("user32", "PostQuitMessage", 0)
	end
end