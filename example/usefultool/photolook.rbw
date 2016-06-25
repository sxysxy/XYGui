require 'XYGuiCore'
require 'XYGuiImg'
FILE_PATTERNS = [["PNG Files(*.png)", "*.png"], ["BMP Files(*.bmp)", "*.bmp"], ["JPEG Files(*.jpg)", "*.jpg"], ["GIF Files(*.gif)", "*.gif"], ["All","*.*"]]
XYApp.new("ptlk") do |app|
	wins = 0
	newwin =->(img) do
		name = img ? img.filename: "photolook"     
		win = XYMainWindow.new(app, nil, {:title => name, :x => rand(600), :y => rand(480), :acfiles => true, :fixed => true})
		win.connect(:ON_DESTROY) do |sender, data|
			wins -= 1
			app.exit if wins == 0
		end
		setimg =-> (mmm) do
			win.connect(:ON_PAINT) do |sender, data|
				win.showImage mmm
			end
			win.width = mmm.getOriginWidth + 28
			win.height = mmm.getOriginHeight + 38
			win.setTitle mmm.filename
		end
		setimg[img] if img	
		win.connect(:ON_DROPFILES) do |sender, data|
			fn = data[:files][0]
			mg = XYImage.new(fn)
			setimg[mg]
			if data[:files].size > 1
				(1...data[:files].size).each do |i|
					newwin[XYImage.new(data[:files][i])]
				end
			end
		end
		mm = XYMenu.new.instance_eval do
			addSubMenu(XYMenu.new("File").instance_eval do
				addItem(XYMenuItem.new("Open") {win.call(:ON_DROPFILES, self, {:files => [XYFileDialog.show(win, {:filter => FILE_PATTERNS})]})})
				addItem(XYMenuItem.new("Close") {win.destroy})
				addSeper
				addItem(XYMenuItem.new("New") {newwin[nil]})
				self
			end)
			addSubMenu(XYMenu.new("About").instance_eval do
				addItem(XYMenuItem.new("About") {XYMessageBox.show("About", "Powered by XYGui")})
				addSeper
				addItem(XYMenuItem.new("Help") {XYMessageBox.show("Help", "To view your pictures, you can click 'open' in menu,
																	also you can drop files into the window")})
				self
			end)
			self
		end
		win.menu = mm
		win.show
		wins += 1
	end
	newwin[nil]
end.mainloop