=begin

=end

require 'XYGui/winapi_base.rb'
require 'XYGui/xy_widget.rb'

class XYTextEdit < XYWidget
	
	def initialize(app, parent = nil, arg = {})
		super(app, parent, arg)
		
		@text = arg[:text]? arg[:text]: ""
		create
	end
	
	def create
		@handle = WinAPI.call("user32", "CreateWindowEx", 0, "EDIT", "", 
								WS_CHILD | WS_BORDER | ES_AUTOVSCROLL | ES_MULTILINE | ES_WANTRETURN | ES_NOHIDESEL | ES_OEMCONVERT,
								@x, @y, @width, @height, @parent.handle, 
								getAsChildId,
								@app.instance, 0)
		#WinAPI.call("user32", "SetWindowLont", @handle, -4, editproc)
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
	
	def text
		len = WinAPI.call("user32", "GetWindowTextLength", @handle)
		buf = "\x00"*(len+1)
		WinAPI.call("user32", "SendMessage", @handle, WM_GETTEXT, len+1, buf)
		buf.chop!
	end
	
	def text=(str)
		WinAPI.call("user32", "SendMessage", @handle, WM_SETTEXT, 0, str)
	end
	
	def length
		WinAPI.call("user32", "GetWindowTextLength", @handle)
	end
	alias :size :length
	
	def setReadOnly(flag)
		_flag = (flag == true)? 1: 0
		WinAPI.call("user32", "PostMessage", @handle, EM_SETREADONLY, _flag, 0)
	end
	
	def editproc
	
	end
end