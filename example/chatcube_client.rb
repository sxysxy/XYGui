require 'XYGui'
require 'XYGui/winapi_base.rb'
require 'XYGui/xy_app.rb'
require 'XYGui/xy_mainwindow.rb'
require 'XYGui/xy_pushbutton.rb'
require 'XYGui/xy_vertical_layout.rb'
require 'XYGui/xy_textedit.rb'


class ChatCubeServer
	attr_reader :app
	attr_reader :mainwindow
	attr_reader :sok
	
	HOST = "localhost"
	PORT = 2000
	def initialize
		@app = XYApp.new("chatcube_client")
		
	end
	
	def main

		
		@mainwindow.show
		@app.mainloop
	end
end

