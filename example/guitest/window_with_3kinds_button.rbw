require 'XYGuiCore'

XYApp.new("3Buttons") do |app|
	XYMainWindow.new(app, nil, {:title => "3 buttons", :width => 400, :height => 300, :layout => XYVerticalLayout}) do |wnd|
		XYPushButton.new(app, wnd)
		XYRadioButton.new(app, wnd)
		XYCheckBox.new(app, wnd)
	end.show
end.mainloop