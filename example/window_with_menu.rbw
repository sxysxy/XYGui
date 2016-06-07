require 'XYGuiCore'

app = XYApp.new("tmenu")
wnd = XYMainWindow.new(app)

f = XYMenu.new("File")
f.addItem(XYMenuItem.new("open") {XYMessageBox.show("Tip", "Menu 'open' clicked!")})
f.addItem("save")
e = XYMenu.new("Edit") 
e.addItem("copy")
e.addItem("cut")
e.addItem("plaste")
a = XYMenu.new("About")
ab = XYMenu.new("About")
ab.addItem(XYMenuItem.new("about") {XYMessageBox.show("Tip", "You see, multi level menu")})
a.addSubMenu(ab)
mainm = XYMenu.new
mainm.addSubMenu(f)
mainm.addSubMenu(e)
mainm.addSubMenu(a)

wnd.setMenu mainm

wnd.show
app.mainloop