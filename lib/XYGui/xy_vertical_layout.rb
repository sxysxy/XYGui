=begin

=end

require 'XYGui/xy_layout.rb'

class XYVerticalLayout < XYLayout
	def initialize(wnd)
		super(wnd)
	end
	def replace
		cur_y = 0
		@content.each do |e|
			e.instance_eval{@x = 0; @y = cur_y}
			WinAPI.call("user32", "MoveWindow", e.handle, 0, cur_y, e.width, e.height, 1)
			cur_y += e.height
		end
	end
end