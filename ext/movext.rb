require 'fileutils'

if File.exist?("./XYGui_ext.so")
	system("ruby ./std/movext.rb")
	system("ruby ./img/movext.rb")
end