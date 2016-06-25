module XYGuiImg
	LIBXYIMG = Fiddle::dlopen(File.join(__FILE__[0, __FILE__.length - 11], "xyimg.dll"))
	ShowImage = Fiddle::Function.new(LIBXYIMG['_ShowImage'], [Fiddle::TYPE_LONG]*6,  
 							Fiddle::TYPE_VOIDP)
	CreateImageObject = Fiddle::Function.new(LIBXYIMG['_CreateImageObject'], [Fiddle::TYPE_VOIDP], Fiddle::TYPE_LONG)
	DeleteImageObject = Fiddle::Function.new(LIBXYIMG['_DeleteImageObject'], [Fiddle::TYPE_LONG], Fiddle::TYPE_VOID)
	GetImageWidth = Fiddle::Function.new(LIBXYIMG['_GetImageWidth'], [Fiddle::TYPE_LONG], Fiddle::TYPE_INT)
	GetImageHeight = Fiddle::Function.new(LIBXYIMG['_GetImageHeight'], [Fiddle::TYPE_LONG], Fiddle::TYPE_INT)
end
require 'XYGui/xy_image.rb'