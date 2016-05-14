=begin
	XYLineEdit
	One line edit, such as username
		sxysxy 2016.05.14
=end
require 'XYGui/winapi_base.rb'
require 'XYGui/xy_widget.rb'
require 'XYGui/xy_editable.rb'

class XYLineEdit < XYWidget
	include XYEditable
	def initialize(app, parent, arg = {})
		super(app, parent, arg)
		create if self.class == XYLineEdit
	end
	
	def create
		 lineEditCreate(0)
	end
	
	def defaultWidth
		100
	end
	def defaultHeight
		24
	end
	
	def lineEditCreate(_style)	
		@handle = WinAPI.call("user32", "CreateWindowEx", 0x10200, "EDIT", @text, 
			WS_CHILD | ES_NOHIDESEL | ES_OEMCONVERT | ES_AUTOHSCROLL | @style | _style,
			@x, @y, @width, @height, @parent.handle,
			@id, @app.instance, 0)
		XYMessageBox.show("2", "3") if @handle == nil
	end
	private :lineEditCreate
end