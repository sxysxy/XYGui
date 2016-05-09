=begin
	In fact, This is just only a child window without frame
	
	v1.0.0  by sxysxy           2016.03.30
=end


require 'XYGui/winapi_base.rb'
require 'XYGui/xy_childwindow.rb'

class XYLabel < XYChildWindow
	
	def initialize(app, parent, arg = {})
		super(app, parent, arg)
		if self.class == XYLabel
			create
			yield(self) if block_given?
		end
	end
	
	def create
		childCreate(@style)
	end
	
	def onDestroy(sender, data)

	end
end