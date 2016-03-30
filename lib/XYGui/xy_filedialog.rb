=begin
	
	
	v1.0.0  by sxysxy           2016.03.30
=end

require 'XYGui/xy_widget.rb'

class XYFileDialog < XYWidget
	OFN_PATHMUSTEXIST = 0x800
	OFN_FILEMUSTEXIST = 0x1000
	OFN_EXPLORER = 0x80000
	
	def initialize
		
	end
	
	def self.show
		@buf = "\x00"*256
		pack = [76, 0, 0,  			    #size, owner, instance
				"*.*\x00", 0,   			#fitter, customFilter
				0, 0, 		 			#maxCustFilter, filterIndex
				@buf, 64, 0, 0   			#file, maxFile, fileTitle, maxFileTitle
				"D:\\",
				"Choose File",
				OFN_EXPLORER | OFN_FILEMUSTEXIST | OFN_PATHMUSTEXIST,   #flag
				0,						#fileOffset 		! 2byte
				0,						#fileExtension      ! 2byte
				0, 0, 0, 0              #defExt, custData, hookProc, templateNmae
				].pack("LLLpLLLpLLLppLSSLLLL")
		WinAPI.call("comdlg32", "GetOpenFileName", pack)
	end
end