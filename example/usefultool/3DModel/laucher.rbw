#encoding:gbk
require 'XYGuiCore'
require 'XYGuiGL'
require 'opengl'
require 'glu'
FILE = ARGV[0]? ARGV[0]:'./simple.rb'
$handler = {}
XYApp.new("3D_laucher") do |app|
    XYMainWindow.new(app, nil, {:title => 'Laucher', :height => 600, :width => 1100, :fixed => true}) do |wnd|
        XYGLLabel.new(app, wnd, {:width => wnd.clientWidth-500, :height => wnd.clientHeight}) do |glb|
         
            glb.connect(:ON_PAINT) do |sender, data|
                load FILE
                glb.render
            end
        end
        XYLabel.new(app, wnd, {:x => 600, :y => 0, :width => 500, :height => 600}) do |lbe|
            #Rotate
            XYTextView.new(app, lbe, {:text => "Rotate 旋转".encode("gbk", "utf-8")})
            XYPushButton.new(app, lbe, {:text => 'left', :y => 24, :x => 20}).connect(:ON_COMMAND) do |sender, data|
                wnd.call(:ON_KEYDOWN, lbe, {:key => XYKey::VK_LEFT})
            end
            XYPushButton.new(app, lbe, {:text => 'right', :y => 24, :x => 130}).connect(:ON_COMMAND) do |sender, data|
                wnd.call(:ON_KEYDOWN, lbe, {:key => XYKey::VK_RIGHT})
            end
            XYPushButton.new(app, lbe, {:text => 'up', :y => 24, :x => 240}).connect(:ON_COMMAND) do |sender, data|
                wnd.call(:ON_KEYDOWN, lbe, {:key => XYKey::VK_UP})
            end
            XYPushButton.new(app, lbe, {:text => 'down', :y => 24, :x => 350}).connect(:ON_COMMAND) do |sender, data|
                wnd.call(:ON_KEYDOWN, lbe, {:key => XYKey::VK_DOWN})
            end
            
            #Move
            XYTextView.new(app, lbe, {:text => 'Move 位移'.encode("gbk", "utf-8"), :x => 0, :y => 80})
            XYPushButton.new(app, lbe, {:text => 'left', :y => 100, :x => 30, :width => 60}).connect(:ON_COMMAND) do |sender, data|
                wnd.call(:ON_KEYDOWN, lbe, {:key => 'A'.bytes[0]})
            end
            XYPushButton.new(app, lbe, {:text => 'right', :y => 100, :x => 100, :width => 60}).connect(:ON_COMMAND) do |sender, data|
                wnd.call(:ON_KEYDOWN, lbe, {:key => 'D'.bytes[0]})
            end
            XYPushButton.new(app, lbe, {:text => 'up', :y => 100, :x => 170, :width => 60}).connect(:ON_COMMAND) do |sender, data|
                wnd.call(:ON_KEYDOWN, lbe, {:key => 'W'.bytes[0]})
            end
            XYPushButton.new(app, lbe, {:text => 'down', :y => 100, :x => 240, :width => 60}).connect(:ON_COMMAND) do |sender, data|
                wnd.call(:ON_KEYDOWN, lbe, {:key => 'S'.bytes[0]})
            end
            XYPushButton.new(app, lbe, {:text => 'deeper', :y => 100, :x => 310, :width => 60}).connect(:ON_COMMAND) do |sender, data|
                wnd.call(:ON_KEYDOWN, lbe, {:key => 'Q'.bytes[0]})
            end
            XYPushButton.new(app, lbe, {:text => 'toper', :y => 100, :x => 380, :width => 60}).connect(:ON_COMMAND) do |sender, data|
                wnd.call(:ON_KEYDOWN, lbe, {:key => 'E'.bytes[0]})
            end
            
            #Light灯光效果
            XYTextView.new(app, lbe, {:text => 'Light 灯光效果'.encode("gbk", "utf-8"), :y => 155, :width => 200})
            #矩阵变换
            XYTextView.new(app, lbe, {:width => 200, :text => 'Matrix 矩阵变换'.encode("gbk", "utf-8"), :y => 300})
            XYTextEdit.new(app, lbe, {:width => 300, :text => "A Matrix of size 4*4 Ruby's Array", :height => 100, :x => 20, :y => 330})
            XYPushButton.new(app, lbe, {:text => 'transform', :x => 340, :y => 330})
            XYPushButton.new(app, lbe, {:text => 'push', :x => 340, :y => 380, :width => 45})
            XYPushButton.new(app, lbe, {:text => 'pop', :x => 395, :y => 380, :width => 45})
            
            #重置
            XYPushButton.new(app, lbe, {:text => 'reset', :y => 500, :x => 20}).connect(:ON_COMMAND) do |sender, data|
                wnd.call(:ON_KEYDOWN, lbe, {:key => 'R'.bytes[0]})
            end
        end
        
        wnd.connect(:ON_KEYDOWN) do |sender, data|
            case data[:key]
                when XYKey::VK_ESC then
                    puts "ESC pressed and exit!"
                    app.exit
                when XYKey::VK_UP then
                    $handler[:rotate].call :up if $handler[:rotate]
                when XYKey::VK_DOWN then
                    $handler[:rotate].call :down if $handler[:rotate]
                when XYKey::VK_LEFT then
                    $handler[:rotate].call :left if $handler[:rotate]
                when XYKey::VK_RIGHT then
                    $handler[:rotate].call :right if $handler[:rotate]
                when 'W'.bytes[0] then
                    $handler[:move].call :up if $handler[:move]
                when 'A'.bytes[0] then
                    $handler[:move].call :left if $handler[:move]
                when 'S'.bytes[0] then
                    $handler[:move].call :down if $handler[:move]
                when 'D'.bytes[0] then
                    $handler[:move].call :right if $handler[:move]
                when 'Q'.bytes[0] then
                    $handler[:move].call :deeper if $handler[:move]
                when 'E'.bytes[0] then
                    $handler[:move].call :toper if $handler[:move]
                when 'R'.bytes[0] then
                    $handler[:reset].call if $handler[:reset]
                when 'M'.bytes[0]
            end
            wnd.content[0].call(:ON_PAINT, nil, nil)
            wnd.setFocus
        end
        
        wnd.menu = XYMenu.new.instance_eval do
			addSubMenu(XYMenu.new("关于".encode("gbk", "utf-8")).instance_eval do
                addItem(XYMenuItem.new("帮助".encode("gbk", "utf-8")) {} )
                addItem(XYMenuItem.new("关于".encode("gbk", "utf-8")) {} )
				self
			end)
			self
		end 
        
    end.show
end.mainloop