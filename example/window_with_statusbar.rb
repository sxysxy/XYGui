require 'XYGui/xy_app.rb'
require 'XYGui/xy_mainwindow.rb'
require 'XYGui/xy_statusbar.rb'
require 'XYGui/xy_vertical_layout.rb'
require 'XYGui/xy_textedit.rb'
require 'XYGui/xy_pushbutton.rb'

XYApp.new("stsub") do |app|
	XYMainWindow.new(app, nil, {:layout => XYVerticalLayout}) do |wnd|
		XYStatusBar.new(app, wnd)
		XYTextEdit.new(app, wnd, {:height => 30})
		XYPushButton.new(app, wnd, {:title => "set status bar"}).set do
			connect(:ON_COMMAND) do |sender, data|
				wnd.content[0].setText(wnd.content[1].text) #content[0] is status bar, connect[1] is text editor
			end
		end
	end.show
end.mainloop