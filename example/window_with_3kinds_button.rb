require 'XYGui/xy_pushbutton.rb'
require 'XYGui/xy_radiobutton.rb'
require 'XYGui/xy_checkbox.rb'
require 'XYGui/xy_app.rb'
require 'XYGui/xy_mainwindow.rb'
require 'XYGui/xy_vertical_layout.rb'

XYApp.new("3Buttons") do |app|
	XYMainWindow.new(app, nil, {:title => "3 buttons", :width => 400, :height => 300, :layout => XYVerticalLayout}) do |wnd|
		XYPushButton.new(app, wnd)
		XYRadioButton.new(app, wnd)
		XYCheckBox.new(app, wnd)
	end.show
end.mainloop