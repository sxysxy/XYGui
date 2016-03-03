=begin

=end

require 'XYGui/winapi_base.rb'
require 'XYGui/xy_widget.rb'

class XYPushButton < XYWidget
	attr_reader :text
	
	def initialize(app, parent = nil, arg = {})
		super(app, parent, arg)
		@handle = WinAPI.call("user32", "CreateWindowEx", 0, "Button", "Button",
								WS_CHILDWINDOW|BS_DEFPUSHBUTTON,
								@x, @y, @width, @height, parent.handle,
								0, app.instance, 0)
		show
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