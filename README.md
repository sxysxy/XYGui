# XYGui

A set of GUI tools based on Win32API, so Please Use **32-bit** ruby interpreter to run it. This is also my first ruby gem

## you can use XYGui to create a simple gui application like this:
```ruby
require 'XYGui/xy_app.rb'
require 'XYGui/xy_mainwindow.rb'

app = XYApp.new("simple")
wnd = XYMainWindow.new(app)
app.mainloop   #Just so easy
```
