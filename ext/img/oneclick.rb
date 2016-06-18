require 'fileutils'

def remake
	clean
	make
end

def clean
	system("clean.bat")
end

def make
	system("ruby ./XYGuiImg_conf.rb")
	system("make")
	FileUtils.rm "Makefile"
	system("ruby ./movext.rb")
end

def main
	make if !ARGV[0]
	make if ARGV[0] == "make"
	remake if ARGV[0] == "remake"
	clean if ARGV[0] == "clean"
end

main