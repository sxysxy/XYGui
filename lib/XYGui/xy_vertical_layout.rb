=begin

=end

require 'XYGui/xy_layout.rb'

class XYVerticalLayout < XYLayout
	def replace
		cur_y = 0
		@content.each do |e|
			WinAPI.call("user32", "MoveWindow", e.handle, 0, cur_y, e.width, e.height, 1)
			cur_y += e.width
		end
	end
end