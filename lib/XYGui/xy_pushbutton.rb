=begin
	PushButton
	v1.0.0  by sxysxy           2016.03.30
=end

require 'XYGui/winapi_base.rb'
require 'XYGui/xy_widget.rb'
require 'XYGui/xy_button.rb'
class XYPushButton < XYWidget
	include XYButton
	def initialize(app, parent = nil, arg = {})
		super(app, parent, arg)
		create if self.class == XYPushButton
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
	def defaultText
		return "Button"
	end
end