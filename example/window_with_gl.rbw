require 'XYGuiCore'
require 'XYGuiGL'

XYApp.new("xyglapp") do |app|
	XYMainWindow.new(app, nil, {:width => 600, :height => 600, :title => "Hello, GL!"}) do |wnd|
	
		wnd.set do
			connect(:ON_SIZE) do |sender, data|
				wnd.content[0].resize(data[:width], data[:height])
			end
		end
		
		XYGLLabel.new(app, wnd, {:width => 600, :height => 600, :x => 0, :y => 0}) do |glb|
			glb.connect(:ON_PAINT) do |sender, data|
				GL.ClearColor(1.0, 1.0, 1.0, 0.0)
				GL.Clear(GL::GL_COLOR_BUFFER_BIT)
				GL.PushMatrix
				GL.Translate(-0.03, -0.2, 0.0)
				GL.Color(0.0, 1.0, 0.0)
				GL.Begin(GL::TRIANGLES)
					GL.Vertex(0.0, 0.9)
					GL.Vertex(0.9, -0.5)
					GL.Vertex(-0.9, -0.5)
				GL.End
				GL.PopMatrix
			end
		end	
	end.show
end.mainloop