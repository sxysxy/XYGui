require 'XYGuiCore'

app = XYApp.new("testmouse")
wnd = XYMainWindow.new(app, nil, {:title => 'Mouse', :width => 600, :height => 400})
stbar = XYStatusBar.new(app, wnd, {:text => "move mouse on the window"})
wnd.connect(:ON_MOUSEMOVE) do |sender, data|
	text = sprintf("Mouse Position: %d %d", data[:x], data[:y])
	if data[:key] == XYKey::VK_NONE
		text += "  No Mouse Key Pressed"
	elsif data[:key] == XYKey::VK_LBUTTON
		text += "  Left Button Pressed while moving"
	elsif data[:key] == XYKey::VK_RBUTTON
		text += "  Right Button Pressed while moving"
	elsif data[:key] == XYKey::VK_XBUTTON1
		text += "  XButton#1 Pressed while moving"
	elsif data[:key] == XYKey::VK_XBUTTON2
		text += "  XButton#2 Pressed while moving"
	elsif data[:key] == XYKey::VK_MBUTTON
		text += "  Middle Button Pressed while moving"
	end
	stbar.text = text
end
wnd.connect(:ON_SIZE) do |sender, data|
	stbar.width = data[:width];
	stbar.repos(0, wnd.clientHeight - stbar.height)
end
wnd.show
app.mainloop
