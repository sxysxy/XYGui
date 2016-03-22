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
	attr_reader :log
	
	
	def initialize
		@app = XYApp.new("chatcube_server")
		@mainwindow = XYMainWindow.new(@app, nil, {:title => 'ChatCube\' Server!', :height => 500, :width => 400})
		@log = "Started Server at #{Time.now.to_s} \r\nPort: 2000 \r\n"
		@prelen = @log.length
		@textarea = XYTextEdit.new(@app, @mainwindow, {:text => @log, :height => 500})
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
		@mainwindow.connect(:ON_DESTROY) {|sender, data| server_exit} 
		@btnquit.connect(:ON_COMMAND) {|sender, data| server_exit}
		@btnclr.connect(:ON_COMMAND) {|sender, data| @textarea.text = ""}
		@mainwindow.show
		
		clt = nil
		@sok = TCPServer.open(2000)
		Thread.new do
			loop {clt = @sok.accept}
		end
	
		while true
			@app.main
			if clt
				t = nil
				while t = clt.read
					break
				end
				@log += "#{t}\r\n"
				@textarea.text = @log
				Thread.new do
					begin 
					clt.write @log[59...@log.length]
					clt.close
					clt = nil
					rescue Exception => e
						puts e.message
					end
				end
				
			end
		end
	
	end
	
	def server_exit
		@sok.close
		@app.forceExit
	end
end

server = ChatCubeServer.new
server.main
