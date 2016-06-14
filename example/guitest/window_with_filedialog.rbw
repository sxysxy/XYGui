require 'XYGuiCore'

XYApp.new("fff") do |app|
	XYMainWindow.new(app, nil, {:title => 'file dialog test', :layout => XYVerticalLayout}) do |wnd|
		XYPushButton.new(app, wnd, {:text => "Show Open File Dialog"}).set do
			connect(:ON_COMMAND) do |sender, data|
				f = XYFileDialog.show(wnd, {:multiple => true, :title => "Open a file to play", :okcreate => true, 
						:filter => "All Files(*.*)\0*.*\0Ruby File(*.rb)\0*.rb\0RubyW File(*.rbw)\0*.rbw\0Text File(*.txt)\0*.txt\0\0"}) #note, this format will be replaced soon
				XYMessageBox.show("Tip", "You have chosen #{f}")
			end
		end
		XYPushButton.new(app, wnd, {:text => "Show Open Save Dialog"}).set do
			connect(:ON_COMMAND) do |sender, data|
				f = XYFileDialog.show(wnd, {:save => true, :title => "Save a file to play",
					:filter => "All Files(*.*)\0*.*\0Ruby File(*.rb)\0*.rb\0RubyW File(*.rbw)\0*.rbw\0Text File(*.txt)\0*.txt\0\0"})
				XYMessageBox.show("Tip", "You have chosen #{f}")
			end
		end
	end.show
end.mainloop
