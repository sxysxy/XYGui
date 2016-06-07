=begin
	
	v1.0.0  by sxysxy           2016.03.30
=end	

require 'XYGui/xy_scrollable_widget.rb'

class XYWindow < XYScrollableWidget
	#constants
	IDI_APPLICATION = 32512
	IDI_HAND = 32513
	IDI_QUESTION = 32514
	IDI_EXCLAMATION = 32515
	IDI_ASTERISK = 32516
	IDI_WINLOGO = 32517
	IDI_WARNING = IDI_EXCLAMATION
	IDI_ERROR = IDI_HAND
	IDI_INFORMATION = IDI_ASTERISK
	IDC_ARROW = 32512
	IDC_IBEAM = 32513
	IDC_WAIT = 32514
	IDC_CROSS = 32515
	IDC_UPARROW = 32516
	IDC_SIZE = 32640
	IDC_ICON = 32641
	IDC_SIZENWSE = 32642
	IDC_SIZENESW = 32643
	IDC_SIZEWE = 32644
	IDC_SIZENS = 32645
	IDC_SIZEALL = 32646
	IDC_NO = 32648
	IDC_HAND = 32649	
	IDC_APPSTARTING = 32650
	IDC_HELP = 32651
	IDOK = 1
	IDCANCEL = 2
	IDABORT = 3
	IDRETRY = 4
	IDIGNORE = 5
	IDYES = 6
	IDNO = 7
	IDCLOSE = 8
	IDHELP = 9
	IDTRYAGAIN = 10
	IDCONTINUE = 11
	IDTIMEOUT = 32000

	attr_reader :layout
	attr_reader :dc
	attr_reader :painter
	attr_reader :menu
	def initialize(app, parent = nil, arg = {})
		super(app, parent, arg)
		@layout = arg[:layout]? arg[:layout].new(self): XYLayout.new(self)
		@dc = 0
		@painter = XYPainter.new(self)
		@ps = Fiddle::Pointer.malloc(64)
		@className = @app.name 
		@menu = nil
		#---------------------------------------------------
		#create
		#connect(:ON_CREATE) {|a, b| arg[:creator]? arg[:creator].call(a,b): onCreate(a, b)}
		
		#size
		connect(:ON_BEFORESIZE) {|a, b| beforeSize(a, b)}
		connect(:ON_SIZE){|a,b| onSize(a, b)}
		
		#paint
		connect(:ON_BEGINPAINT) {|a,b| beginPaint(a,b)}
		connect(:ON_PAINT) {|a,b| onPaint(a, b)}
		
		#key
		connect(:ON_KEYDOWN) {|a, b| onKeydown(a, b)}
		connect(:ON_KEYUP) {|a,b| onKeyup(a, b)}
		#scroll
		#connect(:ON_VSCROLL) {|a, b| onVScroll(a, b)} 
		#connect(:ON_HSCROLL) {|a, b| onHScroll(a, b)} 
		
		#mouse
		connect(:ON_MOUSEMOVE) {|a, b| onMouseMove(a, b)}
	end
	
	def show(flag = 1)
		@layout.replace
		super(flag)
	end
	
	def layout=(new_layout)
		@layout = new_layout
		@layout.replace
	end
	
