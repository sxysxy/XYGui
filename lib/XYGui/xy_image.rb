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
		
		#width, height will be set here
		afterInit
		ObjectSpace.define_finalizer(self, proc {|hh| destroyNativeObject})
	end
	
	private :destroyNativeObject
	#:show, :showOnPaint
end