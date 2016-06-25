require 'XYGuiCore'
require 'XYGuiImg'

XYApp.new("pic") do |app|
	XYMainWindow.new(app, nil, {:title => 'picture', :width => 345, :height => 400}) do |win|
		img = XYImage.new("window_with_picture.png")
		win.width = img.width + 28
		win.height = img.height + 38
		win.connect(:ON_PAINT) do |sender, data|
			win.showImage(img)
		end
	end.show
end.mainloop