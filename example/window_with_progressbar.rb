require 'XYGui/xy_app.rb'
require 'XYGui/xy_mainwindow.rb'
require 'XYGui/xy_progressbar.rb'

XYApp.new("pb") do |app| 
	XYMainWindow.new(app, nil, {:title => "233333"}) do |wnd|
		XYProgressBar.new(app, wnd).value = 2333
	end.show
end.mainloop

#equals this one-line code
#XYApp.new("pb"){|app| XYMainWindow.new(app,nil,{:title=>"2333"}){|wnd| XYProgressBar.new(app,wnd).value=2333}.show}.mainloop