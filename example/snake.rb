require 'XYGuiCore'
require 'XYGuiGL'

XYApp.new("snake_23333") do |snake|
	XYMainWindow.new(snake, nil, {:title => 'Snake', :fixed => true, :width => 400, :height => 470, :x => 400}) do |win|
		view = XYGLLabel.new(snake, win, {:fixed => true, :width => win.clientWidth, :height => 400, :x => 0, :y => 0}) 
		restart = XYPushButton.new(snake, win, {:text => "Restart!", :x => 0, :y => view.height, :width => win.clientWidth})
		
		view.connect(:ON_PAINT) do |sender, data|
			view.painter.paint do
				
			end
		end
	end.show
end.mainloop