require 'XYGui/xy_app.rb'
require 'XYGui/xy_mainwindow.rb'
require 'XYGui/xy_menu.rb'

app = XYApp.new("hh")
wnd = XYMainWindow.new(app, nil)
wnd.show
m = XYMenu.new
puts m.handle
app.mainloop