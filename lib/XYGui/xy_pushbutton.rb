=begin

=end

require 'XYGui/winapi_base.rb'
require 'XYGui/xy_widget.rb'

class XYPushButton < XYWidget
	attr_reader :text
	
	def initialize(app, parent = nil, arg = {})
		super(app, parent, arg)
		create
		show
	end
	
	def create
		@handle = WinAPI.call("user32", "CreateWindowEx", 0, "Button", @title,
							WS_CHILDWINDOW|BS_DEFPUSHBUTTON,
							@x, @y, @width, @height, @parent.handle,
							@parent.content.size - 1,    #use to tell child-window-id
							app.instance, 0)
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