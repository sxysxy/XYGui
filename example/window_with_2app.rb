require 'XYGui/xy_app.rb'
require 'XYGui/xy_mainwindow.rb'

Thread.start do
	XYApp.new("w1") do |app|
		XYMainWindow.new(app, nil, {:x => 400}).show
	end.mainloop
end

XYApp.new("w2") do |app|
	XYMainWindow.new(app).show
end.mainloop