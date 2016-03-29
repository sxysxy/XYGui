=begin

=end
require 'XYGui/winapi_base.rb'

module XYConsole
	
	def self.show
		return if @shown
		if @hide
			WinAPI.call("user32", "ShowWindow", WinAPI.call("kernel32", "GetConsoleWindow", 0),1)
			return 
		end
		WinAPI.call("kernel32", "AllocConsole")
		STDIN.reopen("CONIN$")
		STDOUT.reopen("CONOUT$")
		@shown = true
		@hide = false
	end
	
	def self.destroy
		return unless @show
		WinAPI.call("user32", "ShowWindow", WinAPI.call("kernel32", "GetConsoleWindow", 0),0)   
		WinAPI.call("kernel32", "FreeConsole")
		@shown = false
		@hide = false
	end
	
	def self.hide
		WinAPI.call("user32", "ShowWindow", WinAPI.call("kernel32", "GetConsoleWindow", 0),0)  
		@hide = true
		@shown = false
	end
end