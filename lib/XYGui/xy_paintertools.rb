=begin
	Pen , Brush , ect
=end

require 'XYGui/winapi_base.rb'
require 'XYGui/xy_messagebox.rb'

class XYPainterTool
	attr_reader :red, :green, :blue
	attr_reader :handle
	
	def initialize(r = 0, g = 0, b = 0) 
		@red = r
		@green = g
		@blue = b
		@handle = 0
	end
	
	def create
	end
	
	def destroy 
		WinAPI.call("gdi32", "DeleteObject", @handle)
	end
end

class XYPen < XYPainterTool
	
	def initialize(r, g, b, arg = {})
		super(r, g, b)
	end
	
#See XYGui_ext.c These function may be called very frequently
=begin
	def create
		@handle = WinAPI.call("gdi32", "CreatePen", )
	end
=end
end

class XYBrush < XYPainterTool
	
	def initialize(r, g, b, arg = {})
		super(r, g, b)
	end

#See XYGui_ext.c These function may be called very frequently
=begin
	def create
		@handle = WinAPI.call("gdi32", "CreateSolidBrush", [@red, @green, @blue, 0].pack("cccc").unpack("L").first)
		#XYMessageBox.show("233", @handle.to_s)
	end
=end
end

# This class should't provide to users
class XYStockPainterTool < XYPainterTool
	def initialize(h)
		@handle = h
	end
	def create
		@handle
	end
	def destroy
	end
end
