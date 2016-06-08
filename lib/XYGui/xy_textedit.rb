=begin
	TextEditor
	v1.0.0  by sxysxy           2016.03.30
=end

require 'XYGui/winapi_base.rb'
require 'XYGui/xy_scrollable_widget.rb'
require 'XYGui/xy_editable.rb'

class XYTextEdit < XYScrollableWidget
	include XYEditable
	attr_reader :oriproc
	
	TEMP = []
	
	def initialize(app, parent = nil, arg = {})
		super(app, parent, arg)
		
		@text = arg[:text]? arg[:text]: ""
		if self.class == XYTextEdit
			create
		end
	end
	
	def create
		@handle = WinAPI.call("user32", "CreateWindowEx", 0x10200, "EDIT", "", 
								WS_CHILD | ES_AUTOVSCROLL | ES_MULTILINE | ES_WANTRETURN | ES_NOHIDESEL | ES_OEMCONVERT | 0x50010000 | @style,
								@x, @y, @width, @height, @parent.handle, 
								@id,
								@app.instance, 0)
	end
	
	def show(flag = 1)
		super(flag)
		self.text = @text
	end
	
	def defaultHeight
		return 200
	end
	
	def defaultWidth
		return 100
	end

end