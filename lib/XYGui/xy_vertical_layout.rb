=begin

=end

require 'XYGui/xy_layout.rb'

class XYVerticalLayout < XYLayout
	def initialize(wnd)
		super(wnd)
	end
	def replace
		cur_y = 0
		@window.content.each do |e|
			e.repos(0, cur_y)
			e.resize(@window.width, e.height)
			cur_y += e.height
		end
	end
end