=begin
	TextEditor
=end

require 'XYGui/winapi_base.rb'
require 'XYGui/xy_widget.rb'

class XYTextEdit < XYWidget
	
	attr_reader :oriproc
	
	TEMP = []
	
	def initialize(app, parent = nil, arg = {})
		super(app, parent, arg)
		
		@text = arg[:text]? arg[:text]: ""
		create
	end
	
	def create
		@handle = WinAPI.call("user32", "CreateWindowEx", 0x10200, "EDIT", "", 
								ES_AUTOVSCROLL | ES_MULTILINE | ES_WANTRETURN | ES_NOHIDESEL | ES_OEMCONVERT | 0x50010000,
								@x, @y, @width, @height, @parent.handle, 
								@id,
								@app.instance, 0)
		@oriproc = Fiddle::Function.new(WinAPI.call("user32", "GetWindowLong", @handle, -4), [Fiddle::TYPE_INT]*4, Fiddle::TYPE_INT)
		WinAPI.call("user32", "SetWindowLong", @handle, -4, editproc)
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
		_self = self
		_content = @content
		_responder = @responder
		_app = @app
		_oriproc = @oriproc
		proc = Class.new(Fiddle::Closure) do
			define_method :call do |hwnd, msg, wparam, lparam|
				
				_oriproc.call hwnd, msg, wparam, lparam
			end
		end.new(Fiddle::TYPE_INT, [Fiddle::TYPE_INT]*4)
		TEMP << proc
		Fiddle::Function.new(proc, [Fiddle::TYPE_INT]*4, Fiddle::TYPE_INT).to_i
	end
end