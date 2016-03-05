require 'XYGui/xy_app.rb'
require 'XYGui/xy_mainwindow.rb'

app = XYApp.new("simple")
wnd = XYMainWindow.new(app) 
wnd.show
app.mainloop   #Just so easy