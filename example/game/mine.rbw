require 'XYGuiCore'

class Mine
	attr_reader :button
	attr_accessor :status
	attr_accessor :number
	attr_accessor :ismine
	
	def initialize(p)
		@button = XYPushButton.new(p.app, p)
		clear
	end
	
	def mkcall(&handler)
		@button.connect(:ON_MOUSEDOWN) do |sender, data|
			case data[:key]
				when XYKey::VK_LBUTTON then
					handler.call :left
				when XYKey::VK_RBUTTON then
					handler.call :right
				when XYKey::VK_MBUTTON then
					handler.call :middle
			end
		end
	end
	
	def clear
		@status = :normal
		@ismine = false
		@number = 0
		@button.text = ""
		@button.enable
	end
	
	def show
		if @status == :discovered
			if @ismine
				@button.text = "X"
			else
				@button.text = @number.to_s
			end
		elsif @status == :notsure
			@button.text = "?"
		elsif @status == :sure
			@button.text = "*"
		elsif @status == :normal
			@button.text = ""
		end
		@button.update
	end
	
	def disable
		#@button.disable   #Grey isn't good-looking
 		@status = :disabled
	end
end

class Game
	
	def main
		@app = XYApp.new("mines!mines!")
		@win = XYMainWindow.new(@app, nil, {:title => 'Mines', :width => 325, :height => 420, :x => 400, :fixed => true})
		@mines = Array.new(10) {Array.new(10) {Mine.new(@win)}}
		@booms = Array.new(10)
		@stbar = XYStatusBar.new(@app, @win, {:width => @win.clientWidth})
		@time = XYTextView.new(@app, @win, {:x => 190, :y => 22, :text => '00:00:00'})
		
		replace
		clear
		menu
		
		reset
		@win.show
		@app.mainloop
	end
	
	def reset
		clear
		mkmine
		@win.focus
		@gameover = false
		@stbar.text = "Happy Playing"
		@begin = false
		@sec = 0
		@sures = 0
		
		@time.text = "00:00:00"
		@timer.kill if @timer
		@timer = Thread.new do
			while !@begin
				sleep(0.04)
			end
			loop do
				sleep(1)
				@sec += 1
				@time.request do |t|
					t.text = sprintf("%02d:%02d:%02d", Integer(@sec/3600), Integer(@sec/60)%60, @sec%60)
				end
			end
		end
	end
	
	def showhelp
		h = XYMainWindow.new(@app, nil, {:title => 'Mines Help', :x => @win.x + 60, :fixed => true, :y => @win.y + 70})
		h.disconnect(:ON_DESTROY)
		t = XYTextView.new(@app, h, {:width => h.clientWidth, :height => h.clientHeight, :x => 0, :y => 0})
		t.text = "                   Help     \r\n" + 
				"  Mouse Left to open a grid \r\n" + 
				"  Mouse Right to assert a grid to be a mine(This grid will be marked '*') \r\n" +
				"  Mouse Middle to show you are not sure about this grid(marked '?') \r\n" +
				"  The number on the grid shows how many mines are there near it(at most 8 grids near it) \r\n" +
				"  If you mark all the 10 mine grids with '*', you will win the game \r\n\r\n\r\n" + 
				"                    Happy playing"
		h.show
	end		
	
	def menu
		mm = XYMenu.new
		gm = XYMenu.new("Game")
		gm.addItem(XYMenuItem.new("New Game") {reset})
		gm.addItem(XYMenuItem.new("Quit") {@app.exit})
		abt = XYMenu.new("About")
		abt.addItem(XYMenuItem.new("About Mine") {XYMessageBox.show("About", "Written by sxysxy, XYGui example")})
		abt.addItem(XYMenuItem.new("Help") {showhelp})
		
		mm.addSubMenu(gm)
		mm.addSubMenu(abt)
		@win.menu = mm
	end
	
	def replace
		x = 10
		y = 50
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
				@mines[i][j].show
			end
		end
	end
	
	def showAll
		(0..9).each do |i|
			(0..9).each do |j|
				@mines[i][j].status = :discovered
				@mines[i][j].show
			end
		end
	end
	
	def over
		@stbar.text = "Gameovered, please retry (Menu Game -> New Game)"
		@timer.kill
	end
	
	def checkGamewin
		flag = true
		@booms.each do |b|
			i = b[0]
			j = b[1]
			if @mines[i][j].status != :sure
				flag = false
				break
			end
		end
		if flag && @sures == 10
			@stbar.text = "You Win!"
			@timer.kill
		end
	end
	
	DI = [-1, 1, 0, 0]
	DJ = [0, 0, 1, -1]
	def press(i, j, flag)
		@begin = true
		if @gameover
			over
			return
		end
		return if @mines[i][j].status == :discovered
		if flag == :left
			if @mines[i][j].ismine
				@gameover = true
				showAll
				over
			else
				@mines[i][j].status = :discovered
				@mines[i][j].show
				@mines[i][j].disable
				if @mines[i][j].number == 0
					q = Queue.new
					vis = Array.new(10) {Array.new(10, false)}
					q.push i
					q.push j
					vis[i][j] = true
					while q.size != 0
						ci = q.pop
						cj = q.pop
						(0..3).each do |k|
							ni = ci+DI[k]
							nj = cj+DJ[k]
							next if ni < 0 || nj < 0 || ni > 9 || nj > 9 || @mines[ni][nj].status == :discovered || @mines[ni][nj].number > 0
							if !vis[ni][nj]
								q.push ni
								q.push nj
								vis[ni][nj] = true
								@mines[ni][nj].status = :discovered
								@mines[ni][nj].show
								@mines[ni][nj].disable
							end
						end
					end
					
				end
			end
		elsif flag == :middle
			if @mines[i][j].status != :notsure
				@mines[i][j].status = :notsure
				@mines[i][j].show
			else
				@mines[i][j].status = :normal
				@mines[i][j].show
			end
		elsif flag == :right
			if @mines[i][j].status != :sure
				@mines[i][j].status = :sure
				@mines[i][j].show
				@sures += 1
				checkGamewin
			else
				@sures -= 1
				@mines[i][j].status = :normal
				@mines[i][j].show
			end
		end
	end
	
	DX = [-1, -1, -1, 0,  0,  1,  1,  1]
	DY = [0,   1, -1, 1, -1,  0,  1, -1]
	def mkmine
		@booms.fill(nil)
		c = Hash.new
		(0..9).each do |n|
			i = rand(10)
			j = rand(10)
			while c[i*10+j] 
				i = rand(10)
				j = rand(10)
			end
			c[i*10+j] = 1
			@booms[n] = i, j
			@mines[i][j].ismine = true
		end
		@booms.each do |boom|
			(0...8).each do |i|
				x = boom[0] + DX[i]
				y = boom[1] + DY[i]
				next if x > 9 || y > 9 || x < 0 || y < 0
				@mines[x][y].number += 1
			end
		end
		
	end
	
end

Game.new.main