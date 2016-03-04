=begin

=end

require 'XYGui/xy_widget.rb'

class XYWindow < XYWidget
	attr_reader :layout
	def initialize(app, parent = nil, arg = {})
		super(app, parent, arg)
		@layout = arg[:layout]? arg[:layout].new(self): XYLayout.new(self)
		
		connect(:ON_SIZE){|a,b| onSize(a, b)}
	end
	
	def layout=(new_layout)
		@layout = new_layout
		@layout.replace
	end
	
	def wndproc
		_self = self
		_content = @content
		_responder = @responder
		proc = Class.new(Fiddle::Closure) do
			define_method :call do |hwnd, msg, wparam, lparam|
				case msg
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
		return Fiddle::Function.new(proc, [Fiddle::TYPE_INT]*4, Fiddle::TYPE_INT).to_i
	end
	
	def onSize(wparam, lparam)
		@width = WinAPI.loword(lparam)
		@height = WinAPI.hiword(lparam)
		@layout.replace
	end
end