=begin
	XYPasswordLine
		sxysxy 2016.05.14
=end
require 'XYGui/xy_widget.rb'
require 'XYGui/xy_lineedit.rb'

class XYPasswordLine < XYLineEdit
	def initialize(app, parent, arg = {})
		super(app, parent, arg)
		create if self.class == XYPasswordLine
	end
	def create
		lineEditCreate(ES_PASSWORD)
	end
	
	def setVisible(flag)
		
	end
	alias :visible= :setVisible
	
	def defaultY
		100
	end
end