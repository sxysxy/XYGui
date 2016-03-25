=begin

=end

require 'XYGui/winapi_base.rb'
require 'XYGui/xy_widget.rb'

class XYMenu < XYWidget
	
	def initialize(widget = nil, arg = {})
		@handle = WinAPI.call("user32", "CreateMenu")
	end
	
	
end