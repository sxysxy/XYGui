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
		
	end
	
	def clear
		@status = :normal
		@ismine = false
		@number = 0
		@button.text = ""
	end
end

class Grids
	attr_accessor :top, :left
	attr_accessor :gridw, :gridh
	
	def initialize(x, y, w, h)
		@top = y
		@left = x
		@gridw = w
		@gridh = h
	end
	
	def pos2grid(x, y)
		return (x-@left/@gridw),(y-@top/@gridh)
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
		keyp
		@win.show
		@app.mainloop
	end
	
	def reset
		clear
		mkmine
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
	
	def keyp
		@win.connect(:ON_KEYDOWN) do |sender, data|
			case data[:key]
				when XYKey::VK_ESC then
					@app.exit
			end
		end
	end
	
	def replace
		x = 10
		y = 80
		@grid = Grids.new(10, 80, 30, 30)
		(0..9).each do |i|
			(0..9).each do |j|
				@mines[i][j].button.repos(x, y)
				@mines[i][j].button.resize(30, 30)
				@mines[i][j].mkcall do |arg|
					press(i, j, arg)
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
	
	def press(x, y, flag = :left)
		if flag == :left
			XYMessageBox.show("tip", "l")
		elsif flag == :middle
			XYMessageBox.show("tip", "m")
		elsif flag == :right
			XYMessageBox.show("tip", "r")
		end
	end
	
	def mkmine
	
	end
end

Game.new.main