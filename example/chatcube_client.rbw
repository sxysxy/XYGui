require 'XYGui'
require 'XYGui/winapi_base.rb'
require 'XYGui/xy_app.rb'
require 'XYGui/xy_mainwindow.rb'
require 'XYGui/xy_pushbutton.rb'
require 'XYGui/xy_vertical_layout.rb'
require 'XYGui/xy_textedit.rb'
require 'XYGui/xy_messagebox.rb'
require 'XYGui/xy_key.rb'
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
		
		@msgs = XYTextEdit.new(@app, @mainwindow, {:vscroll => true})
		@msgs.setReadOnly(true)
		
		@textarea = XYTextEdit.new(@app, @mainwindow ,{:vscroll => true})
		@send = XYPushButton.new(@app, @mainwindow, {:text => "Send"})
		
		@xml = REXML::Document.new(File.open("chatcube_client.xml")).root
		@host = @xml.elements["host"].text
		@port = @xml.elements["port"].text.to_i
		@name = @xml.elements["name"].text

		@cmpname = "\00"*100
		WinAPI.call("kernel32", "GetComputerName", @cmpname, [99].pack("L"))
	
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
			text = @textarea.text
			Thread.new do
				begin
					s = TCPSocket.open(@host, port)
					s.puts @name.encode("gbk", "utf-8")
					s.puts @cmpname
					s.write text
					s.close
				rescue
					XYMessageBox.show("Error!", "Can not find the server!")
				end
			end
		end
		
		@sok = TCPServer.open(@port+1)
		svr = nil
		Thread.new do
			loop do
				svr = @sok.accept
				msg = svr.read
				@msgs.request do |msgs|
					msgs.text = msg
					
				end
				@textarea.request do |textarea|
					textarea.text = ""
				end
				svr.close
			end
		end
		
		@mainwindow.connect(:ON_DESTROY) do |sender, data|
			@xml = nil
			@sok.close
			@app.exit
		end
		
		@mainwindow.show
		@app.mainloop
	end
end

client = ChatCubeServer.new
client.main
