=begin

=end

require 'XYGui/xy_widget.rb'
require 'XYGui/xy_app.rb'
require 'XYGui/winapi_base.rb'

class XYMainWindow < XYWidget
	attr_reader :style
	attr_reader :type
	
	def initialize(app, arg)
		arg ||= {}
		@title = arg[:title]? arg[:title]: "Window"
		@style = arg[:style]? arg[:style]: 0
		@type = arg[:type]? arg[:type]: 0
		@width = arg[:width]? arg[:width]: 200
		@height = arg[:height]? arg[:height]: 200
		@x = arg[:x]? arg[:x]: 200
		@y = arg[:y]? arg[:y]: 200
		@shown = false
		@app = app
		
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
	end
	
	def create
		@handle = WinAPI.call("user32", "CreateWindowEx", 0, app.name, @title,  
							WS_VISIBLE | WS_OVERLAPPEDWINDOW,   
							@x, @y, @width, @height,              
							0, 0,
							app.instance, 0)
	end
	
	def show(flag = 1)
		WinAPI.call("user32", "ShowWindow", @handle, flag)
		if flag != 0
			@shown = true
		else
			@shown = false
		end
	end
	
	def is_shown?
		return @shown
	end
	
	def title=(new_title)
		
	end
	
	def style=(new_style)
		
	end
end