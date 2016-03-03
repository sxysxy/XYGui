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
	attr_reader :parent
	attr_reader :content
	attr_reader :shown
	
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
	
	def initialize(app = nil, parent = nil, arg = {})
		@handle = 0
		@title = ""
		@width = 0
		@height = 0
		@x = 0
		@y = 0
		@app = app
		@parent = parent
		@content = []
		
		@width = arg[:width]? arg[:width]: defualtWidth
		@height = arg[:height]? arg[:height]: defualtHeight
		@x = arg[:x]? arg[:x]: defualtX
		@y = arg[:y]? arg[:y]: defualtY
		@title = arg[:title]? arg[:title]: defualtTitle
		@shown = false
	end
	
	def defualtHeight
		return 0
	end
	def defualtWidth
		return 0
	end
	def defualtX
		return 0
	end
	def defualtY
		return 0
	end
	def defualtTitle
		return ""
	end
	
	def isShown?
		return @shown
	end
	
	def isChildWidget?
		return @parent? true: false
	end
end