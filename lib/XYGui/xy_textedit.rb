=begin

=end

require 'XYGui/winapi_base.rb'
require 'XYGui/xy_widget.rb'

class XYTextEdit < XYWidget
	
	def initialize(app, parent = nil, arg = {})
		super(app, parent, arg)
		
		@text = arg[:text]? arg[:text]: ""
		create
		show
	end
	
	def create
		@handle = WinAPI.call("user32", "CreateWindowEx", 0, "EDIT", "", 
								WS_CHILD | WS_BORDER | WS_VISIBLE | ES_AUTOVSCROLL | ES_MULTILINE | ES_WANTRETURN | ES_NOHIDESEL | ES_OEMCONVERT,
								@x, @y, @width, @height, @parent.handle, 
								getAsChildId,
								app.instance, 0)
	end
	
	def show(flag = 1)
		super(flag)
		self.text = @text
		setReadOnly(false)
	end
	
	def defaultHeight
		return 200
	end
	
	def defaultWidth
		return 100
	end
	
	def text
		len = WinAPI.call("user32", "GetWindowTextLength", @handle)
		buf = "\x00"*(len+2)
		WinAPI.call("user32", "GetWindowText", @handle, buf, len+1)
		buf
	end
	
	def text=(str)
		WinAPI.call("user32", "SetWindowText", @handle, str)
	end
	
	def setReadOnly(flag)
		_flag = (flag == true)? 1: 0
		WinAPI.call("user32", "SendMessage", @handle, EM_SETREADONLY, _flag, 0)
	end
end