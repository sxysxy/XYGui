require 'opengl'
require 'glu'
ST ||= 1.0
class State
    attr_reader :xangle, :yangle, :zangle, :rot
    def initialize
        @xangle = @yangle = @zangle = 0.0
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
    end
end
$st ||= State.new
$handler[:rotate] = $st.rot if !$handler[:rotate]
#---------
include GL
glClearColor(0.0, 0.0, 0.0, 0.0)
glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
GL.Enable(GL::GL_DEPTH_TEST)   #Ϊ����ʾ��3Dͼ��
glLoadIdentity
glRotate($st.xangle, 1.0, 0.0, 0.0)
glRotate($st.yangle, 0.0, 1.0, 0.0)
glRotate($st.zangle, 0.0, 0.0, 1.0)
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
