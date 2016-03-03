require 'XYGui/xy_app.rb'
require 'XYGui/xy_mainwindow.rb'

app = XYApp.new("asimplewindow")
wnd = XYMainWindow.new(app)
wnd.create
wnd.show
app.mainloop
