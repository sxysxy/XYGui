require 'fileutils'

if File.exist?("./XYGui_ext.so")
	FileUtils.cp("./XYGui_ext.so", "C:\\Ruby21\\lib\\ruby\\gems\\2.1.0\\extensions\\x86-mingw32\\2.1.0\\XYGui-0.1.0\\XYGui_ext.so")	
end