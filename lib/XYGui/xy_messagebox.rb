=begin

	v1.0.0  by sxysxy           2016.03.30
=end

require 'XYGui/winapi_base.rb'

class XYMessageBox
	def self.show(title, text)
		WinAPI.call("user32", "MessageBox", 0, text, title, 0)
	end
end 