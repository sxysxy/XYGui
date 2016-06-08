=begin

	v1.0.0  by sxysxy           2016.03.30
=end

require 'XYGui/winapi_base.rb'
require 'XYGui/adt_queue.rb'
require 'XYGui'

class XYApp
	attr_reader :instance
	attr_reader :name
	attr_reader :message
	attr_accessor :flagExit
	attr_reader :request
	attr_reader :excpHandler
	
	def initialize(appname)
		#-----set excpHandler
		
		@excpHandler = proc{defExcpHandler} #defExcpHandler, see XYGui_ext.c
		registerExcpHandler
		#-----
		
		@instance = Win32API.new("kernel32", "GetModuleHandle", "i", "L").call 0
		@name = appname
		@flagExit = false
		@request = ADTQueue.new(32)       				#max request size:32/2 = 16
		
		@message = Fiddle::Pointer.malloc(36)
		
		#To use some controls
		Fiddle::dlopen("comctl32.dll") 					#Only Load this dll into memory
		Fiddle::dlopen("comdlg32.dll")
		
		registerClass
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
				sleep(0.02)
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
		quit
	end
	
	def forceExitProcess
		WinAPI.call("kernel32", "ExitProcess", 0)
	end
end
