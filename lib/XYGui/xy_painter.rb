=begin
	Basic Graphics Support
	Use native API to provide basic painting function...........
=end
require 'XYGui/winapi_base.rb'

class XYPainter 
	attr_reader :widget
	
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
	#---------------------------------------------------
	
	#---------------------------------------------------
	def ellipse(cenx, ceny, a, b)
		WinAPI.call("gdi32", "Ellipse", @widget.dc, cenx-a/2, ceny-b/2, cenx+a/2, ceny+b/2)
	end
	alias :drawEllipse :ellipse
	def circle(cenx, ceny, r)
		ellipse(cenx, ceny, r, r)
	end
	#---------------------------------------------------
end