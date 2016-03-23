require 'XYGui'
require 'XYGui/winapi_base.rb'
require 'XYGui/xy_app.rb'
require 'XYGui/xy_mainwindow.rb'
require 'XYGui/xy_pushbutton.rb'
require 'XYGui/xy_vertical_layout.rb'
require 'XYGui/xy_textedit.rb'
require 'XYGui/xy_messagebox.rb'
require 'socket'
require 'rexml/document'


class ChatCubeServer
	attr_reader :app
	attr_reader :mainwindow
	attr_reader :sok
	attr_reader :textarea
	attr_reader :msgs
	
	attr_reader :name
	attr_reader :host
	attr_reader :port
	
	attr_reader :rev

	def initialize
		@app = XYApp.new("chatcube_client")
		@mainwindow = XYMainWindow.new(@app, nil, {:title => "ChatCube's Client!", :height => 500, :width => 400})
		
		@msgs = XYTextEdit.new(@app, @mainwindow)
		@msgs.setReadOnly(true)
		
		@textarea = XYTextEdit.new(@app, @mainwindow)
		@send = XYPushButton.new(@app, @mainwindow, {:title => "Send"})
		
		@xml = REXML::Document.new(File.open("chatcube_client.xml")).root
		@host = @xml.elements["host"].text
		@port = @xml.elements["port"].text.to_i
		@name = @xml.elements["name"].text
		@rev = nil
		
		@buffer = ""
	end
	
	def main
		
		@mainwindow.connect(:ON_SIZE) do |sender, data|
			@msgs.repos(0, 0)
			@msgs.resize(data[:width], data[:height]*5/8)
			@textarea.repos(0, data[:height]*5/8)
			@textarea.resize(data[:width], data[:height]*2/8)
			@send.repos(0, data[:height]*7/8)
			@send.resize(data[:width], data[:height]/8)
		end
		
		@send.connect(:ON_COMMAND) do |sender, data|
			begin
				text = @textarea.text
				len = @textarea.length+1
				Thread.new do
					begin
						@rev = false
						@sok = TCPSocket.open(@host, @port)
						
						
						@sok.puts len.to_s
						@sok.puts @name.encode('gbk', 'utf-8')
						@sok.write text
						@sok.puts "\x00"
						
						#@buffer = @sok.recv(65536)
						@rev = true
						@sok.close
					rescue Exception => e
						@sok = nil
						@rev = false
						XYMessageBox.show("Error!", e.message)
					end
				end
				@textarea.text = ""
			rescue Exception => e
				puts e.message
			end
		end
		
		@mainwindow.connect(:ON_DESTROY) do |sender, data|
			@xml = nil
			#@sok.close if @sok
			@app.forceExit
		end
		
		@mainwindow.show
		while true
			@app.main
			if @rev
				@msgs = "66" 
				@rev = false
			end
		end
	end
end

client = ChatCubeServer.new
client.main
