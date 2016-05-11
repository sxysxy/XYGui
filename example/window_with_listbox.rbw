require 'XYGuiCore'

XYApp.new("listboxtest") do |app|
	XYMainWindow.new(app, nil, {:width => 400, :height => 400, :title => "show listbox"}) do |wnd|
		stbar = XYStatusBar.new(app, wnd, {:text => 'try selecting the items'})
		listbox = XYListBox.new(app, wnd, {:x => 0, :y => 0, :width => 200, :height => 300, :multiple => true}) do |lb|
			lb.addItem("Item0")
			lb.addItem("Item1")
			lb.addItem("Item2")
			lb.addItem("Item3")
			lb.addItem("Item4")
			lb.addItem("Item5")
		end
		del = XYPushButton.new(app, wnd, {:text => 'delete'})
		ins = XYPushButton.new(app, wnd, {:text => 'insert'})
		wnd.connect(:ON_SIZE) do |sender, data|
			stbar.repos(0, data[:height] - stbar.height)
			listbox.resize(wnd.clientWidth - 100, wnd.clientHeight - stbar.height - 20)
			del.repos(listbox.width, 0)
			ins.repos(listbox.width, 50)
			del.resize(100, 40)
			ins.resize(100, 40)
		end
		listbox.connect(:ON_COMMAND) do
			s = listbox.selects
			stbar.text = "You've selected item #{s.to_s}"
		end
		del.connect(:ON_COMMAND) do 
			
		end
	end.show
end.mainloop