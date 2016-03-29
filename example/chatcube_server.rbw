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
	attr_reader :msg
	
	attr_reader :clts
	PORT = 2333
	
	def initialize
		@app = XYApp.new("chatcube_server")
		@mainwindow = XYMainWindow.new(@app, nil, {:title => 'ChatCube\' Server!', :height => 500, :width => 400, :x => 400})
		@log = "Started Server at #{Time.now.to_s} \r\nPort: #{PORT} \r\n"
		@prelen = @log.length
		@textarea = XYTextEdit.new(@app, @mainwindow, {:text => @log, :height => 500})
		@textarea.setReadOnly(true)
		
		@btnquit = XYPushButton.new(@app, @mainwindow, {:text => "Quit"})
		@btnclr = XYPushButton.new(@app, @mainwindow, {:text => "Clear"})
	
		@msg = ""
		@clts = Array.new
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
		@btnclr.connect(:ON_COMMAND) do|sender, data| 
			@textarea.text = ""
			@log = ""
		end
		
		@mainwindow.show
		
		clt = nil
		@sok = TCPServer.open(PORT)
		Thread.new do
			loop {clt = @sok.accept}
		end
	
		while true
			@app.main
			if clt
				server_proc(clt)
				clt.close
				clt = nil
			end
		end
	
	end
	
	def server_proc(clt)
		name = clt.gets.chop
		cmp = clt.gets
		txt = clt.read
		@msg += "#{name} said (#{Time.now}) \r\n#{txt}\r\n"
		@log += "Connection from #{name} \r\n"
		@textarea.text = @log
		#Thread.new do
			@clts.push(cmp)
			update_all_clts
		#end
	end
	
	def update_all_clts
		@clts.each_with_index do |e, i|	
			begin
				s = TCPSocket.new(e, PORT+1)
				s.puts @msg
				s.close
			rescue Exception => e
				@clts.delete_at(i)
				puts e.message
			end
		end
	end
	
	def server_exit
		@sok.close if @sok
		@app.forceExit
	end
end

server = ChatCubeServer.new
server.main
