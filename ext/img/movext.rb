require 'fileutils'

if File.exist?("./XYGuiImg_ext.so")
	FileUtils.cp("./XYGuiImg_ext.so", "../../lib/XYGuiImg_ext.so")	
end