=begin
	TEMP = []
	def wndproc
		_self = self
		_content = @content
		_responder = @responder
		
		proc = Class.new(Fiddle::Closure) do
			define_method :call do |hwnd, msg, wparam, lparam|
				return _self.callproc(hwnd, msg, wparam, lparam)
				case msg
					when WM_PAINT then
						_responder[:ON_BEGINPAINT].call(_self, nil) if _responder[:ON_BEGINPAINT]
						return 0
					when WM_DESTROY then
						_responder[:ON_DESTROY].call(_self, nil) if _responder[:ON_DESTROY]
						return 0
					when WM_COMMAND then
						event = wparam >> 16   						 #hiword
						id = wparam^(wparam>>16)<<16				 #loword
						_content[id].responder[:ON_COMMAND].call(_self, {:event => event}) if _content[id] && _content[id].responder[:ON_COMMAND]
						return 0
					when WM_SIZE then
						_responder[:ON_BEFORESIZE].call(_self, {:height => WinAPI.hiword(lparam), :width => WinAPI.loword(lparam)}) if _responder[:ON_BEFORESIZE]
						return 0
					when WM_KEYDOWN then
						_responder[:ON_KEYDOWN].call(_self, {:key => wparam}) if _responder[:ON_KEYDOWN]
					when WM_CREATE then
						_responder[:ON_CREATE].call(_self, nil) if _responder[:ON_CREATE]
						return 0
					else
						return WinAPI.call("user32", "DefWindowProc", hwnd, msg, wparam, lparam)
				end
			end
		end.new(Fiddle::TYPE_INT, [Fiddle::TYPE_INT]*4)
		TEMP << proc 
		Fiddle::Function.new(proc, [Fiddle::TYPE_INT]*4, Fiddle::TYPE_INT).to_i
	end
=end

	def addChild(c)
		super(c)
		@layout.replace
	end
	
	def beforeSize(sender, data)
		@height = data[:height]
		@width = data[:width]
		@responder[:ON_SIZE].call(sender, data) if @responder[:ON_SIZE]
	end
	
	def onSize(sender, data)
		@layout.replace
	end
	
=begin
	#Get The width and height of the client area
	#See XYGui_ext.c
	def clientWidth 
	
	end
	
	def clientHeigth
	
	end
=end
	
	def beginPaint(sender, data)
		@dc = WinAPI.call("user32", "BeginPaint", @handle, @ps.to_i)
		@painter.reset
		@responder[:ON_PAINT].call(sender, data) if @responder[:ON_PAINT]
		@painter.destroy
		WinAPI.call("user32", "EndPaint", @handle, @ps.to_i)
	end
	
	def onCreate(sender, data)
	
	end
	
	def onPaint(sender, data)
		
	end
	
	def onKeydown(sender, data)
		
	end
	
	def onMouseMove(sender, data)
		
	end
	
	def resize(w, h)
		super(w, h)
		@layout.replace
	end
	
	def menuCall(id)
		if @menu
			@menu.bar.call(id)
		end
	end
	
	def setMenu(mu)
		raise TypeError, "setMenu expected a XYMenu(or its deriving class)" if !mu.is_a?(XYMenu)
		
		@menu = mu
		if @menu
			WinAPI.call("user32", "DrawMenuBar", @handle)
			a = XYMenuBar.new(@menu)
			a.widget = self
			a.show
		end
	end
	alias :menu= :setMenu
	alias :getMenu :menu
	
	def destroyMenu
		
	end
end

# Unused but useful.... 
# This was from wndproc
=begin
				case msg
					when WM_PAINT then
						_responder[:ON_BEGINPAINT].call(_self, nil) if _responder[:ON_BEGINPAINT]
						return 0
					when WM_DESTROY then
						_responder[:ON_DESTROY].call(_self, {:system => [hwnd, msg, wparam, lparam]}) if _responder[:ON_DESTROY]
						return 0
					when WM_COMMAND then
						event = wparam >> 16   						 #hiword
						id = wparam^(wparam>>16)<<16				 #loword
						_content[id].responder[:ON_COMMAND].call(_self, {:event => event}) if _content[id] && _content[id].responder[:ON_COMMAND]
						return 0
					when WM_SIZE then
						_responder[:ON_BEFORESIZE].call(_self, {:height => WinAPI.hiword(lparam), :width => WinAPI.loword(lparam)}) if _responder[:ON_BEFORESIZE]
						return 0
					when WM_KEYDOWN then
						_responder[:ON_KEYDOWN].call(_self, {:key => wparam}) if _responder[:ON_KEYDOWN]
					when WM_CREATE then
						_responder[:ON_CREATE].call(_self, nil) if _responder[:ON_CREATE]
						return 0
					else
						return WinAPI.call("user32", "DefWindowProc", hwnd, msg, wparam, lparam)
				end
=end
