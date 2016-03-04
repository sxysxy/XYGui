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
end