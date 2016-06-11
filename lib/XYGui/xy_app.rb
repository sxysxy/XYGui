=begin

	v1.0.0  by sxysxy           2016.03.30
=end

require 'XYGui/winapi_base.rb'
require 'XYGui/adt_queue.rb'
require 'XYGui'

class XYApp
	attr_reader :instance
	attr_reader :name
	attr_accessor :flagExit
	attr_reader :request
	attr_reader :excpHandler
	
	def initialize(appname)
		#-----set excpHandler
		
		#@excpHandler = proc{defExcpHandler} #defExcpHandler, see XYGui_ext.c
		#registerExcpHandler
		#-----
		
		@instance = Win32API.new("kernel32", "GetModuleHandle", "i", "L").call 0
		@name = appname
		@flagExit = false
		@request = ADTQueue.new(256)       				#max request size: n/2 (default as 256/2 = 128)
		
		#To use some controls
		Fiddle::dlopen("comctl32.dll") 					#Only Load this dll into memory
		Fiddle::dlopen("comdlg32.dll")
		
		registerClass
		yield(self) if block_given?
	end

	#See XYGui_ext	
=begin
	def mainloop
		
	end
=end	

	def proRequest
		widget = @request.pop
		rq = @request.pop
		#puts "#{widget} requested #{rq}" if rq&&widget
		rq.call(widget) if rq&&widget
		sleep(0.02)
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
