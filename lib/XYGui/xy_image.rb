class XYImage
	attr_reader :filename
	attr_reader :width
	attr_reader :height
	
	attr_accessor :x
	attr_accessor :y
	def initialize(name, arg = {})
		@filename = name
		@x = 0
		@y = 0
		@width = 0
		@height = 0
		
		#GDI+ runs it
		@nativeObject = XYGuiImg::CreateImageObject.call(@filename)
		
				#width, height will be reset here
		@width = getOriginWidth
		@height = getOriginHeight
	end
	
	def getOriginHeight
		XYGuiImg::GetImageHeight.call(@nativeObject) 
	end
	def getOriginWidth
		XYGuiImg::GetImageWidth.call(@nativeObject) 
	end
	
	def close
		XYGuiImg::DeleteImageObject.call(@nativeObject)
	end
	
	def show(widget, arg = {})
		XYGuiImg::ShowImage.call(@nativeObject, widget.handle, @x, @y, @width, @height)
	end
end
