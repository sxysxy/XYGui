=begin
	Basic Graphics Support
	Use native API to provide basic painting function...........
		sxysxy 2016.05.11
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
	def initialize(srcwidget = nil)
		@widget = srcwidget
			#! notice, please use @widget.dc (dc should be updated when ON_PAINT)
		
	end
	
	def paint(&p)
		flag = false  #flag of not ON_PAINT
		if !@widget.dc
			flag = true #Not caused by ON_PAINT
			@widget.dc = WinAPI.call("user32", "GetDC", @widget.handle)
		end
		instance_eval(&p)
		if flag
			destroy
			WinAPI.call("user32", "ReleaseDC", @widget.handle, @widget.dc)
			@widget.dc = nil
		end
	end
	
#---------------------------------------------------------------------------------------------------
	
#See XYGui_ext.c These function may be called very frequently
=begin
	def line(srcx, srcy, destx, desty)
		WinAPI.call "gdi32", "MoveToEx", @widget.dc, srcx, srcy, 0
		WinAPI.call "gdi32", "LineTo", @widget.dc, destx, desty
	end
	def lineTo(x, y)
		WinAPI.call "gdi32", "LineTo", @widget.dc, x, y
	end
=end
	alias :drawLine :line
=begin
	def ellipse(cenx, ceny, a, b)
		WinAPI.call("gdi32", "Ellipse", @widget.dc, cenx-a/2, ceny-b/2, cenx+a/2, ceny+b/2)
	end
=end
	alias :drawEllipse :ellipse
=begin
	def circle(cenx, ceny, r)
		ellipse(cenx, ceny, r*2, r*2)
	end
	def fillRect(x, y, w, h)
		WinAPI.call("user32", "FillRect", @widget.dc, [x,y,w+x,h+y].pack("LLLL"), @brush.handle)
	end
=end
	alias :drawRect :fillRect
	alias :rect :fillRect
	alias :drawText :text
=begin
	def point(x, y)
		
	end
=end
	alias :drawPoint :point
	#---------------------------------------------------
	
#----------------------------------------------------------------------------------------------------
#See XYGui_ext.c , These function may be called very frequently
=begin
	def setBrush(br)
		#Destroy old brush
		WinAPI.call("gdi32", "SelectObject", @widget.dc, @oriBrush.handle)
		                    #Erase @brush's refrence count(Then Windows can DeleteObejct it)
		@brush.destroy
		@bursh = nil
		
		#Apply the new brush
		@brush = br
					#@brush has been created when XYBrush.new
		WinAPI.call("gdi32", "SelectObject", @widget.dc, @brush.handle)
	end
=end
	alias :brush= :setBrush
=begin
	def setPen(pn)
		
	end
=end
	alias :pen= :setPen
	#----------------------------------------------------------------------
	
	#----------------------------------------------------------------------
	def reset
		@oriBrush = XYStockPainterTool.new(defBrush)
		@brush = @oriBrush
		@oriPen = XYStockPainterTool.new(defPen)
		@pen = @oriPen
	end
	def destroy
		@brush.destroy
		@pen.destroy
	end
	#---------------------------------------------------------------------
	private :defBrush, :defPen
end