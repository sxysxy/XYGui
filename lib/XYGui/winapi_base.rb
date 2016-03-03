=begin

=end

require 'win32api'

class APICallError < Exception
	
end

module WinAPI
	def self.call(dllname, api, *arg)
		@cache ||= {}
		raise TypeError "WinAPI#call's arg requires an Array!" if !arg.is_a?(Array)
		if @cache[api]
			return @cache[api].call *arg
		else
			form = WinAPI.get_form(arg)
			begin
				@cache[api] = Win32API.new(dllname, api, form, "i")
				@cache[api].call *arg
			rescue Exception => e
				@cache[api] = nil	
				raise APICallError, "Error when calling API #{dllname}##{api}"
			end
		end
	end
	
	def self.get_form(data)
		return nil if data == nil
		form = data.map do |e|
			if e.is_a?(String)
				'p'
			elsif e.is_a?(Float)
				'f'
			else
				'L'
			end
		end
		return form
	end
	
end
