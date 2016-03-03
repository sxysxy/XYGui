=begin

=end

require 'XYGui/winapi_base.rb'
require 'XYGui/xy_widget.rb'

class XYLayout < XYWidget
	def initialize(wnd)
		super(wnd.app, wnd, {:width => wnd.width, :height => wnd.height})
	end
	def addWidget(widget)
		raise XYWidgetError, "Layout# addWidget require a XYWidget!" if !widget.is_a?(XYWidget)
		@content.push(widget)
		replace
	end
	def replace
		
	end
end