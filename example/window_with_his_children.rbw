require 'XYGui/xy_app.rb'
require 'XYGui/xy_mainwindow.rb'
require 'XYGui/xy_childwindow.rb'

XYApp.new("children") do |app|
	XYMainWindow.new(app, nil, {:title => "Hello world!", :height => 500, :width => 500}) do |mainwnd|
		XYChildWindow.new(app, mainwnd, {:title => 'Elder Brother'})
		XYChildWindow.new(app, mainwnd, {:title => 'Younger Brother', :x => 30, :y => 50})
	end.show
end.mainloop
