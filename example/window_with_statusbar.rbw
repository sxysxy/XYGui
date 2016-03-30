require 'XYGuiCore'

XYApp.new("stsub") do |app|
	XYMainWindow.new(app, nil, {:layout => XYVerticalLayout}) do |wnd|
		XYStatusBar.new(app, wnd)
		XYTextEdit.new(app, wnd, {:height => 30})
		XYPushButton.new(app, wnd, {:text => "set status bar"}).set do
			connect(:ON_COMMAND) do |sender, data|
				wnd.content[0].setText(wnd.content[1].text) #content[0] is status bar, connect[1] is text editor
				wnd.content[1].text = ""
			end
		end
	end.show
end.mainloop