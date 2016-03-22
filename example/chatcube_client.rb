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
	
	HOST = "localhost"
	PORT = 2000
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
				s = nil
				text = @textarea.text
				Thread.new do
					begin
						s = TCPSocket.new(@host, @port)
						s.write sprintf("%s said (at #{Time.now.to_s}) \r\n%s", @name.encode("gbk", "utf-8"), text)
						s.close
					rescue
						XYMessageBox.show("Error!", "Fail to find the server!")
					end
				end
				@textarea.text = ""
			rescue Exception => e
				puts e.message
			end
		end
		
		@mainwindow.show
		@app.mainloop
	end
end

client = ChatCubeServer.new
client.main
