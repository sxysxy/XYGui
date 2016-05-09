require 'XYGui/xy_app.rb'
require 'XYGui/xy_mainwindow.rb'
require 'XYGui/xy_combobox.rb'

XYApp.new("cb") do |app| 
	XYMainWindow.new(app, nil, {:title => "ComboBox"}) do |wnd|
		XYComboBox.new(app, wnd)
	end.show
end.mainloop
