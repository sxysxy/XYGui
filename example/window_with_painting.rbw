require 'XYGuiCore'

XYApp.new("painting") do |app|
	XYMainWindow.new(app, nil, {:title => "Let's Paint!", :width => 500, :height => 500}) do |wnd|
		wnd.connect(:ON_PAINT) do |sender, data|
			wnd.painter.line(0, wnd.height, wnd.width/2, wnd.height/2)
			wnd.painter.lineTo(wnd.width, wnd.height)   #The triangle 
			
			wnd.painter.ellipse(wnd.width/2, wnd.height/4, wnd.width, wnd.height/2)  #The ellipse
			wnd.painter.circle(wnd.width/2, wnd.height/4, [wnd.height/2, wnd.width].min)  #The circle
			
			wnd.painter.line(wnd.width/4, wnd.height*3/4, wnd.width*3/4, wnd.height*3/4)
			wnd.painter.lineTo(wnd.width*3/4, wnd.height)
			wnd.painter.line(wnd.width/4, wnd.height*3/4, wnd.width/4, wnd.height)      # The rect
		end
	end.show
end.mainloop