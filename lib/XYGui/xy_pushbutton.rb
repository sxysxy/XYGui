=begin

=end

require 'XYGui/winapi_base.rb'
require 'XYGui/xy_widget.rb'

class XYPushButton < XYWidget
	attr_reader :text
	
	def initialize(app = nil, parent = nil, arg = {})
		super(app, parent, arg)
	end
	
	def defualtHeight
		return 40
	end
	def defualtWidth
		return 100
	end
	def defualtX
		return 0
	end
	def defualtY
		return 0
	end
	def defualtTitle
		return "Button"
	end
end