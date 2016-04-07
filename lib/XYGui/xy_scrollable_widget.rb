=begin 
	This class abstracts widgets that have a scroll
=end

require 'XYGui/winapi_base.rb'
require 'XYGui/xy_widget.rb'

class XYScrollableWidget < XYWidget
	
	#private constants..
	SB_HORZ = 0	
	SB_VERT = 1
	SB_CTL = 2
	SB_BOTH = 3
	SB_LINEUP = 0
	SB_LINELEFT = 0
	SB_LINEDOWN = 1
	SB_LINERIGHT = 1
	SB_PAGEUP = 2
	SB_PAGELEFT = 2
	SB_PAGEDOWN = 3
	SB_PAGERIGHT = 3
	SB_THUMBPOSITION = 4
	SB_THUMBTRACK = 5
	SB_TOP = 6
	SB_LEFT = 6 
	SB_BOTTOM = 7
	SB_RIGHT = 7
	SB_ENDSCROLL = 8
	
	def initialize(app, parent, arg)
		super(app, parent, arg)
		@style |= WS_VSCROLL if arg[:vscroll]
		@style |= WS_HSCROLL if arg[:hscroll]
	end
	
#----------------------------
	def setScrollPos(pos, which = {:vscroll => true})
		flag = 0
		flag |= SB_VERT if which[:vscroll]
		flag |= SB_HORZ if which[:hscroll]
		WinAPI.call("user32", "SetScrollPos", @handle, flag, pos, 1)
	end
	alias :scrollpos= :setScrollPos
end