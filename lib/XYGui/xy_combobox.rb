=begin

=end

require 'XYGui/winapi_base.rb'
require 'XYGui/xy_widget.rb'

class XYComboBox < XYWidget
	def initialize(app, parent, arg = {})
		super(app, parent, arg)
		create
	end
	
	def create
		@handle = WinAPI.call("user32", "CreateWindowEx", 0, "ComboBoxEx32", @title, 
								WS_CHILD,
								@x, @y, @width, @height, 
								@parent.handle,@id, 
								@app.instance,
								0)
	end
	
	def defaultWidth
		80
	end
	
	def defaultHeight
		20
	end
end