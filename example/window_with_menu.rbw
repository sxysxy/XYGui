require 'XYGui/xy_app.rb'
require 'XYGui/xy_mainwindow.rb'
require 'XYGui/xy_menu.rb'

app = XYApp.new("hh")
wnd = XYMainWindow.new(app, nil)
wnd.show
m = XYMenuBar.new(wnd)
m.setText "我是菜单".encode("gbk", "utf-8")
m.show
app.mainloop