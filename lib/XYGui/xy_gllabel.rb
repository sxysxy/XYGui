=begin
	Wrap OpenGL into XYLabel 
	
	v1.0.0  by sxysxy           2016.04.01
=end
require 'XYGui/winapi_base.rb'
require 'XYGui/xy_label.rb'
require 'XYGui/xy_messagebox.rb'
require 'opengl'
require 'glu'

class XYGLLabel < XYLabel
	
	attr_reader :glrc
	def initialize(app, parent, arg = {})
		super(app, parent, arg)
		@glrc = 0
		#connect(:ON_PAINT) {|a,b| onPaint(a,b)}
		
		if self.class == XYGLLabel
			create
			onCreate(0, 0)
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
				37,         #support opengl, double buffers, and draw to window
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
	
	def initGL
		GL.ShadeModel(GL::GL_SMOOTH)
		GL.ClearColor(1.0, 1.0, 1.0, 0.0)
		GL.ClearDepth(1.0)
		GL.Enable(GL::GL_DEPTH_TEST)
		GL.DepthFunc(GL::GL_LEQUAL)
		GL.Hint(GL::GL_PERSPECTIVE_CORRECTION_HINT, GL::GL_NICEST)
		resizeGL(@width, @height)
	end
	
	def resizeGL(w, h)
		GL.Viewport(0, 0, w, h)
		GL.MatrixMode(GL::GL_PROJECTION)
		GL.LoadIdentity
		GLU.Perspective(0.0, w.to_f/h.to_f, 0.1, 100.0)
		GL.MatrixMode(GL::GL_MODELVIEW)
		GL.LoadIdentity
	end
	
	def onDestroy(sender, data)
		disableGL
		super(sender, data)
	end
	
	def onCreate(sender, data)
		@dc = WinAPI.call("user32", "GetDC", @handle)
		enableGL
		#initGL
	end
	
	def onSize(sender, data)
		#resizeGL(data[:width], data[:height])
	end
	
	def beginPaint(sender, data)
		WinAPI.call("user32", "BeginPaint", @handle, @ps.to_i)
		#@dc = WinAPI.call("user32", "BeginPaint", @handle, @ps.to_i)
		#@glrc = WinAPI.call("opengl32", "wglCreateContext", @dc)
		if @responder[:ON_PAINT]
			#WinAPI.call("opengl32", "wglMakeCurrent", @dc, @glrc)
			@responder[:ON_PAINT].call(sender, data) 
			WinAPI.call("gdi32", "SwapBuffers", @dc)
		end
		WinAPI.call("user32", "EndPaint", @handle, @ps.to_i)
	end
	
	def onPaint(sender, data)
	
	end
end