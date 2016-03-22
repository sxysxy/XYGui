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
		@mainwindow = XYMainWindow.new(@app, nil, {:title => 'ChatCube\' server!', :height => 500, :width => 400, :style => XYGui::WS_VSCROLL})
		@textarea = XYTextEdit.new(@app, @mainwindow, {:text => "Started Server at #{Time.now.to_s}", :height => 500})
		@textarea.setReadOnly(true)
		
		@btnquit = XYPushButton.new(@app, @mainwindow, {:title => "Quit"})
		@btnclr = XYPushButton.new(@app, @mainwindow, {:title => "Clear"})
	end
	
	def main
		
		@mainwindow.connect(:ON_SIZE) do |sender, data| 
			@textarea.repos(0, 0)
			@textarea.resize(data[:width], data[:height]*7/8)
			@btnclr.repos(0, data[:height]*7/8)
			@btnclr.resize(data[:width]/2, data[:height]/8)
			@btnquit.repos(data[:width]/2, data[:height]*7/8)
			@btnquit.resize(data[:width]/2, data[:height]/8)
		end
		@mainwindow.connect(:ON_DESTROY) {|sender, data| @app.forceExit} 
		@btnquit.connect(:ON_COMMAND) {|sender, data| @app.forceExit}
		@btnclr.connect(:ON_COMMAND) {|sender, data| @textarea.text = ""}
		@mainwindow.show
		
		clt = nil
		@sok = TCPServer.open(2000)
		t = Thread.new do
			loop {clt = @sok.accept}
		end
		
		while true
			@app.main
			if clt
				msg = clt.gets
				@textarea.text = @textarea.text + "\r\n#{msg.chop}"
				clt = nil
			end
		end
	
	end
end

server = ChatCubeServer.new
server.main