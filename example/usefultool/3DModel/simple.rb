require 'opengl'
require 'glu'
#һ�����·�������ֱ�Ӹ��ƿ���
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
            case dir                 #����Ҽ��ϼ��¼�
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
                when :deeper          #����
                    @zmove += MV 
                when :toper           #ǳ��
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
glEnable(GL::GL_DEPTH_TEST)   #Ϊ����ʾ��3Dͼ��
glClearDepth(5.0)
glLoadIdentity
glRotate($st.xangle, 1.0, 0.0, 0.0)
glRotate($st.yangle, 0.0, 1.0, 0.0)
glRotate($st.zangle, 0.0, 0.0, 1.0)
glTranslate($st.xmove, $st.ymove, $st.zmove)
glBegin(GL_QUADS)
    #ǰ��
    glColor3f(0.0, 1.0, 0.0)
    glVertex(-0.5, 0.5, 0.5)
    glVertex(0.5, 0.5, 0.5)
    glVertex(0.5, -0.5, 0.5)
    glVertex(-0.5, -0.5, 0.5)
    glVertex(-0.5, 0.5, -0.5)
    glVertex(0.5, 0.5, -0.5)
    glVertex(0.5, -0.5, -0.5)
    glVertex(-0.5, -0.5, -0.5)
    #����
    glColor3f(1.0, 0.0, 0.0)
    glVertex(-0.5, 0.5, 0.5)
    glVertex(-0.5, -0.5, 0.5)
    glVertex(-0.5, -0.5, -0.5)
    glVertex(-0.5, 0.5, -0.5)
    glVertex(0.5, 0.5, 0.5)
    glVertex(0.5, -0.5, 0.5)
    glVertex(0.5, -0.5, -0.5)
    glVertex(0.5, 0.5, -0.5)
    #����
    glColor3f(0.0, 0.0, 1.0)
    glVertex(-0.5, 0.5, 0.5)
    glVertex(0.5, 0.5, 0.5)
    glVertex(0.5, 0.5, -0.5)
    glVertex(-0.5, 0.5, -0.5)
    glVertex(-0.5, -0.5, 0.5)
    glVertex(0.5, -0.5, 0.5)
    glVertex(0.5, -0.5, -0.5)
    glVertex(-0.5, -0.5, -0.5)
glEnd
