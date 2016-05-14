=begin
	TextView
	    sxysxy 2016.05.14
=end
require 'XYGui/xy_scrollable_widget.rb'

class XYTextView < XYScrollableWidget
	
	def initialize(app, wnd, arg = {})
		super(app, wnd, arg)
		create if self.class == XYTextView
	end
	
	def create
		@handle = WinAPI.call("user32", "CreateWindowEx", 0, "STATIC", @text,
								WS_CHILD | @style, 
								@x, @y, @width, @height, @parent.handle,
								@id, @app.instance, 0)
	end
	
	def defaultText
		"TextView"
	end
	def defaultWidth 
		80
	end
	def defaultHeight
		30
	end
end