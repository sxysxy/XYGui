require 'XYGui/xy_app.rb'
require 'XYGui/xy_mainwindow.rb'
require 'XYGui/xy_progressbar.rb'
require 'XYGui/xy_vertical_layout.rb'
require 'XYGui/xy_textedit.rb'
require 'XYGui/xy_pushbutton.rb'

XYApp.new("pb") do |app| 
	XYMainWindow.new(app, nil, {:title => "ProgressBar", :layout => XYVerticalLayout, :height => 134}) do |wnd|
		XYProgressBar.new(app, wnd).value = 2333
		XYTextEdit.new(app, wnd, {:height => 24})
		XYPushButton.new(app, wnd, {:text => "set value"}).set do
			connect(:ON_COMMAND) {|sender, data| wnd.content[0].setValue(wnd.content[1].text.to_i)} 
		end
	end.show
end.mainloop
