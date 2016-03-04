=begin

=end

require 'XYGui/xy_widget.rb'

class XYWindow < XYWidget
	attr_reader :layout
	def initialize(app, parent = nil, arg = {})
		super(app, parent, arg)
		@layout = arg[:layout]? arg[:layout].new(self): XYLayout.new(self)
	end
	
	def layout=(new_layout)
		@layout = new_layout
		@layout.replace
	end
	
	def wndproc
		proc = Class.new(Fiddle::Closure) do
			define_method :call do |hwnd, msg, lparam, wparam|
				return WinAPI.call("user32", "DefWindowProc", hwnd, msg, lparam, wparam)
			end
		end.new(Fiddle::TYPE_INT, [Fiddle::TYPE_INT]*4)
		return Fiddle::Function.new(proc, [Fiddle::TYPE_INT]*4, Fiddle::TYPE_INT).to_i
	end
end