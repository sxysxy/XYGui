require 'XYGui'
require 'XYGui/winapi_base.rb'
require 'XYGui/xy_app.rb'
require 'XYGui/xy_mainwindow.rb'
require 'XYGui/xy_pushbutton.rb'
require 'XYGui/xy_vertical_layout.rb'
require 'XYGui/xy_textedit.rb'
require 'socket'


class ChatCubeServer
	attr_reader :app
	attr_reader :mainwindow
	attr_reader :sok
	attr_reader :textarea
	
	HOST = "localhost"
	PORT = 2000
	def initialize
		@app = XYApp.new("chatcube_client")
		@mainwindow = XYMainWindow.new(@app, nil, {:title => "ChatCube's Client!", :height => 500, :width => 400})
		
		@textarea = XYTextEdit.new(@app, @mainwindow)
		@send = XYPushButton.new(@app, @mainwindow, {:title => "Send"})
	end
	
	def main
		
		@mainwindow.connect(:ON_SIZE) do |sender, data|
			@textarea.repos(0, 0)
			@textarea.resize(data[:width], data[:height]*7/8)
			@send.repos(0, data[:height]*7/8)
			@send.resize(data[:width], data[:height]/8)
		end
		
		@send.connect(:ON_COMMAND) do |sender, data|
			begin
				s = TCPSocket.new(HOST, PORT)
				s.puts @textarea.text
				@textarea.text = ""
				s.close
			rescue 
				WinAPI.call("user32", "MessageBox", 0, "Can not find the server!", "Error", 0)
			end
		end
		
		@mainwindow.show
		
		@app.mainloop
	end
end

client = ChatCubeServer.new
client.main
