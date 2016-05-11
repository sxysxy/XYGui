require 'fileutils'

if File.exist?("./XYGui_ext.so")
	FileUtils.cp("./XYGui_ext.so", "../lib/XYGui_ext.so")	
end