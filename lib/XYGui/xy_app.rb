=begin

=end

require 'XYGui/winapi_base.rb'
require 'XYGui/adt_queue.rb'
require 'XYGui'

class XYApp
	attr_reader :instance
	attr_reader :name
	attr_reader :message
	attr_accessor :windowIdCount;
	attr_accessor :flagExit
	attr_reader :request
	
	def initialize(appname)
		@instance = Win32API.new("kernel32", "GetModuleHandle", "i", "L").call 0
		@name = appname
		@windowIdCount = 0
		@flagExit = false
		@request = ADTQueue.new(32)       				#max request size:32/2 = 16
		
		@message = Fiddle::Pointer.malloc(36)
		
		#To use some controls
		Fiddle::dlopen("comctl32.dll") 					#Only Load this dll into memory
		yield(self) if block_given?
	end
	
	def mainloop
		while !@flagExit
			if WinAPI.call("user32", "PeekMessage", @message.to_i, 0, 0, 0, 1) > 0	
				WinAPI.call("user32", "TranslateMessage", @message.to_i)
				WinAPI.call("user32", "DispatchMessage", @message.to_i)
			else
				widget = @request.pop
				rq = @request.pop
				#puts "#{widget} requested #{rq}" if rq&&widget
				rq.call(widget) if rq&&widget
				sleep(0.04)
			end
		end
	end
	
	def main
		if(WinAPI.call("user32", "PeekMessage", @message.to_i, 0, 0, 0, 1) > 0)  #1, PM_REMOVE
			WinAPI.call("user32", "TranslateMessage", @message.to_i)
			WinAPI.call("user32", "DispatchMessage", @message.to_i)
		end
	end
	
	def exit
		@flagExit = true
	end
	
	def forceExit
		exit 
	end
	
	def forceExitProcess
		WinAPI.call("kernel32", "ExitProcess", 0)
	end
end
