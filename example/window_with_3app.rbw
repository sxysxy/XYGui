require 'XYGui/xy_app.rb'
require 'XYGui/xy_mainwindow.rb'

Thread.start do
	XYApp.new("Slave1") do |app|
		XYMainWindow.new(app, nil, {:x => 400, :title => 'slave 1'}).show
	end.mainloop
end

Thread.start do
	XYApp.new("Slave2") do |app|
		XYMainWindow.new(app, nil, {:y => 400, :title => 'slave 2'}).show
	end.mainloop
end

XYApp.new("Main") do |app|
	XYMainWindow.new(app, nil, {:title => 'master'}).show
end.mainloop