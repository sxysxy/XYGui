=begin

	v1.0.0  by sxysxy           2016.03.30
=end

require 'XYGui/winapi_base.rb'
require 'XYGui/xy_listbox.rb'

class XYComboBox < XYWidget
	def initialize(app, parent, arg = {})
		super(app, parent, arg)
		if self.class == XYComboBox
			create
			yield self if block_given?
		end
	end
	
	def create
		@handle = WinAPI.call("user32", "CreateWindowEx", 0, "combobox", "", 
								WS_CHILD | @style,
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