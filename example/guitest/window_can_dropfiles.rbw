require 'XYGuiCore'

XYApp.new("dpf") do |app|
	XYMainWindow.new(app, nil, {:title => 'Drop files into the window!~', :width => 600, :acfiles => true}) do |win|
		tv = XYTextView.new(app, win, {:width => win.clientWidth, :height => win.clientHeight, :x => 0, :y => 0, :text => ''})
		tv.setText "                       DROP FILES INTO THE WINDOW    \r\n" + 
					"   This exciting function were made on 2016.06.25.Then you can let your user drop files into the window."
		win.connect(:ON_DROPFILES) do |sender, data|
			tv.setText data[:files].join(' ')
		end
	end.show
end.mainloop