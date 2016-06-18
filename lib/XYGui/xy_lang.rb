=begin
	languages....
		sxysxy 2016.06.18
=end

require 'XYGui/winapi_base.rb'
module XYLang
	LA_UNICODE = 0
	LA_CHINESE_SIM = 1
	
	def self.getLang 
		WinAPI.call("kernel32", "GetUserDefaultUILanguage")
	end
end