require 'XYGuiCore'

XYApp.new("fff") do |app|
	XYMainWindow.new(app, nil, {:title => 'file dialog test'}) do |wnd|
		XYPushButton.new(app, wnd, {:text => "Show File Dialog", :width => 200}).set do
			connect(:ON_COMMAND) do |sender, data|
				XYFileDialog.show
			end
		end
	end.show
end.mainloop