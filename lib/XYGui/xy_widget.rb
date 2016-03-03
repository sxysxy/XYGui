=begin

=end

require 'XYGui/xy_app.rb'
require 'XYGui/winapi_base.rb'

class XYWidgetError < Exception

end

class XYWidget
	attr_reader :handle
	attr_reader :title
	attr_reader :width
	attr_reader :height
	attr_reader :x
	attr_reader :y
	attr_reader :app
	
	WS_OVERLAPPEDWINDOW	 = 0xcf0000
	WS_VISIBLE	 = 0x10000000
	
	IDI_APPLICATION  = 32512
	IDC_ARROW = 32512
	
	SW_HIDE  = 0
	SW_NORMAL  = 1
	
	COLOR_WINDOW = 5
	
	WM_NULL = 0
	WM_CREATE = 1
	WM_DESTROY = 2
	
	def initialize
		
	end
end