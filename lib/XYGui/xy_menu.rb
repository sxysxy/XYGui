=begin
	
	v1.0.0  by sxysxy           2016.03.30
=end

require 'XYGui/winapi_base.rb'
require 'XYGui/xy_widget.rb'
require 'XYGui/xy_messagebox.rb'

class XYMenuItem
	attr_accessor :text
	attr_reader :cmd
	def initialize(name, &cmd)
		@cmd = cmd
		if !cmd 
			@cmd = proc{onCommand}
		end
		@text = name ? name:""
	end
	
	def call
		@cmd.call
	end
	
	def cmd=(&c)
		@cmd = c
	end
	alias :setCmd :cmd=
	alias :getCmd :cmd
	
	def onCommand
	
	end
end

class XYMenu
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
	attr_reader :bar
	def initialize(text = nil)
		@handle = WinAPI.call("user32", "CreateMenu")
		@text = text ? text:""
		@content = []
		@bar = nil
	end
 
	def addSubMenu(mu)
		@content << mu
		#WinAPI.specialCall("user32", "AppendMenu", @handle, MF_POPUP, mu.handle, mu.text)
	end
	
	def addItem(cmd)
		if cmd.is_a?(String)
			@content << XYMenuItem.new(cmd)
		else
			@content << cmd
		end
		#WinAPI.specialCall("user32", "AppendMenu", @handle, MF_STRING, cmd.id, cmd.text)
	end
	
	def create
		return false if !@bar || !@bar.is_a?(XYMenuBar)
		@content.each do |o|
			if o.is_a?(XYMenu)
				o.bar = @bar
				o.create
				WinAPI.specialCall("user32", "AppendMenu", @handle, MF_POPUP, o.handle, o.text)
			elsif o.is_a?(XYMenuItem)
				WinAPI.specialCall("user32", "AppendMenu", @handle, MF_STRING, @bar.getMyId(o), o.text)
			end
		end
		return true
	end
	
	def setBar(b)
		@bar = b
	end
	alias :bar= :setBar
	
end

class XYMenuBar
	attr_accessor :widget
	attr_accessor :top
	alias :setTop :top=
	alias :getTop :top
	#----------------------------
	attr_reader :id	
	attr_reader :cmds
	def initialize(top = nil)
		@id = -1 
		@cmds = []
		@top = top
		top.setBar(self)
	end
	
	def getMyId(cmd)
		@id += 1
		cmds[@id] = cmd
		return @id
	end
	
	def call(id)
		cmds[id].call if cmds[id]
	end
	
	def show
		if @widget && @top
			@top.create
			WinAPI.call("user32", "SetMenu", @widget.handle, @top.handle)
		end
	end
end

class XYPopupMenuBar < XYMenuBar
	def initialize(top)
		super(top)
	end
	
	def show
			# Different.....
	end
end
