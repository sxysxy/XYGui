=begin
	Pen , Brush , ect
=end

require 'XYGui/winapi_base.rb'
require 'XYGui/xy_messagebox.rb'

class XYPainterTool
	attr_reader :red, :green, :blue
	attr_reader :handle
	
	attr_reader :deletable
	def initialize(r = 0, g = 0, b = 0, del = true) 
		@red = r
		@green = g
		@blue = b
		@handle = 0
		@deletable = del
	end
	
	def create
	end
	
	def destroy 
		WinAPI.call("gdi32", "DeleteObject", @handle) if @deletable
	end
end

class XYPen < XYPainterTool
	
	def initialize(r, g, b, arg = {})
		super(r, g, b)
	end
	
	def create
		
	end
end

class XYBrush < XYPainterTool
	
	def initialize(r, g, b, arg = {})
		super(r, g, b)
		create
	end
	
	def create
		@handle = WinAPI.call("gdi32", "CreateSolidBrush", [@red, @green, @blue, 0].pack("cccc").unpack("L").first)
		#XYMessageBox.show("233", @handle.to_s)
	end
end