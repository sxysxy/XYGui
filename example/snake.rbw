require 'XYGuiCore'

class SnakeNode
	attr_accessor :dir
	attr_accessor :nex
	attr_accessor :x
	attr_accessor :y
	def initialize(x, y, dir, nex = nil)
		@x = x
		@y = y
		@dir = dir
		@nex = nex
	end
end


$score = 0
$foodx = 0
$foody = 0
$dir = :right
$map = Array.new(20) {Array.new(20, true)}
def newfood
	$foodx = rand(20)
	$foody = rand(20)
	newfood if !$map[$foodx][$foody] 
end
def reset(scene)
	$eater = SnakeNode.new(10, 10, :right)
	$eater.nex = SnakeNode.new(9, 10, :right)
	$eater.nex.nex = SnakeNode.new(8, 10, :right)
	$map = nil
	$map = Array.new(20) {Array.new(20, true)}
	$map[10][10] = false
	$map[9][10] = false
	$map[8][10] = false
	newfood
	scene.update
end


XYApp.new("snake_23333") do |snake|
	XYMainWindow.new(snake, nil, {:title => 'Snake', :fixed => true, :width => 408, :height => 492, :x => 400}) do |win|
		view = XYLabel.new(snake, win, {:fixed => true, :width => win.clientWidth, :height => 400, :x => 0, :y => 0}) 
		restart = XYPushButton.new(snake, win, {:text => "Restart!", :x => 0, :y => view.height, :width => win.clientWidth})
		stbar = XYStatusBar.new(snake, win, {:text => "score: 0"})
		
		view.focus
		view.connect(:ON_PAINT) do |sender, data|
			view.painter.paint do				
				setBrush(XYBrush.new(255, 255, 255))
				fillRect(0, 0, 400, 400)				#Clear the background
				
				setBrush(XYBrush.new(100, 0, 255))      #Draw the food
				fillRect($foodx*20, $foody*20, 20, 20)
						
				->{
					cur = $eater
					setBrush(XYBrush.new(255, 0, 0))
					fillRect(cur.x*20, cur.y*20, 20, 20)
					cur = cur.nex
					setBrush(XYBrush.new(10, 255, 60))
					while cur
						fillRect(cur.x*20, cur.y*20, 20, 20)
						cur = cur.nex
					end
				}.call	#Draw the snake
				
			end
		end
		
		view.connect(:ON_KEYDOWN) do |sender, data|
			if data[:key] == XYKey::VK_UP
				
			elsif data[:key] == XYKey::VK_DOWN
			
			elsif data[:key] == XYKey::VK_RIGHT
			
			elsif data[:key] == XYKey::VK_LEFT
			
			elsif data[:key] == XYKey::VK_F2
				reset(view)
				view.update
			elsif data[:key] == XYKey::VK_ESC
				snake.exit
			end
		end
		
		restart.connect(:ON_COMMAND) do |sender, data|
			reset(view)
			view.focus
		end
		reset(view)
	end.show
end.mainloop