=begin

	v1.0.0  by sxysxy           2016.03.30
=end

require 'XYGui/winapi_base.rb'

class XYMessageBox
	OK = 1
	CANSEL = 2
	RETRY = 3
	IGNORE = 5
	YES = 6
	NO = 7
	def self.show(title, text, s = nil)
		if !s
			WinAPI.call("user32", "MessageBox", 0, text, title, 0)
		else
			if s == :retry
				WinAPI.call("user32", "MessageBox", 0, text, title, 5)
			elsif s == :yesno 
				WinAPI.call("user32", "MessageBox", 0, text, title, 4)
			elsif s == :yesnoc
				WinAPI.call("user32", "MessageBox", 0, text, title, 4)
			elsif s == :okc 
				WinAPI.call("user32", "MessageBox", 0, text, title, 1)
			end
		end
	end
end 