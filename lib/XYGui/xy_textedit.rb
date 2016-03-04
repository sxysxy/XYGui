=begin

=end

require 'XYGui/winapi_base.rb'
require 'XYGui/xy_widget.rb'

class XYTextEdit < XYWidget

	def initialize(app, parent = nil, arg = {})
		super(app, parent, arg)
		
		@text = arg[:text]? arg[:text]: ""
	end
	
	def create
		@handle = WinAPI.call("user32", "CreateWindowEx", 0, "EDIT", @text, 
								WS_CHILD | WS_VISIBLE | ES_AUTOSCROLL,
								@x, @y, @width, @height,
								@parent.handle, getAsChildId,
								app.instance, 0)
	end
	
	def defaultHeight
		return 200
	end
	
	def defaultWidth
		return 100
	end
	
	def text
	
	end
end