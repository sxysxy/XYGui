=begin
	TextEditor
	v1.0.0  by sxysxy           2016.03.30
=end

require 'XYGui/winapi_base.rb'
require 'XYGui/xy_scrollable_widget.rb'

class XYTextEdit < XYScrollableWidget
	
	ES_LEFT = 0x0000
	ES_CENTER = 0x0001
	ES_RIGHT = 0x0002
	ES_MULTILINE = 0x0004
	ES_UPPERCASE = 0x0008
	ES_LOWERCASE = 0x0010
	ES_PASSWORD = 0x0020
	ES_AUTOVSCROLL = 0x0040
	ES_AUTOHSCROLL = 0x0080
	ES_NOHIDESEL = 0x0100
	ES_OEMCONVERT = 0x0400
	ES_READONLY = 0x0800
	ES_WANTRETURN = 0x1000
	ES_NUMBER = 0x2000
	EM_GETSEL = 0x00B0
	EM_SETSEL = 0x00B1
	EM_GETRECT = 0x00B2
	EM_SETRECT = 0x00B3
	EM_SETRECTNP = 0x00B4
	EM_SCROLL = 0x00B5
	EM_LINESCROLL = 0x00B6
	EM_SCROLLCARET = 0x00B7
	EM_GETMODIFY = 0x00B8
	EM_SETMODIFY = 0x00B9
	EM_GETLINECOUNT = 0x00BA
	EM_LINEINDEX = 0x00BB
	EM_SETHANDLE = 0x00BC
	EM_GETHANDLE = 0x00BD
	EM_GETTHUMB = 0x00BE
	EM_LINELENGTH = 0x00C1
	EM_REPLACESEL = 0x00C2
	EM_GETLINE = 0x00C4
	EM_LIMITTEXT = 0x00C5
	EM_CANUNDO = 0x00C6
	EM_UNDO = 0x00C7
	EM_FMTLINES = 0x00C8
	EM_LINEFROMCHAR = 0x00C9
	EM_SETTABSTOPS = 0x00CB
	EM_SETPASSWORDCHAR = 0x00CC
	EM_EMPTYUNDOBUFFER = 0x00CD
	EM_GETFIRSTVISIBLELINE = 0x00CE
	EM_SETREADONLY = 0x00CF
	EM_SETWORDBREAKPROC = 0x00D0
	EM_GETWORDBREAKPROC = 0x00D1
	EM_GETPASSWORDCHAR = 0x00D2
	EM_SETMARGINS = 0x00D3
	EM_GETMARGINS = 0x00D4
	EM_SETLIMITTEXT = EM_LIMITTEXT
	EM_GETLIMITTEXT = 0x00D5
	EM_POSFROMCHAR = 0x00D6
	EM_CHARFROMPOS = 0x00D7
	EM_SETIMESTATUS = 0x00D8
	EM_GETIMESTATUS = 0x00D9
	
	attr_reader :oriproc
	
	TEMP = []
	
	def initialize(app, parent = nil, arg = {})
		super(app, parent, arg)
		
		@text = arg[:text]? arg[:text]: ""
		if self.class == XYTextEdit
			create
			yield(self) if block_given?
		end
	end
	
	def create
		@handle = WinAPI.call("user32", "CreateWindowEx", 0x10200, "EDIT", "", 
								ES_AUTOVSCROLL | ES_MULTILINE | ES_WANTRETURN | ES_NOHIDESEL | ES_OEMCONVERT | 0x50010000 | @style,
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