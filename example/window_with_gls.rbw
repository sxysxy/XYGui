=begin
	MultiGL Test
=end
require 'XYGuiCore'
require 'XYGuiGL'

XYApp.new("MultiGLTest") do |app|
	XYMainWindow.new(app, nil, {:title => 'MultiGL', :width => 600, :height => 600, :fixed => true}) do |wnd|
		XYGLLabel.new(app, wnd, {:x => 0, :y => 0, :width => 300, :height => 300}).set do
			connect(:ON_PAINT) do |sender, data|
				GL.Enable(GL::GL_DEPTH_TEST)
				GL.ClearColor(0.0, 0.0, 0.0, 0.0)
				GL.Clear(GL::GL_COLOR_BUFFER_BIT | GL::GL_DEPTH_BUFFER_BIT)
					
				GL.PushMatrix
				GL.Begin(GL::GL_QUADS)
					GL.Color(1.0, 1.0, 0.0, 1.0)
					GL.Vertex(0.0, 0.8)
					GL.Vertex(0.8, 0.0,)
					GL.Vertex(0.0, -0.8)
					GL.Vertex(-0.8, 0.0)
				GL.End
				GL.PopMatrix
					
				render
			end
		end
		
		XYGLLabel.new(app, wnd, {:x => 300, :y => 0, :width => 300, :height => 300}).set do
			connect(:ON_PAINT) do |sender, data|
				GL.Enable(GL::GL_DEPTH_TEST)
				GL.ClearColor(0.0, 1.0, 0.0, 0.0)
				GL.Clear(GL::GL_COLOR_BUFFER_BIT | GL::GL_DEPTH_BUFFER_BIT)
				
				GL.PushMatrix
				GL.Begin(GL::TRIANGLES)
					GL.Color(1.0, 0.0, 1.0, 0.0)
					GL.Vertex(0.0, 0.87)
					GL.Vertex(0.87, -0.5)
					GL.Vertex(-0.87, -0.5)
				GL.End
				GL.PopMatrix
				render
			end
		end
		
		XYGLLabel.new(app, wnd, {:x => 0, :y => 300, :width => 300, :height => 300}).set do
			connect(:ON_PAINT) do |sender, data|
				GL.Enable(GL::GL_DEPTH_TEST)
				GL.ClearColor(0.0, 0.0, 1.0, 0.0)
				GL.Clear(GL::GL_COLOR_BUFFER_BIT | GL::GL_DEPTH_BUFFER_BIT)
				GL.PushMatrix
				GL.Begin(GL::TRIANGLES)
					GL.Color(0.3, 1.0, 0.4, 0.0)
					GL.Vertex(0.0, -0.7)
					GL.Vertex(0.8, 0.6)
					GL.Vertex(-0.8, 0.6)
				GL.End
				GL.PopMatrix
				render
			end
		end
		
		XYGLLabel.new(app, wnd, {:x => 300, :y => 300, :width => 300, :height => 300}).set do
			connect(:ON_PAINT) do |sender, data|
				GL.Enable(GL::GL_DEPTH_TEST)
				GL.ClearColor(1.0, 0.0, 0.0, 0.0)
				GL.Clear(GL::GL_COLOR_BUFFER_BIT | GL::GL_DEPTH_BUFFER_BIT)
				GL.PushMatrix
				GL.Begin(GL::POLYGON)
					r = 0.7
					lim = 30
					GL.Color(0.0, 1.0, 1.0)
					(0..lim).each{|i| GL.Vertex(r*Math.cos(2*Math::PI/lim*i),r*Math.sin(2*Math::PI/lim*i))}
				GL.End
				GL.PopMatrix
				render
			end
		end
	end.show
end.mainloop

