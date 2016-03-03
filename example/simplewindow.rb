require 'XYGui'
require 'XYGui/xy_app.rb'
require 'XYGui/xy_mainwindow.rb'
require 'XYGui/xy_pushbutton.rb'
require 'XYGui/xy_vertical_layout.rb'

include XYGui
app = XYApp.new("asimplewindow")
wnd = XYMainWindow.new(app)
wnd.layout = XYVerticalLayout.new(wnd)
wnd.create
wnd.show
button1 = XYPushButton.new(app, wnd)
button1.show
button2 = XYPushButton.new(app, wnd, {:x => 100})
button2.show
app.mainloop
