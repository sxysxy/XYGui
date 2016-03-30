=begin
	
	v1.0.0  by sxysxy           2016.03.30
=end

require 'XYGui/winapi_base.rb'
require 'XYGui/xy_widget.rb'

class XYMenuBar 
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
				WinAPI.call("user32", "AppendMenu", @handle, XYGui::MF_POPUP, 0, e.text)
		end
		WinAPI.call("user32", "AppendMenu", @handle, XYGui::MF_POPUP, 0, @text)
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