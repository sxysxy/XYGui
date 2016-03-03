=begin

=end

require 'XYGui/winapi_base.rb'

class XYApp
	attr_reader :instance
	attr_reader :name
	attr_reader :message
	attr_accessor :on_quit
	
	def initialize(appname)
		@instance = Win32API.new("kernel32", "GetModuleHandle", "i", "L").call 0
		@name = appname
		@name_registered = false
		@on_quit = false
	end
	
	def mainloop
		message_buf = "0"*28
		while WinAPI.call("user32", "GetMessage", message_buf, 0, 0, 0) != 0
			WinAPI.call("user32", "DispatchMessage", message_buf)
			break if @on_quit
		end
	end
	
	def exit
		@on_quit = true
	end
	
	def force_exit
		WinAPI.call("kernel32", "ExitProcess", 0)
	end
end
