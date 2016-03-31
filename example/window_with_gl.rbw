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
			
		end	

	end.show
end.mainloop