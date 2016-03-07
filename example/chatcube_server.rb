require 'XYGui'
require 'XYGui/winapi_base.rb'
require 'XYGui/xy_app.rb'
require 'XYGui/xy_mainwindow.rb'
require 'XYGui/xy_pushbutton.rb'
require 'XYGui/xy_textedit.rb'
require 'socket'

class ChatCubeServer
	attr_reader :app
	attr_reader :mainwindow
	attr_reader :textarea
	attr_reader :sok
	
	HOST = "localhost"
	PORT = 2000
	def initialize
		@app = XYApp.new("chatcube_server")
		@mainwindow = XYMainWindow.new(@app, nil, {:title => 'ChatCube\' server!', :height => 500, :width => 400})
		@textarea = XYTextEdit.new(@app, @mainwindow, {:text => "Started Server at #{Time.now.to_s} \n", :height => 500})
		@textarea.setReadOnly(true)
	end
	
	def main
		@sok = TCPServer.open(PORT)
		t = Thread.new do
			loop do
				client = @sok.accept
				msg = client.gets
				puts msg
				client.close
			end
		end
		@mainwindow.connect(:ON_SIZE) do |sender, data|
			@textarea.resize(data[:width], data[:height])
		end
		@mainwindow.connect(:ON_DESTROY) do |sender, data|
			t.kill
			@app.exit
		end
		
		@mainwindow.show
		@app.mainloop
	end
end

server = ChatCubeServer.new
server.main