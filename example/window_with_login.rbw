require 'XYGuiCore'

XYApp.new("logintest") do |app|
	XYMainWindow.new(app, nil, {:fixed => true, :title => 'Login', :width => 300, :height => 160}) do |wnd|
		XYLineEdit.new(app, wnd, {:width => 150, :x => 100})
		XYPasswordLine.new(app, wnd, {:width => 150, :y => 40, :x => 100 })
		XYTextView.new(app, wnd, {:text => 'Username', :y => 5, :x => 30})
		XYTextView.new(app, wnd, {:text => 'Password', :y => 44, :x => 30})
		XYPushButton.new(app, wnd, {:text => 'Quit', :y => 80, :x => 40}).set {connect(:ON_COMMAND) {|*arg| app.exit}}
		XYPushButton.new(app, wnd, {:text => 'Login', :y => 80, :x => 180})
	end.show
end.mainloop