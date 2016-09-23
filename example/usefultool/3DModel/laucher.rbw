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
            XYTextView.new(app, lbe, {:text => "Rotate"})
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
            XYTextView.new(app, lbe, {:text => 'Move', :x => 0, :y => 80})
            XYPushButton.new(app, lbe, {:text => 'left', :y => 100, :x => 20}).connect(:ON_COMMAND) do |sender, data|
                
            end
            XYPushButton.new(app, lbe, {:text => 'right', :y => 100, :x => 130}).connect(:ON_COMMAND) do |sender, data|
                
            end
            XYPushButton.new(app, lbe, {:text => 'up', :y => 100, :x => 240}).connect(:ON_COMMAND) do |sender, data|
                
            end
            XYPushButton.new(app, lbe, {:text => 'down', :y => 100, :x => 350}).connect(:ON_COMMAND) do |sender, data|
                
            end
            
            #Light灯光效果
            
            #矩阵变换
            XYTextView.new(app, lbe, {:text => 'Matrix', :y => 400})
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
                when 'W'.bytes[0]
                when 'A'.bytes[0]
                when 'S'.bytes[0]
                when 'D'.bytes[0]
                when 'M'.bytes[0]
            end
            wnd.content[0].call(:ON_PAINT, nil, nil)
            wnd.setFocus
        end
    end.show
end.mainloop