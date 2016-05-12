require 'XYGuiCore'
require 'XYGuiGL'

XYApp.new("xyglapp") do |app|
	XYMainWindow.new(app, nil, {:width => 600, :height => 600, :title => "Hello, GL!", :fixed => true}) do |wnd|	
		XYGLLabel.new(app, wnd, {:width => 600, :height => 600, :x => 0, :y => 0}) do |glb|
			glb.connect(:ON_PAINT) do |sender, data|
				GL.ClearColor(1.0, 1.0, 1.0, 0.0)
				GL.Clear(GL::GL_COLOR_BUFFER_BIT | GL::GL_DEPTH_BUFFER_BIT)
				GL.PushMatrix
				GL.Translate(-0.03, -0.2, 0.0)
				GL.Color(0.0, 1.0, 0.0)
				GL.Begin(GL::TRIANGLES)
					GL.Vertex(0.0, 0.9)
					GL.Vertex(0.9, -0.5)
					GL.Vertex(-0.9, -0.5)
				GL.End
				GL.PopMatrix
				glb.render
			end
		end	
		wnd.connect(:ON_KEYDOWN) do |sender, data|
			if data[:key] == XYKey::VK_ESC
				app.exit
			end
		end
	end.show
end.mainloop