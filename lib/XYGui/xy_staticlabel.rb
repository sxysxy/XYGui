=begin

=end

require 'XYGui/winapi_base.rb'
require 'XYGui/xy_widget.rb'

class XYStaticLabel < XYWidget
	
	def initialize(app, parent = nil, arg = {})
		super(app, parent, arg)
	end
	
	def create
		@handle = WinAPI.call("user32", "CreateWindowEx", 0, "STATIC"	
							WS_CHILD | WS_BORDER | WS_VISIBLE | SS_LEFT,
								@x, @y, @width, @height, @parent.handle, 
								getAsChildId,
								app.instance, 0)
	end
end