require 'XYGuiCore'


class Food
	attr_accessor :x, :y
	attr_accessor :ok
	def reset(map)
		@ok = false
		@x = rand(19)
		@y = rand(20)
		if !map[@x][@y]
			reset(map)
		else
			@ok = true
		end
	end
end

class Snake
	
	attr_accessor :x, :y
	attr_accessor :len
	attr_accessor :dir
	def initialize
		@x = Array.new(401)
		@y = Array.new(401)
		@len = 3
	end
	
	def reset
		@x.fill(nil)
		@y.fill(nil)
		@len = 3
	end
end

class Game
	attr_accessor :snake, :food, :score
	attr_accessor :runing
	attr_reader :guard
	attr_reader :newdir
	attr_reader :gameover
	def initialize
		@map = Array.new(20) {Array.new(20, true)}
		initData
	end
	
	def reset
		@map.each {|e| e.fill(true)}
		initData
	end
	
	def initData
		@runing = false
		@snake = Snake.new
		@food = Food.new
		@snake.len = 3
		@snake.x[0] = 10
		@snake.x[1] = 9
		@snake.x[2] = 8
		@snake.y[0] = 10
		@snake.y[1] = 10
		@snake.y[2] = 10
		@newdir = :right

		@map[10][10] = false
		@map[9][10] = false
		@map[8][10] = false
	
		@snake.dir = :right
		@food.reset(@map)
		@score = 0
		@gameover = false
		
		if @guard.is_a?(Thread)
			@guard.kill
		end
		@guard = nil
	end
	
	def over
		@guard.kill if @guard
		@stbar.text = "Gameovered with score #{@score}"
		@runing = false
		XYMessageBox.show("Sorry!", "Gameover!")
		@view.focus
	end
	
	def mproc
		@stbar.text = "score: 0"
		@gameover = false
		@guard = Thread.new do
			loop do
				step
				break if @gameover
				@view.request {|v| v.update}
				sleep(0.15)   # Game Speed can be set here
			end
			@view.request{|v| over}
		end
	end
	
	def step
		if (@snake.dir == :left && @newdir == :right)||(@snake.dir == :right && @newdir == :left)||(@snake.dir == :up && @newdir == :down)||(@snake.dir == :down && @newdir == :up)
			@newdir = @snake.dir
		end
		@snake.dir = @newdir
		(1..@snake.len).to_a.reverse.each do |e|
			@snake.x[e] = @snake.x[e-1]
			@snake.y[e] = @snake.y[e-1]
		end
		if @newdir == :right
			@snake.x[0] += 1 
		elsif @newdir == :up
			@snake.y[0] -= 1 
		elsif @newdir == :left
			@snake.x[0] -= 1 
		elsif @newdir == :down
			@snake.y[0] += 1 
		end
		@map[@snake.x[0]][@snake.y[0]] = false		
		@map[@snake.x[@snake.len-1]][@snake.y[@snake.len-1]] = true		#Modify map tag
	
		@gameover = true if @snake.x[0] < 0 || @snake.y[0] < 0 || @snake.x[0] >= 19 || @snake.y[0] >= 20 
		(1..@snake.len).to_a.reverse.each do |e|
			@gameover = true if @snake.x[0] == @snake.x[e] && @snake.y[0] == @snake.y[e]
		end

		if @snake.x[0] == @food.x && @snake.y[0] == @food.y 
			@score += 10
			@snake.len += 1
			@food.reset(@map)
		end
		
	end
	
	def mkmenu		
		gm = XYMenu.new("Game")
		gm.addItem(XYMenuItem.new("Restart (F2)") {replay;@view.focus})
		gm.addItem(XYMenuItem.new("Exit") {@app.exit})
		abt = XYMenu.new("About")
		abt.addItem(XYMenuItem.new("About Snake") {XYMessageBox.show("About", "Written by sxysxy"); @view.focus})
		mainm = XYMenu.new
		mainm.addSubMenu(gm)
		mainm.addSubMenu(abt)
		@win.setMenu mainm	
	end
	
	def setview
		@view.focus
		@view.connect(:ON_PAINT) do |sender, data|
			if @runing
				food = @food
				snake = @snake
				#------------------ Paint
				@view.painter.paint do
				
					@drawNode ||= ->(x,y){fillRect(x * 20, y * 20, 20, 20)}  
					setBrush(XYBrush.new(255, 255, 255))
					fillRect(0, 0, 420, 400)	#Clear Screen
					
					#Draw snake
					setBrush(XYBrush.new(255, 0, 0))
					@drawNode[snake.x[0], snake.y[0]]
					setBrush(XYBrush.new(0, 255, 0))
					(1...snake.len).each do |e|
						@drawNode[snake.x[e], snake.y[e]]
					end
					
					#Draw food
					setBrush(XYBrush.new(0, 0, 255))
					@drawNode[food.x, food.y]
				end
				#------------------
				@stbar.text = "score: #{@score}"
			end
		end
		
		@view.connect(:ON_KEYDOWN) do |sender, data|
			if data[:key] == XYKey::VK_UP
				@newdir = :up
			elsif data[:key] == XYKey::VK_DOWN
				@newdir = :down 
			elsif data[:key] == XYKey::VK_RIGHT
				@newdir = :right 
			elsif data[:key] == XYKey::VK_LEFT
				@newdir = :left 
			elsif data[:key] == XYKey::VK_F2
				replay
			elsif data[:key] == XYKey::VK_ESC
				@app.exit
			end
		end
	end
	
	def replay
		reset
		@runing = true
		mproc
		@view.focus
	end
	
	
	def setst
		@restart.connect(:ON_COMMAND) do |sender, data|
			replay
		end
	end
	
	def main
		@app = XYApp.new("Snake_Demo") 
		@win = XYMainWindow.new(@app, nil, {:title => 'Snake', :fixed => true, :width => 386, :height => 506, :x => 400}) 
		
		@view = XYLabel.new(@app, @win, {:fixed => true, :width => @win.clientWidth, :height => 400, :x => 0, :y => 0}) 
		@restart = XYPushButton.new(@app, @win, {:text => "Restart!", :x => 0, :y => @view.height, :width => @win.clientWidth})
		@stbar = XYStatusBar.new(@app, @win, {:text => "Happy playing, Press F2 to start"})
		
		mkmenu
		setview
		setst
		
		@win.show
		replay
		@app.mainloop
		#----
	end

end

Game.new.main
