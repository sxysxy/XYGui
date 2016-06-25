require 'fileutils'

def remake
	clean
	make
end

def clean
	system("clean.bat")
end

def make
	system("g++ xyimg_mswin.cpp -shared -lgdiplus -luser32 -lkernel32 -lcrtdll -O3 -o xyimg.dll")
	system("ruby ./movext.rb")
end

def main
	make if !ARGV[0]
	make if ARGV[0] == "make"
	remake if ARGV[0] == "remake"
	clean if ARGV[0] == "clean"
end

main