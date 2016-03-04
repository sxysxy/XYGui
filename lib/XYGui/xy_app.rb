=begin

=end

require 'XYGui/winapi_base.rb'

class XYApp
	attr_reader :instance
	attr_reader :name
	attr_reader :message
	attr_accessor :flag_exit
	
	def initialize(appname)
		@instance = Win32API.new("kernel32", "GetModuleHandle", "i", "L").call 0
		@name = appname
		@name_registered = false
		@flag_exit = false
		@message = Fiddle::Pointer.malloc(32)
	end
	
	def mainloop
		while WinAPI.call("user32", "GetMessage", @message.to_i, 0, 0, 0) != 0
			if @flag_exit
				beforeExit
				break
			end
			WinAPI.call("user32", "TranslateMessage", @message.to_i)
			WinAPI.call("user32", "DispatchMessage", @message.to_i)
		end
	end
	
	def beforeExit
		
	end
	
	def exit
		@flag_exit = true
	end
	
	def force_exit
		WinAPI.call("kernel32", "ExitProcess", 0)
	end
end
