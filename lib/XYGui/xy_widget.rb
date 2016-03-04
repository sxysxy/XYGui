=begin

=end

require 'XYGui'
require 'XYGui/xy_app.rb'
require 'XYGui/winapi_base.rb'

class XYWidgetError < Exception

end

class XYWidget
	include XYGui
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
	
	attr_reader :responder
	
	
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
		@responder = {}
		
		@width = arg[:width]? arg[:width]: defualtWidth
		@height = arg[:height]? arg[:height]: defualtHeight
		@x = arg[:x]? arg[:x]: defualtX
		@y = arg[:y]? arg[:y]: defualtY
		@title = arg[:title]? arg[:title]: defualtTitle
		@shown = true
		
		@parent.addChild(self) if @parent
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
	def create
	
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
	
	def resize(w, h)
		@width = w
		@height = h
		WinAPI.call("user32", "MoveWindow", @handle, @x, @y, w, h, 1)
	end
	
	def repos(x, y)
		@x = x
		@y = y
		WinAPI.call("user32", "MoveWindow", @handle, @x, @y, @width, @handle, 0)
	end
	
	def title=(new_title)
		
	end
	
	def connect(sig, func)
		@responder[sig] = func
	end
end