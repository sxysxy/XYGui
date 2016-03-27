require 'XYGui/xy_app.rb'
require 'XYGui/xy_mainwindow.rb'
require 'XYGui/xy_progressbar.rb'
require 'XYGui/xy_vertical_layout.rb'

XYApp.new("pb") do |app| 
	XYMainWindow.new(app, nil, {:title => "ProgressBar", :layout => XYVerticalLayout}) do |wnd|
		XYProgressBar.new(app, wnd).value = 2333
	end.show
end.mainloop

#equals this one-line code
#XYApp.new("pb"){|app| XYMainWindow.new(app,nil,{:title=>"ProgressBar"}){|wnd| XYProgressBar.new(app,wnd).value=2333}.show}.mainloop