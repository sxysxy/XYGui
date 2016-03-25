=begin
	PushButton
=end

require 'XYGui/winapi_base.rb'
require 'XYGui/xy_widget.rb'

class XYPushButton < XYWidget
	attr_reader :text
	
	def initialize(app, parent = nil, arg = {})
		super(app, parent, arg)
		@text = @title
		create
	end
	
	def create
		@handle = WinAPI.call("user32", "CreateWindowEx", 0, "Button", @text,
							@style | 0x40010000,
							@x, @y, @width, @height, @parent.handle,
							@id,    #use to tell child-window-id
							@app.instance, 0)
	end
	
	
	
	def defaultHeight
		return 40
	end
	def defaultWidth
		return 100
	end
	def defaultX
		return 0
	end
	def defaultY
		return 0
	end
	def defaultTitle
		return "Button"
	end
end