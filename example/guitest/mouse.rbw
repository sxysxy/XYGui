require 'XYGuiCore'

app = XYApp.new("testmouse")
wnd = XYMainWindow.new(app, nil, {:title => 'Mouse', :width => 600, :height => 400})
stbar = XYStatusBar.new(app, wnd, {:text => "move mouse on the window"})
flag = false
wnd.connect(:ON_MOUSEMOVE) do |sender, data|
	text = sprintf("Mouse Position: %d %d", data[:x], data[:y])
	if data[:key] == XYKey::VK_NONE
		flag = false
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
	if flag
		wnd.painter.paint do 
			setPen XYPen.new(rand(256), rand(256), rand(256))
			lineTo(data[:x], data[:y])
		end
	else
		wnd.painter.paint do 
			setPen XYPen.new(rand(256), rand(256), rand(256))
			line(data[:x], data[:y], data[:x], data[:y])
		end
	end
	flag = true
end
wnd.connect(:ON_MOUSEDOWN) do |sender, data|
	text = "Mouse Pressed: "
	case data[:key]
		when XYKey::VK_LBUTTON
			text += "Left Button"
		when XYKey::VK_RBUTTON
			text += "Right Button"
		when XYKey::VK_MBUTTON
			text += "Middle Button"
		when XYKey::VK_XBUTTON1
			text += "XButton#1"
		when XYKey::VK_XBUTTON2
			text += "XButton#2"
		else
			return
	end
	text += sprintf(". At %d %d", data[:x], data[:y])
	stbar.text = text
end
wnd.connect(:ON_SIZE) do |sender, data|
	stbar.width = data[:width];
	stbar.repos(0, wnd.clientHeight - stbar.height)
end
mos = XYMenu.new "mouse"
mos.addItem (XYMenuItem.new("clear") do 
	wnd.painter.paint do
		setBrush XYBrush.new(255,255,255)
		rect 0, 0, wnd.clientWidth, wnd.clientHeight
	end
end)
HELP_TEXT = "Test Mouse \r\n" + 
			"Draw beautiful thread while pressing + moving your mouse!~ \r\n\r\n" + 
			"鼠标的测试 \r\n" + 
			"按下鼠标并移动， 画出美丽的线条"
mos.addItem (XYMenuItem.new("mouse") do
	XYMainWindow.new(app, nil, {:title => "Mouse"}) do |w|
		w.disconnect(:ON_DESTROY)
		XYTextView.new(app, w, {:text => HELP_TEXT.encode('gbk', 'utf-8'), :width => w.clientWidth, 
									:height => w.clientHeight})
	end.show
end)

mos.addSeper
mos.addItem XYMenuItem.new("quit") {app.exit}
mm = XYMenu.new
mm.addSubMenu(mos)
wnd.menu = mm
wnd.show
app.mainloop
