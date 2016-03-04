require 'XYGui'
require 'XYGui/winapi_base.rb'
require 'XYGui/xy_app.rb'
require 'XYGui/xy_mainwindow.rb'
require 'XYGui/xy_pushbutton.rb'
require 'XYGui/xy_vertical_layout.rb'

app = XYApp.new("asimplewindow")
wnd = XYMainWindow.new(app, nil, {:layout => XYVerticalLayout, :height => 300, :width => 400})
button1 = XYPushButton.new(app, wnd, {:title => 'Button1'})
button1.connect(:ON_COMMAND, lambda{WinAPI.call("user32", "MessageBox", 0, "You clicked Button1", "wow", 0)})
button2 = XYPushButton.new(app, wnd, {:title => 'Button2'})
button2.connect(:ON_COMMAND, lambda{WinAPI.call("user32", "MessageBox", 0, "You clicked Button2", "wow", 0)})
app.mainloop
