require 'XYGuiCore'

$score = 0
$foodx = 0
$foody = 0
$dir = :right
$oldir = :right
$guard = nil
$foodok = false
def newfood
	$foodx = rand(20)
	$foody = rand(20)
	if !$map[$foodx][$foody] 
		newfood
	else
		$foodok = true
	end
end
def reset(scene)
	$snakeX = Array.new(401)
	$snakeY = Array.new(401)
	$snakeLen = 3
	$snakeX[0] = 10
	$snakeX[1] = 9
	$snakeX[2] = 8
	$snakeY[0] = 10
	$snakeY[1] = 10
	$snakeY[2] = 10
	
	$map = nil
	$map = Array.new(20) {Array.new(20, true)}
	$map[10][10] = false
	$map[9][10] = false
	$map[8][10] = false
	$dir = :right
	$oldir = :right
	$score = 0
	$gameover = false
	$foodok = false
	
	newfood
	scene.update
	
	$guard.kill if $guard
	$guard = nil
	$guard = Thread.new do
		loop do
			goforward(scene)
			scene.request {|s| s.update}
			sleep(0.15)
		end
	end
end
def goforward(scene)
	if ($oldir == :left && $dir == :right)||($oldir == :right && $dir == :left)||($oldir == :up && $dir == :down)||($oldir == :down && $dir == :up)
		$dir = $oldir
	end
	$oldir = $dir
	(1..$snakeLen).to_a.reverse.each do |e|
		$snakeX[e] = $snakeX[e-1]
		$snakeY[e] = $snakeY[e-1]
	end
	if $dir == :right
		$snakeX[0] += 1 
	elsif $dir == :up
		$snakeY[0] -= 1 
	elsif $dir == :left
		$snakeX[0] -= 1 
	elsif $dir == :down
		$snakeY[0] += 1 
	end
	$map[$snakeX[0]][$snakeY[0]] = false
	$map[$snakeX[$snakeLen-1]][$snakeY[$snakeLen-1]] = true
	
	gameover =-> {scene.request{|s| XYMessageBox.show("Snake", "Gameover!");}; $guard.kill}; 
	gameover[] if $snakeX[0] < 0 || $snakeY[0] < 0 || $snakeX[0] >= 20 || $snakeY[0] >= 20 
	(1..$snakeLen).to_a.reverse.each do |e|
		gameover[] if $snakeX[0] == $snakeX[e] && $snakeY[0] == $snakeY[e]
	end
	
	if $snakeX[0] == $foodx && $snakeY[0] == $foody 
		$score += 10
		#scene.request{|s| s.content[2].setText(sprintf("score: %d", $score))}
		$snakeLen += 1
		newfood
	end
end


XYApp.new("snake_23333") do |snake|
	XYMainWindow.new(snake, nil, {:title => 'Snake', :fixed => true, :width => 408, :height => 512, :x => 400}) do |win|
		view = XYLabel.new(snake, win, {:fixed => true, :width => win.clientWidth, :height => 400, :x => 0, :y => 0}) 
		restart = XYPushButton.new(snake, win, {:text => "Restart!", :x => 0, :y => view.height, :width => win.clientWidth})
		stbar = XYStatusBar.new(snake, win, {:text => "Happy playing"})
		
		gm = XYMenu.new("Game")
		gm.addItem(XYMenuItem.new("Restart (F2)") {reset(view); view.focus})
		gm.addItem(XYMenuItem.new("Exit") {snake.exit})
		abt = XYMenu.new("About")
		abt.addItem(XYMenuItem.new("About Snake") {XYMessageBox.show("About", "Written by sxysxy"); view.focus})
		mainm = XYMenu.new
		mainm.addSubMenu(gm)
		mainm.addSubMenu(abt)
		b = XYMenuBar.new(mainm)
		win.setMenu b
		
		
		view.focus
		view.connect(:ON_PAINT) do |sender, data|
			view.painter.paint do				
				$drawNode ||= ->(x,y){fillRect(x*20, y*20, 20, 20)}
				setBrush(XYBrush.new(255, 255, 255))
				fillRect(0, 0, 420, 400)				#Clear the background
				
				setBrush(XYBrush.new(100, 0, 255))      #Draw the food
				fillRect($foodx*20, $foody*20, 20, 20)
						
				->{
					setBrush(XYBrush.new(255, 0, 0))
					$drawNode[$snakeX[0], $snakeY[0]]
					setBrush(XYBrush.new(60, 255, 30))
					(1..$snakeLen).to_a.reverse.each do |e|
						$drawNode[$snakeX[e], $snakeY[e]]
					end
				}.call	#Draw the snake
				
			end
			stbar.text = "score: #{$score}"
		end
		
		view.connect(:ON_KEYDOWN) do |sender, data|
			if data[:key] == XYKey::VK_UP
				$dir = :up
			elsif data[:key] == XYKey::VK_DOWN
				$dir = :down 
			elsif data[:key] == XYKey::VK_RIGHT
				$dir = :right 
			elsif data[:key] == XYKey::VK_LEFT
				$dir = :left 
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