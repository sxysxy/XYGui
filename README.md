# XYGui

A set of GUI tools based on Win32API, so Please Use **32-bit** ruby interpreter to run it. This is also my first ruby gem

## you can use XYGui to create a simple gui application like this:
```ruby
require 'XYGui/xy_app.rb'
require 'XYGui/xy_mainwindow.rb'

app = XYApp.new("simple")
wnd = XYMainWindow.new(app)
wnd.show
app.mainloop   #Just so easy
```

##So what's XYGui's advantages?
1. It is ALL written in Ruby, so it's interface is very friendly to ruby
2. Based on win32api, It runs fast
3. Good OOP and FP interface are provided (you see, effective FP)
![](http://i3.piimg.com/8d90ea26799f990d.png)
4. Event System Supported
5. Opengl Supported

##Examples are being made
ChatCube, A Loacl Area Network chatting software (including client, server)
![](http://i3.piimg.com/e19aacc36aca1a54.png)

Calender 
![](http://i3.piimg.com/5fb28465529b6993.png)

Simple Opengl
![](http://i3.piimg.com/e639abd1ea8f1db0.png)
![](http://i4.piimg.com/2de964225c6b09e5.png)

##For more information or join me
Find me by qq 1441157749 (or tel +86 15638234038)