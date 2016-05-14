require 'fileutils'

def remake
	clean
	system("ruby ./extconf.rb")
	system("make")
end

def clean
	if File.exist?("./Makefile")
		system("make clean")
		FileUtils.rm("./Makefile")
	end
end

def make
	if !File.exist?("./Makefile")
		if !File.exist?("./extconf.rb")
			puts "extconf.rb Not found, Abort..."
			exit
		end
		system("ruby ./extconf.rb")
	end
	system("make")
end

def main
	make if !ARGV[0]
	make if ARGV[0] == "make"
	remake if ARGV[0] == "remake"
	clean if ARGV[0] == "clean"
end

main