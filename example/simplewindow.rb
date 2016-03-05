require 'XYGui'
require 'XYGui/winapi_base.rb'
require 'XYGui/xy_app.rb'
require 'XYGui/xy_mainwindow.rb'
require 'XYGui/xy_pushbutton.rb'
require 'XYGui/xy_vertical_layout.rb'
require 'XYGui/xy_textedit.rb'

app = XYApp.new("asimplewindow")
wnd = XYMainWindow.new(app, nil, {:layout => XYVerticalLayout, :height => 320, :width => 400})
editor = XYTextEdit.new(app, wnd, {:text => "Write something here"})
button1 = XYPushButton.new(app, wnd, {:title => 'Clear'})
button1.connect(:ON_COMMAND) {|a,b| editor.text=""}
button2 = XYPushButton.new(app, wnd, {:title => 'Quit'})
button2.connect(:ON_COMMAND) {|a,b| app.exit}

wd2 = XYMainWindow.new(app, nil)
app.mainloop
