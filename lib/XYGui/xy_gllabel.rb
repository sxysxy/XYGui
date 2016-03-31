=begin
	In fact, This is just only a child window without frame
	
	v1.0.0  by sxysxy           2016.03.30
=end
require 'XYGui/winapi_base.rb'
require 'XYGui/xy_label.rb'
require 'opengl'
require 'XYGui/xy_mainwindow.rb'
require 'XYGui/xy_messagebox.rb'

class XYGLLabel < XYLabel
	
	attr_reader :glrc
	def initialize(app, parent, arg = {})
		super(app, parent, arg)
		@glrc = 0
		connect(:ON_PAINT) {|a,b| onPaint(a,b)}
		
		if self.class == XYGLLabel
			create
			yield(self) if block_given?
		end
	end
	
	def create
		@handle = WinAPI.call("user32", "CreateWindowEx", 0, @className, @title,  
							WS_CHILDWINDOW | @style | WS_VISIBLE,   
							@x, @y, @width, @height,              
							@parent.handle, @id,
							@app.instance, 0)
	end
	
	def enableGL
		#pfd
		pfd = [40, 1, 			#size = 40, version = 1  
				4|32|1,         #support opengl, double buffers, and draw to window
				0,				#pixel type :RGBA
				24,				#color bits
				0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,    #0 * 18 Do not care...
				0,				#layerMask
				0, 0].pack("ssLccccccccccccccccccccLLL")
				
		
		format = WinAPI.call("gdi32", "ChoosePixelFormat", @dc, pfd) 
		WinAPI.call("gdi32", "SetPixelFormat", @dc, format, pfd)
		
		@glrc = WinAPI.call("opengl32", "wglCreateContext", @dc)
		WinAPI.call("opengl32", "wglMakeCurrent", @dc, @glrc)
	end
	
	def disableGL
		WinAPI.call("opengl32", "wglMakeCurrent", 0, 0)
		WinAPI.call("opengl32", "wglDeleteContext", @glrc)
	end
	
	def onDestroy(sender, data)
		disableGL
		super(sender, data)
	end
	
	def onCreate(sender, data)
		@dc = WinAPI.call("user32", "GetDC", @handle)
		enableGL
	end
	
	def onSize(sender, data)
		
	end
	
	def beginPaint(sender, data)
		@dc = WinAPI.call("user32", "BeginPaint", @handle, @ps.to_i)
		@responder[:ON_PAINT].call(sender, data) if @responder[:ON_PAINT]
		#WinAPI.call("gdi32", "SwapBuffers", @hc) if @responder[:ON_PAINT]
		WinAPI.call("user32", "EndPaint", @handle, @ps.to_i)
	end
	
	def onPaint(sender, data)
		GL.ClearColor(0.0, 0.0, 0.0, 0.0)
	end
end