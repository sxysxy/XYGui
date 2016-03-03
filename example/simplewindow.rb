require 'XYGui'
require 'XYGui/xy_app.rb'
require 'XYGui/xy_mainwindow.rb'
require 'XYGui/xy_pushbutton.rb'

include XYGui

app = XYApp.new("asimplewindow")
wnd = XYMainWindow.new(app)
wnd.create
wnd.show
button = XYPushButton.new(app, wnd)
button.show
app.mainloop
