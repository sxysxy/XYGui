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
mainm = XYMenu.new
mainm.addSubMenu(f)
mainm.addSubMenu(e)
b = XYMenuBar.new(mainm)
wnd.setMenu b

wnd.show
app.mainloop