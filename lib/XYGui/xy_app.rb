=begin

=end

require 'XYGui/winapi_base.rb'

class XYApp
	attr_reader :instance
	attr_reader :name
	attr_reader :message
	attr_accessor :windowIdCount;
	
	def initialize(appname)
		@instance = Win32API.new("kernel32", "GetModuleHandle", "i", "L").call 0
		@name = appname
		@windowIdCount = 0
		
		@message = Fiddle::Pointer.malloc(36)
		
		#To use some controls
		Fiddle::dlopen("comctl32.dll") 					#Only Load this dll into memory
	end
	
	def mainloop
		while WinAPI.call("user32", "GetMessage", @message.to_i, 0, 0, 0) > 0
			WinAPI.call("user32", "TranslateMessage", @message.to_i)
			WinAPI.call("user32", "DispatchMessage", @message.to_i)
		end
	end
	
	def main
		if(WinAPI.call("user32", "PeekMessage", @message.to_i, 0, 0, 0, 1) > 0)  #1, PM_REMOVE
			WinAPI.call("user32", "TranslateMessage", @message.to_i)
			WinAPI.call("user32", "DispatchMessage", @message.to_i)
		end
	end
	
	def exit
		WinAPI.call("user32", "PostQuitMessage", 0)
	end
	
	def forceExit
		WinAPI.call("kernel32", "ExitProcess", 0)
	end
end
