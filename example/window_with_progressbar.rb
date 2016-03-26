require 'XYGui/xy_app.rb'
require 'XYGui/xy_mainwindow.rb'
require 'XYGui/xy_progressbar.rb'

app = XYApp.new("pb")
wnd = XYMainWindow.new(app, nil, {:title => "233333"})
XYProgressBar.new(app, wnd).value = 2333
wnd.show
app.mainloop