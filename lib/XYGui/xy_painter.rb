=begin
	Basic Graphics Support
	Use native API to provide basic painting function...........
=end

class XYPainter 
	attr_reader :widget
	attr_reader :dc
	
	def initialize(srcwidget = nil)
		@widget = srcwidget
		@dc = @widget.dc
	end
	
	alias :paint :instance_eval
	
# ! Notice! The following functions are defined in the extension
# See XYGui_ext.c 
# 
# line(srcx, srcy, destx, desty) 
	alias :drawLine :line
#
#
end