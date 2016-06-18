module XYGuiImg
	#LIBXYIMG = Fiddle::dlopen(File.join(__FILE__[0, __FILE__.length - 11], "xyimg.dll"))
	#SHOWIMG = Fiddle::Function.new(LIBXYIMG['showImage'], [Fiddle::TYPE_VOIDP] + [Fiddle::TYPE_LONG]*5, 
	#						Fiddle::TYPE_INT)
	#SHOWIMG_ON_PAINT = Fiddle::Function.new(LIBXYIMG['showImageOnPaint'], 
	#						[Fiddle::TYPE_VOIDP] + [Fiddle::TYPE_LONG]*5, Fiddle::TYPE_INT) 
end
require 'XYGuiImg_ext.so'
require 'XYGui/xy_image.rb'