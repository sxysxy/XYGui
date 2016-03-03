=begin

=end

require 'XYGui/xy_widget.rb'
require 'XYGui/xy_app.rb'
require 'XYGui/winapi_base.rb'
require 'XYGui/xy_layout.rb'

class XYMainWindow < XYWidget
	attr_reader :style
	attr_reader :type
	attr_reader :layout
	
	def initialize(app, parent = nil, arg = {})
		super(app, parent, arg)
		
		@style = arg[:style]? arg[:style]: 0
		@type = arg[:type]? arg[:type]: 0
		@layout = arg[:layout]? arg[:layout]: XYLayout.new
		
		#-----------------
		proc = Class.new(Fiddle::Closure) do
			define_method :call do |hwnd, msg, lparam, wparam|
				case msg
					when WM_DESTROY then
						WinAPI.call("user32", "PostQuitMessage", 0)
					else
						return WinAPI.call("user32", "DefWindowProc", hwnd, msg, lparam, wparam)
				end
			end
		end.new(Fiddle::TYPE_INT, [Fiddle::TYPE_INT]*4)
		func = Fiddle::Function.new(proc, [Fiddle::TYPE_INT]*4, Fiddle::TYPE_INT)
		#-----------------
		wndcls = [@type, func.to_i, 0, 0, app.instance, WinAPI.call("user32", "LoadIcon", app.instance, IDI_APPLICATION),
					WinAPI.call("user32", "LoadCursor", app.instance, IDC_ARROW), COLOR_WINDOW + 1,
					0, app.name].pack("lllllllllp")
		
		unless app.instance_eval{@name_registered}
			r = WinAPI.call("user32", "RegisterClass", wndcls)
			raise XYWidgetError, "Fail to rgister MainWindow's Window Class" if r == 0
			app.instance_eval{@name_registered = true}
		end
		show
	end
	
	def create
		@handle = WinAPI.call("user32", "CreateWindowEx", 0, app.name, @title,  
							WS_VISIBLE | WS_OVERLAPPEDWINDOW,   
							@x, @y, @width, @height,              
							0, 0,
							app.instance, 0)
	end
	
	def title=(new_title)
		
	end
	
	def style=(new_style)
		
	end
	
	def layout=(new_layout)
		
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
		@layout.addWidget(c)
	end
end