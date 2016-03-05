=begin

=end

require 'XYGui/xy_widget.rb'

class XYWindow < XYWidget
	attr_reader :layout
	
	attr_reader :hdc
	attr_reader :ps
	def initialize(app, parent = nil, arg = {})
		super(app, parent, arg)
		@layout = arg[:layout]? arg[:layout].new(self): XYLayout.new(self)
		@hdc = 0
		@ps = Fiddle::Pointer.malloc(64)
		
		connect(:ON_SIZE){|a,b| onSize(a, b)}
		connect(:ON_BEGINPAINT) {|a,b| beginPaint(a,b)}
		connect(:ON_PAINT) {|a,b| onPaint(a,b)}
	end
	
	def show(flag = 1)
		@layout.replace
		super(flag)
	end
	
	def layout=(new_layout)
		@layout = new_layout
		@layout.replace
	end
	
	def wndproc
		_self = self
		_content = @content
		_responder = @responder
		_app = @app
		proc = Class.new(Fiddle::Closure) do
			define_method :call do |hwnd, msg, wparam, lparam|
				#return WinAPI.call("user32", "DefWindowProc", hwnd, msg, wparam, lparam) if hwnd != _handle  #not current window
				case msg
					when WM_PAINT then
						_responder[:ON_BEGINPAINT].call(wparam, lparam) if _responder[:ON_BEGINPAINT]
						return 0
					when WM_DESTROY then
						_responder[:ON_DESTROY].call(wparam, lparam) if _responder[:ON_DESTROY]
						return 0
					when WM_COMMAND then
						event = wparam >> 16   						#hiword
						id = wparam^(wparam>>16)<<16				 #loword
						_content[id].responder[:ON_COMMAND].call(wparam, lparam) if _content[id] && _content[id].responder[:ON_COMMAND]
						return 0
					when WM_SIZE then
						_responder[:ON_SIZE].call(wparam, lparam) if _responder[:ON_SIZE]
						return 0
					else
						return WinAPI.call("user32", "DefWindowProc", hwnd, msg, wparam, lparam)
				end
			end
		end.new(Fiddle::TYPE_INT, [Fiddle::TYPE_INT]*4)
		Fiddle::Function.new(proc, [Fiddle::TYPE_INT]*4, Fiddle::TYPE_INT).to_i
	end
	
	def onSize(wparam, lparam)
		@width = WinAPI.loword(lparam)
		@height = WinAPI.hiword(lparam)
		@layout.replace
	end
	
	def beginPaint(wparam, lparam)
		@hdc = WinAPI.call("user32", "BeginPaint", @handle, @ps.to_i)
		@responder[:ON_PAINT].call(wparam, lparam) if @responder[:ON_PAINT]
		WinAPI.call("user32", "EndPaint", @handle, @ps.to_i)
	end
	
	def onPaint(wparam, lparam)
		
	end
end