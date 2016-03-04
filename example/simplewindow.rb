require 'XYGui'
require 'XYGui/xy_app.rb'
require 'XYGui/xy_mainwindow.rb'
require 'XYGui/xy_pushbutton.rb'
require 'XYGui/xy_vertical_layout.rb'

app = XYApp.new("asimplewindow")
wnd = XYMainWindow.new(app, nil, {:layout => XYVerticalLayout, :height => 300, :width => 400})
button1 = XYPushButton.new(app, wnd)
button2 = XYPushButton.new(app, wnd)
app.mainloop
