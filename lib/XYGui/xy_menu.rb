=begin
	
	v1.0.0  by sxysxy           2016.03.30
=end

require 'XYGui/winapi_base.rb'
require 'XYGui/xy_widget.rb'

class XYMenuBar
	#constants
	MF_INSERT = 0x00000000
	MF_CHANGE = 0x00000080
	MF_APPEND = 0x00000100
	MF_DELETE = 0x00000200
	MF_REMOVE = 0x00001000
	MF_BYCOMMAND = 0x00000000
	MF_BYPOSITION = 0x00000400
	MF_SEPARATOR = 0x00000800
	MF_ENABLED = 0x00000000
	MF_GRAYED = 0x00000001
	MF_DISABLED = 0x00000002
	MF_UNCHECKED = 0x00000000
	MF_CHECKED = 0x00000008
	MF_USECHECKBITMAPS = 0x00000200
	MF_STRING = 0x00000000
	MF_BITMAP = 0x00000004
	MF_OWNERDRAW = 0x00000100
	MF_POPUP = 0x00000010
	MF_MENUBARBREAK = 0x00000020
	MF_MENUBREAK = 0x00000040
	MF_UNHILITE = 0x00000000
	MF_HILITE = 0x00000080
	MF_DEFAULT = 0x00001000
	MF_SYSMENU = 0x00002000
	MF_HELP = 0x00004000
	MF_RIGHTJUSTIFY = 0x00004000
	MF_MOUSESELECT = 0x00008000
	MF_END = 0x00000080
	MFT_STRING = MF_STRING
	MFT_BITMAP = MF_BITMAP
	MFT_MENUBARBREAK = MF_MENUBARBREAK
	MFT_MENUBREAK = MF_MENUBREAK
	MFT_OWNERDRAW = MF_OWNERDRAW
	MFT_RADIOCHECK = 0x00000200
	MFT_SEPARATOR = MF_SEPARATOR
	MFT_RIGHTORDER = 0x00002000
	MFT_RIGHTJUSTIFY = MF_RIGHTJUSTIFY
	MFS_GRAYED = 0x00000003
	MFS_DISABLED = MFS_GRAYED
	MFS_CHECKED = MF_CHECKED

	attr_accessor :text
	attr_reader :handle
	attr_reader :widget
	attr_reader :content
	def initialize(widget)
		@handle = WinAPI.call("user32", "CreateMenu")
		@widget = widget
		@content = []
		@text = ""
	end
	
	def show
		@content.each do |e|
				WinAPI.call("user32", "AppendMenu", @handle, MF_POPUP, 0, e.text)
		end
		WinAPI.call("user32", "AppendMenu", @handle, MF_POPUP, 0, @text)
		WinAPI.call("user32", "DrawMenuBar", @widget.handle)
		WinAPI.call("user32", "SetMenu", @widget.handle, @handle)
	end
	
	def setText(s)
		@text = s
	end
end

=begin
class XYPopupMenuBar < XYMenuBar
	def initialize(widget)
		super(widget)
	end
end
=end

class XYMenuCommand < XYWidget
	attr_accessor :text
	attr_reader :handle
	def initialize(bar, arg = {})
		super(bar.app, bar.widget)
		@handle = WinAPI.call("user32", "CreateMenu")
		@text = String.new
		
		connect(:ON_COMMAND) {|sender, data| onCommand(sender, data)}
	end
	
	def setText(s)
		@text = s
	end
	
	def onCommand(sender, data)
		
	end
end