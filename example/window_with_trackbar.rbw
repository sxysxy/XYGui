require 'XYGui/xy_app.rb'
require 'XYGui/xy_mainwindow.rb'
require 'XYGui/xy_trackbar.rb'
require 'XYGui/xy_vertical_layout.rb'

XYApp.new("tb") do |app|
	XYMainWindow.new(app, nil, {:title => "TrackBox", :height => 300, :width => 500, :layout => XYVerticalLayout}) do |wnd|
		XYTrackBar.new(app, wnd)
	end.show
end.mainloop
