require 'XYGuiCore'

class Mine
	attr_reader :button
	attr_reader :status
	attr_reader :number
	attr_reader :ismine
	
	def initialize(p)
		@button = XYPushButton.new(p.app, p)
		clear
	end
	
	def mkcall(&handler)
		@button.connect(:ON_COMMAND) do |sender, data|
			handler.call
		end
	end
	
	def clear
		@status = :normal
		@ismine = false
		@number = 0
		@button.text = ""
	end
end

class Game
	
	def main
		@app = XYApp.new("mines!mines!")
		@win = XYMainWindow.new(@app, nil, {:title => 'Mines', :width => 325, :height => 439, :x => 400, :fixed => true})
		@mines = Array.new(10) {Array.new(10) {Mine.new(@win)}}
		replace
		clear
		menu
		@win.show
		@app.mainloop
	end
	
	def reset
		clear
	end
	
	def menu
		mm = XYMenu.new
		gm = XYMenu.new("Game")
		gm.addItem(XYMenuItem.new("New Game (F2)") {reset})
		gm.addItem(XYMenuItem.new("Quit (ESC)") {@app.exit})
		abt = XYMenu.new("About")
		abt.addItem(XYMenuItem.new("About Mine") {XYMessageBox.show("About", "Written by sxysxy, XYGui example")})
		
		mm.addSubMenu(gm)
		mm.addSubMenu(abt)
		@win.menu = mm
	end
	
	def replace
		x = 10
		y = 80
		(0..9).each do |i|
			(0..9).each do |j|
				@mines[i][j].button.repos(x, y)
				@mines[i][j].button.resize(30, 30)
				@mines[i][j].mkcall do  
					press(i, j)
				end
				x += 30
			end
			x = 10
			y += 30
		end
	end
	
	def clear
		@score = 0
		(0..9).each do |i|
			(0..9).each do |j|
				@mines[i][j].clear
			end
		end
	end
	
	def press(x, y)
		XYMessageBox.show("mine", "line #{x} col #{y}")
	end
end

Game.new.main