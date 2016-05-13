=begin
	Basic Graphics Support
	Use native API to provide basic painting function...........
=end
require 'XYGui/winapi_base.rb'
require 'XYGui/xy_paintertools.rb'
class XYPainter 
	BLACK_BRUSH = 4
	BLACK_PAN = 7
	NULL_BRUSH = 5
	NULL_PEN = 8
	
	attr_reader :widget
	
	attr_reader :brush
	attr_reader :pen
	attr_reader :tools
	def initialize(srcwidget = nil)
		@widget = srcwidget
			#! notice, please use @widget.dc (dc should be updated when ON_PAINT)
		
	end
	
	alias :paint :instance_eval
	
	#--------------------------------------------------
	def line(srcx, srcy, destx, desty)
		WinAPI.call "gdi32", "MoveToEx", @widget.dc, srcx, srcy, 0
		WinAPI.call "gdi32", "LineTo", @widget.dc, destx, desty
	end
	def lineTo(x, y)
		WinAPI.call "gdi32", "LineTo", @widget.dc, x, y
	end
	alias :drawLine :line
	def ellipse(cenx, ceny, a, b)
		WinAPI.call("gdi32", "Ellipse", @widget.dc, cenx-a/2, ceny-b/2, cenx+a/2, ceny+b/2)
	end
	alias :drawEllipse :ellipse
	def circle(cenx, ceny, r)
		ellipse(cenx, ceny, r*2, r*2)
	end
	def fillRect(x, y, w, h)
		WinAPI.call("user32", "FillRect", @widget.dc, [x,y,w+x,h+y].pack("LLLL"), @brush.handle)
	end
	#---------------------------------------------------
	
	#---------------------------------------------------
	def setBrush(br)
		br.create
		WinAPI.call("gdi32", "SelectObject", @widget.dc, @oriBrush.handle)
		@brush.destroy
		@brush = br
		WinAPI.call("gdi32", "SelectObject", @widget.dc, @brush.handle)
	end
	alias :brush= :setBrush
	def setPen(pn)
		@pen = pn
		applyPen
	end
	alias :pen= :setPen
	#----------------------------------------------------------------------
	
	#----------------------------------------------------------------------
	def reset
		@brush = XYBrush.new(2, 3, 3)
		@oriBrush = XYStockPainterTool.new(WinAPI.call("gdi32", "SelectObject", @widget.dc, @brush.handle))
		@brush.destroy
		@brush = @oriBrush
		WinAPI.call("gdi32", "SelectObject", @widget.dc, @oriBrush.handle)
	end
	def destroy
		
	end
	#---------------------------------------------------------------------
end