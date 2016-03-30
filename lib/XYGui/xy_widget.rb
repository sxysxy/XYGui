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
	attr_reader :text
	attr_reader :height
	attr_reader :idcount	#id for childs
	attr_writer :id			#id for itself
	attr_reader :x
	attr_reader :y
	attr_reader :app
	attr_reader :parent
	attr_reader :content
	attr_reader :shown
	attr_reader :style
	attr_reader :font
	
	attr_reader :responder
	
	alias :to_i :handle
	alias :set :instance_eval
	
	def initialize(app, parent = nil, arg = {})
		@handle = 0
		@app = app
		@parent = parent
		@content = []
		@responder = {}
		@id = 0
		@idcount = -1
		
		@width = arg[:width]? arg[:width]: defaultWidth
		@height = arg[:height]? arg[:height]: defaultHeight
		@x = arg[:x]? arg[:x]: defaultX
		@y = arg[:y]? arg[:y]: defaultY
		@title = arg[:title]? arg[:title]: defaultTitle
		@text = arg[:text]? arg[:text]: defaultText
		@style = arg[:style]? arg[:style]: 0
		@shown = true
		@font = arg[:font]? arg[:font]: XYFont.new
		@font.widget = self
		
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
	def defaultText
		return ""
	end
	
	#---------------------
	def setText(str)
		@@xywidgetSendmsgSetText ||= Win32API.new("user32", "SendMessage", "LLLp", "i")
		@@xywidgetSendmsgSetText.call(@handle, WM_SETTEXT, 0, str)
	end
	def text=(str)
		setText(str)
	end
	def getText
		@text
	end
	def text
		getText
	end
	#---------------------
	
	#---------------------
	def isShown?
		return @shown
	end
	def create
	
	end
	def show(flag = 1)
		WinAPI.call("user32", "ShowWindow", @handle, flag)
		if flag != 0
			@shown = true
			WinAPI.call("user32", "UpdateWindow", @handle)
			@font.apply
			@content.each {|e| e.show}
		else
			@shown = false
		end
	end
	def hide 
		show(0)
	end
	#-----------------------
	
	#-----------------------
	def isChildWidget?
		return @parent? true: false
	end
	
	def addChild(c)
		@idcount += 1
		c.id = @idcount
		@content.push(c)
	end
	#-----------------------
	
	#-----------------------
	def resize(w, h)
		@width = w
		@height = h
		WinAPI.call("user32", "MoveWindow", @handle, @x, @y, w, h, 1)
	end
	alias :setSize :resize
	def width=(nw)
		resize(nw, @height)
	end
	def height=(nh)
		resize(@width, nh)
	end
	
	def repos(x, y)
		@x = x
		@y = y
		WinAPI.call("user32", "MoveWindow", @handle, @x, @y, @width, @handle, 0)
	end
	alias :setPos :repos
	def x=(nx)
		repos(nx, @y)
	end
	def y=(ny)
		repos(@x, ny)
	end
	#-------------------------
	
	#-------------------------
	def title=(new_title)
		setText(new_title) #for windows
	end
	alias :setTitle :title=
	#-------------------------
	
	#-------------------------
	def font=(new_font)
		@font = new_font
		@font.widget = self
		@font.apply
	end
	alias :setFont :font=
	#-------------------------
	def connect(sig, &func)
		@responder[sig] = func
	end
	
	def call(sig, *arg)
		@responder[sig].call *arg if @responder[sig]
	end
	#-------------------------
	
	def pushRequest(&proc)
		@app.request.push(self)
		@app.request.push(proc)
	end
	alias :request :pushRequest
end