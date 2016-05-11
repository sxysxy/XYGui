=begin
	ListBox
				sxysxy 2016.05.11
=end

require 'XYGui/winapi_base.rb'
require 'XYGui/xy_scrollable_widget.rb'

class XYListBox < XYScrollableWidget
	
	LBS_NOTIFY = 0x0001
	LBS_SORT = 0x0002
	LBS_NOREDRAW = 0x0004
	LBS_MULTIPLESEL = 0x0008
	LBS_OWNERDRAWFIXED = 0x0010
	LBS_OWNERDRAWVARIABLE = 0x0020
	LBS_HASSTRINGS = 0x0040
	LBS_USETABSTOPS = 0x0080
	LBS_NOINTEGRALHEIGHT = 0x0100
	LBS_MULTICOLUMN = 0x0200
	LBS_WANTKEYBOARDINPUT = 0x0400
	LBS_EXTENDEDSEL = 0x0800
	LBS_DISABLENOSCROLL = 0x1000
	LBS_NODATA = 0x2000
	LBS_NOSEL = 0x4000
	LBS_COMBOBOX = 0x8000
	LBS_STANDARD = LBS_NOTIFY | LBS_SORT | WS_VSCROLL | WS_BORDER
	
	LB_ADDSTRING = 0x0180
	LB_SETSEL = 0x0185
	LB_GETSELCOUNT = 0x0190
	LB_GETSELITEMS = 0x0191
	def initialize(app, parent, arg = {})
		super(app, parent, arg)
		@style |= LBS_MULTIPLESEL if arg[:multiple]
		if self.class == XYListBox
			create
			yield(self) if block_given?
		end
	end
	
	def create
		@handle = WinAPI.call("user32", "CreateWindowEx", 0, "LISTBOX", "\0", 
								WS_CHILD | LBS_STANDARD | @style,
								@x, @y, @width, @height, 
								@parent.handle,@id, 
								@app.instance,
								0)
	end
	
	def addItem(str)
		WinAPI.specialCall("user32", "SendMessage", @handle, LB_ADDSTRING, 0, str)
	end
	alias :add :addItem
	
	def selected?(id)
		WinAPI.specialCall("user32", "SendMessage", @handle, LB_GETSEL, id, 0)
	end
	
	def count
		WinAPI.specialCall("user32", "SendMessage", @handle, LB_GETSELCOUNT, 0, 0)
	end
	
	def selects
		c = count
		if(c > 0)
			buf = "\0\0\0\0"*c
			WinAPI.specialCall("user32", "SendMessage", @handle, LB_GETSELITEMS, count, buf)
			return buf.unpack("L"*c)
		end
		[]
	end
	alias :getSelectedItems :selects
	alias :selectedItems :selects
	
	def insertItem(itemid, str)
		WinAPI.specialCall("user32", "SendMessage", @handle, LB_INSERTSTRING, itemid, str)
	end
	alias :insert :insertItem
	
	def delete(itemid)
		WinAPI.specialCall("user32", "SendMessage", @handle, LB_DELETESTRING, itemid, 0)
	end
	alias :deleteItem :delete
end

#Wait to use

=begin
#define LB_INSERTSTRING 0x0181
#define LB_DELETESTRING 0x0182
#define LB_SELITEMRANGEEX 0x0183
#define LB_RESETCONTENT 0x0184

#define LB_SETCURSEL 0x0186
#define LB_GETSEL 0x0187
#define LB_GETCURSEL 0x0188
#define LB_GETTEXT 0x0189
#define LB_GETTEXTLEN 0x018A
#define LB_GETCOUNT 0x018B
#define LB_SELECTSTRING 0x018C
#define LB_DIR 0x018D
#define LB_GETTOPINDEX 0x018E
#define LB_FINDSTRING 0x018F
#define LB_GETSELCOUNT 0x0190
#define LB_GETSELITEMS 0x0191
#define LB_SETTABSTOPS 0x0192
#define LB_GETHORIZONTALEXTENT 0x0193
#define LB_SETHORIZONTALEXTENT 0x0194
#define LB_SETCOLUMNWIDTH 0x0195
#define LB_ADDFILE 0x0196
#define LB_SETTOPINDEX 0x0197
#define LB_GETITEMRECT 0x0198
#define LB_GETITEMDATA 0x0199
#define LB_SETITEMDATA 0x019A
#define LB_SELITEMRANGE 0x019B
#define LB_SETANCHORINDEX 0x019C
#define LB_GETANCHORINDEX 0x019D
#define LB_SETCARETINDEX 0x019E
#define LB_GETCARETINDEX 0x019F
#define LB_SETITEMHEIGHT 0x01A0
#define LB_GETITEMHEIGHT 0x01A1
#define LB_FINDSTRINGEXACT 0x01A2
#define LB_SETLOCALE 0x01A5
#define LB_GETLOCALE 0x01A6
#define LB_SETCOUNT 0x01A7
#define LB_INITSTORAGE 0x01A8
#define LB_ITEMFROMPOINT 0x01A9
#define LB_GETLISTBOXINFO 0x01B2
#define LB_MSGMAX 0x01B3
#define LB_MULTIPLEADDSTRING 0x01B1
=end
