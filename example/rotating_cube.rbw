require 'XYGuiCore'
require 'XYGuiGL'

def drawRectfb(x, y, z, a)
	GL.Vertex(x, y, z)
	GL.Vertex(x+a, y, z)
	GL.Vertex(x+a, y+a, z)
	GL.Vertex(x, y+a, z)
end
def drawRectlr(x, y, z, a)
	GL.Vertex(x, y, z)
	GL.Vertex(x, y, z+a)
	GL.Vertex(x, y+a, z+a)
	GL.Vertex(x, y+a, z)
end
def drawRecttb(x, y, z, a)
	GL.Vertex(x, y, z)
	GL.Vertex(x+a, y, z)
	GL.Vertex(x+a, y, z+a)
	GL.Vertex(x, y, z+a)
end

$angle = 20

XYApp.new("cube") do |app|
	XYMainWindow.new(app, nil, {:width => 416, :height => 480, :title => "Cube"}) do |wnd|
		XYGLLabel.new(app, wnd, {:width => 400, :height => 400, :x => 0, :y => 0}) do |glb|
			glb.connect(:ON_PAINT) do |sender, data|
				GL.Enable(GL::GL_DEPTH_TEST)
				GL.ClearColor(0.0, 0.0, 0.0, 0.0)
				GL.Clear(GL::GL_COLOR_BUFFER_BIT | GL::GL_DEPTH_BUFFER_BIT)
				GL.PushMatrix
			
				GL.Rotate($angle, 1, 1, 0)
				GL.Begin(GL::QUADS)
					GL.Color(1.0, 0.0, 0.0)
					drawRectfb(-0.5, -0.5, -0.5, 1.0)
					drawRectfb(-0.5, -0.5, 0.5, 1.0)
					GL.Color(0.0, 1.0, 0.0)
					drawRectlr(-0.5, -0.5, -0.5, 1.0)
					drawRectlr(0.5, -0.5, -0.5, 1.0)
					GL.Color(0.0, 0.0, 1.0)
					drawRecttb(-0.5, 0.5, -0.5, 1.0)
					drawRecttb(-0.5, -0.5, -0.5, 1.0)
				GL.End
			
				GL.PopMatrix
				glb.render
			end
		end
	
		XYPushButton.new(app, wnd, {:y => 400, :text => "Rotate It"}).set do
			connect(:ON_COMMAND) do |sende, data|
				$angle += 10
				wnd.content[0].call(:ON_PAINT, nil, nil)
			end
		end
	end.show
end.mainloop