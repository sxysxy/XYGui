=begin
	Main Window 
	
	v1.0.0  by sxysxy           2016.03.30
=end

require 'XYGui/xy_window.rb'
require 'XYGui/xy_app.rb'
require 'XYGui/winapi_base.rb'
require 'XYGui/xy_layout.rb'
require 'XYGui/xy_messagebox.rb'

class XYMainWindow < XYWindow
	
	def initialize(app, parent = nil, arg = {})
		super(app, parent, arg)
		@style |= WS_OVERLAPPEDWINDOW
		@ex_style = 0
		if(arg[:fixed])
			@style &= (~(WS_THICKFRAME | WS_MAXIMIZEBOX))
		end
		@ex_style |= 16 if arg[:acfiles]   #ACCEPT_FILES

=begin
		wndcls = [CS_OWNDC | CS_HREDRAW | CS_VREDRAW, wndproc, 0, 0, app.instance, WinAPI.call("user32", "LoadIcon", app.instance, IDI_APPLICATION),
					WinAPI.call("user32", "LoadCursor", app.instance, IDC_ARROW), 5 + 1,
					0, @className].pack("lllllllllp")
		
		r = WinAPI.call("user32", "RegisterClass", wndcls)
		raise XYWidgetError, "Fail to rgister MainWindow's Window Class" if r == 0
=end
		#registerClass
		
		connect(:ON_DESTROY) {|a,b| onDestroy(a, b)}
		
		create if self.class == XYMainWindow
		yield(self) if block_given? && self.class == XYMainWindow
	end
	
	def create
		@handle = WinAPI.call("user32", "CreateWindowEx", 0 | @ex_style, @className, @title,  
							@style,   
							@x, @y, @width, @height,              
							0, 0,
							@app.instance, selfval)
	end
	
	def style=(new_style)
		
	end
	
	def defaultHeight
		return 300
	end
	def defaultWidth
		return 300
	end
	def defaultX
		return 100
	end
	def defaultY
		return 100
	end
	def defaultTitle
		return "Window"
	end
	
	def onDestroy(wp, lp)
		@app.exit
	end
end