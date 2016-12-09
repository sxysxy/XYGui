require 'opengl'
require 'glu'
require 'glut'
#一般的套路，你可以直接复制口牙
#Normal Kata so you can copy it to use
ST ||= 1.0
MV ||= 0.1
class State
    attr_reader :xangle, :yangle, :zangle, :rot
    attr_reader :xmove, :ymove, :zmove, :move
    attr_reader :reset
    
    def initialize
        @reset = -> do
            @xangle = @yangle = @zangle = 0.0
            @xmove = @ymove = @zmove = 0.0
        end
        
        @reset.call
        
        @rot = -> (dir) do
            case dir                 #左加右减上加下减
                when :left 
                    @yangle += ST
                when :right
                    @yangle -= ST
                when :up
                    @xangle += ST
                when :down
                    @xangle -= ST
            end
        end
 
        @move = -> (dir) do
            case dir
                when :left
                    @xmove -= MV
                when :right
                    @xmove += MV
                when :up
                    @ymove += MV
                when :down
                    @ymove -= MV
                when :deeper          #深入
                    @zmove += MV 
                when :toper           #浅出
                    @zmove -= MV
            end
        end
        
    end
end
$st ||= State.new
$handler[:rotate] = $st.rot if !$handler[:rotate]
$handler[:move] = $st.move if !$handler[:move]
$handler[:reset] = $st.reset if !$handler[:reset]

#---------
include GL
glClearColor(0.0, 0.0, 0.0, 0.0)
glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
glEnable(GL::GL_DEPTH_TEST)   #为了显示成3D图形
glClearDepth(5.0)
glLoadIdentity
glRotate($st.xangle, 1.0, 0.0, 0.0)
glRotate($st.yangle, 0.0, 1.0, 0.0)
glRotate($st.zangle, 0.0, 0.0, 1.0)
glTranslate($st.xmove, $st.ymove, $st.zmove)

glColor3f(1.0, 0.0, 0.0)
glBegin(GL::POLYGON)
    d = 0
    while(d < 360)
        r = 0.7
        lim = 30        
        
        d += 30
    end
glEnd