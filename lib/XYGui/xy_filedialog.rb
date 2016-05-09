=begin
	
	
	v1.0.0  by sxysxy           2016.03.30
=end

require 'XYGui/xy_widget.rb'

class XYFileDialog < XYWidget
	OFN_PATHMUSTEXIST = 0x800
	OFN_FILEMUSTEXIST = 0x1000
	OFN_EXPLORER = 0x80000
	OFN_ALLOWMULTISELECT = 0x200
	OFN_CREATEPROMPT = 0x2000

	def initialize
		
	end
	
	def self.show(parent = nil, arg = {})
		@owner = (parent.is_a?(XYWidget))? parent.handle: 0
		@filter = arg[:filter]? arg[:filter]: "*.*\x00"
		@flag = OFN_EXPLORER | OFN_FILEMUSTEXIST | OFN_PATHMUSTEXIST
		#@flag |= OFN_ALLOWMULTISELECT if arg[:multiple]       #reserve 
		@flag |= OFN_CREATEPROMPT if arg[:okcreate]
		
		@save = arg[:save]? arg[:save]: false
		@flag &= (~OFN_ALLOWMULTISELECT) if @save
		@title = arg[:title]
		if !@title
			if @save
				@title = "Save File"
			else
				@title = "Open File"
			end
		end

		@buf = "\x00"*256	#must be '\x00'
		pack = [76, @owner, 0,  			#size, owner, instance
				@filter, 0,   				#fitter, customFilter
				0, 0, 		 				#maxCustFilter, filterIndex
				@buf, 256, 0, 0,   			#file(buffer), maxFile(buffer size), fileTitle, maxFileTitle
				Dir.pwd.gsub("/", "\\"),	#PATH
				@title,						#title
				@flag, 					 	#flag
				0,							#fileOffset 		! 2byte
				0,							#fileExtension      ! 2byte
				0, 0, 0, 0             		#defExt, custData, hookProc, templateNmae
				].pack("LLLpLLLpLLLppLSSLLLL")

		if(!@save)
			ret = WinAPI.call("comdlg32", "GetOpenFileName", pack)
			return @buf 
		else
			ret = WinAPI.call("comdlg32", "GetSaveFileName", pack)
			return @buf 
		end
	end
end