require 'XYGui/xy_app.rb'
require 'XYGui/xy_mainwindow.rb'

app = XYApp.new("simple")
wnd = XYMainWindow.new(app) 
wnd.connect(:ON_DESTROY) {|wparam, lparam| app.exit}
wnd.show
app.mainloop   #Just so easy