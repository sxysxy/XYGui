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
	
	
	def initialize(app, parent = nil, arg = {})
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
		@shown = true
		
		parent.addChild(self) if parent
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
	def show(flag = 1)
		WinAPI.call("user32", "ShowWindow", @handle, flag)
		if flag != 0
			@shown = true
		else
			@shown = false
		end
	end
	
	def isChildWidget?
		return @parent? true: false
	end
	
	def addChild(c)
		@content.push(c)
	end
end