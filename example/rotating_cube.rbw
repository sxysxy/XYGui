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

$angle = 20.0
$dx = 1.0
$dy = 1.0
$dz = 0.0

XYApp.new("cube") do |app|
	XYMainWindow.new(app, nil, {:width => 400, :height => 400, :title => "Cube (Prees F1 for help)", :fixed => true}) do |wnd|
		XYGLLabel.new(app, wnd, {:width => 400, :height => 400, :x => 0, :y => 0}).set do
			connect(:ON_PAINT) do |sender, data|
				GL.Enable(GL::GL_DEPTH_TEST)
				GL.ClearColor(0.0, 0.0, 0.0, 0.0)
				GL.Clear(GL::GL_COLOR_BUFFER_BIT | GL::GL_DEPTH_BUFFER_BIT)
				GL.PushMatrix
			
				GL.Rotate($angle, $dx, $dy, $dz)
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
				render
			end
		end
		
		wnd.connect(:ON_KEYDOWN) do |sender, data|
			if data[:key] == XYKey::VK_ESCAPE
				app.exit
			elsif data[:key] == XYKey::VK_LEFT
				$dx -= 0.3
				$angle -= 10
			elsif data[:key] == XYKey::VK_UP
				$dy += 0.4
				$angle -= 10
			elsif data[:key] == XYKey::VK_DOWN
				$dz -= 0.3
				$angle += 10
			elsif data[:key] == XYKey::VK_RIGHT
				$dx += 0.3
				$angle += 10
			elsif data[:key] == XYKey::VK_F1
				XYMessageBox.show("Help", "Press Direction keys to rotate the box!")
			end
			wnd.content[0].call(:ON_PAINT, nil, nil)
		end
		
	end.show
end.mainloop