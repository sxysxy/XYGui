=begin
	Base widget 
=end

require 'XYGui'
require 'XYGui/xy_app.rb'
require 'XYGui/winapi_base.rb'
require 'XYGui/xy_font.rb'

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
	attr_reader :style
	attr_reader :front
	
	attr_reader :responder
	
	alias :to_i :handle
	
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
		
		@width = arg[:width]? arg[:width]: defaultWidth
		@height = arg[:height]? arg[:height]: defaultHeight
		@x = arg[:x]? arg[:x]: defaultX
		@y = arg[:y]? arg[:y]: defaultY
		@title = arg[:title]? arg[:title]: defaultTitle
		@style = arg[:style]? arg[:style]: 0
		@shown = true
		@font = arg[:font]? arg[:font]: XYFont.new
		@font.widget = self
		@font.apply
		
		@parent.addChild(self) if @parent
	end
	
	def defaultHeight
		return 0
	end
	def defaultWidth
		return 0
	end
	def defaultX
		return 0
	end
	def defaultY
		return 0
	end
	def defaultTitle
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
		WinAPI.call("user32", "UpdateWindow", @handle)
		@content.each {|e| e.show}
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
	
	def getAsChildId
		@parent? (@parent.content.size - 1): 0 
	end
	
	def connect(sig, &func)
		@responder[sig] = func
	end
end