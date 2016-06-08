=begin 

	v1.0.0  by sxysxy           2016.03.30
=end

require 'XYGui/winapi_base.rb'
require 'XYGui/xy_widget.rb'

require 'win32api'
class XYProgressBar < XYWidget

	PBM_SETRANGE = WM_USER+1
	PBM_SETPOS = WM_USER+2
	PBM_SETMARQUEE = WM_USER+10
=begin
	PBM_DELTAPOS = WM_USER+3 	
	PBM_SETSTEP	= WM_USER+4
	PBM_STEPIT = WM_USER+5
	PBM_SETRANGE32 = 1030
	PBM_GETRANGE = 1031
=end
	PBM_GETPOS = 1032
	PBM_SETBARCOLOR	= 1033
	PBS_SMOOTH = 1
	PBS_VERTICAL = 4
	PBS_MARQUEE = 0x8
	PBST_NORMAL = 1
	PBST_ERROR = 2
	PBST_PAUSED = 3
	
	PB_SendMessage = Win32API.new("user32", "SendMessage", "LLLL", "L")

	def initialize(app, parent, arg = {})
		super(app, parent, arg)
		create if self.class == XYProgressBar
		
		setValue(0)
		setRange(0, 10000)
		#setColor(0, 0xf4, 0x12)
		PB_SendMessage.call @handle, PBM_SETMARQUEE, 1, 0
	end
	
	def create
		@handle = WinAPI.call("user32", "CreateWindowEx", 0, "msctls_progress32", "", 
								WS_CHILD | WS_CHILDWINDOW | PBS_MARQUEE | PBS_SMOOTH, @x, @y, @width, @height,
								@parent.handle, @id, @app.instance, 0)
	end
	
	def defaultWidth
		@parent.width
	end
	
	def defaultHeight
		30
	end
	
	#------
	def setRange(min, max)
		PB_SendMessage.call(@handle, PBM_SETRANGE, 0, [min, max].pack("ss").unpack("L").first)
	end
	def range=(min, max)
		setRange(min, max)
	end
	#------
	
	#------
	def setValue(value)
		PB_SendMessage.call(@handle, PBM_SETPOS, value, 0)
	end
	def value=(p)
		setValue(p)
	end
	#-------
	
	#-------
	def setColor(r, g, b)
		PB_SendMessage.call(@handle, PBM_SETBARCOLOR, 0, [r, g, b, 0].pack("cccc").unpack("L").first)
	end
	def color=(r, g, b)
		setColor(r, g, b)
	end
	#--------
	
	#---------
	def getValue
		PB_SendMessage.call(@handle, PBM_GETPOS, 0, 0)
	end
	def value
		getValue
	end
	#---------
	
end