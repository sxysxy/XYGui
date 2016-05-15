=begin

	v1.0.0  by sxysxy           2016.03.30
=end

require 'fiddle'
#require 'win32api'
class APICallError < Exception
	
end

module WinAPI
	def self.call(dllname, api, *arg)
		@cache ||= {}
		@dlls ||= {}
		unless @dlls[dllname.to_sym]
			begin
				@dlls[dllname.to_sym] = Fiddle::dlopen(dllname)
			rescue Exception => e
				puts e
				exit
			end
		end
		
		unless @cache[api.to_sym]
			dl = @dlls[dllname.to_sym]
			@cache[api.to_sym] = Fiddle::Function.new(dl[api], getForm(arg), Fiddle::TYPE_LONG)
		end
		
		begin
			return @cache[api.to_sym].call *arg 
		rescue
			
		end
	end
	
	def self.specialCall(dllname, api, *arg)
		addr = 0
		begin
			addr = Fiddle::dlopen(dllname)[api]
		rescue
			return nil
		end
		Fiddle::Function.new(addr, getForm(arg), Fiddle::TYPE_LONG).call(*arg) if addr != 0
	end
	
	def self.getForm(data)
		return nil if data == nil
		form = []
		data.each do |e|
			if e.is_a?(String)
				form << Fiddle::TYPE_VOIDP
			elsif e.is_a?(Float)
				form << Fiddle::TYPE_FLOAT
			else
				form << Fiddle::TYPE_LONG
			end
		end
		return form
	end
	
	def self.getStringPointer(s)
		Fiddle::Pointer.new([s].pack("p").unpack("L").first).to_i
	end
	
	def self.getPointerString(p)
		Fiddle::Pointer.new(p).to_s
	end
	
	def self.getAPILastError
		return WinAPI.call("kernel32", "GetLastError")
	end
	
	def self.hiword(v)
		v >> 16
	end
	
	def self.loword(v)
		v ^ ((WinAPI.hiword(v))<<16)
	end
	
end
