=begin
	Font!
=end

require 'XYGui/winapi_base.rb'
require 'XYGui/xy_widget.rb'

class XYFont 	
	attr_reader :height
	attr_reader :width
	attr_reader :escapement
	attr_reader :orientation
	attr_reader :weight
	attr_reader :ltalic	
	attr_reader :underLine
	attr_reader :strikeOut    #Deleting Line
	attr_reader :charSet
	attr_reader :outPrecision
	attr_reader :clipPrecision
	attr_reader :quality
	attr_reader :pitchAndFamily
	attr_reader :faceName
	
	attr_accessor :widget
	
	ANSI_CHARSET = 0
	DEFAULT_CHARSET = 1	
	SYMBOL_CHARSET = 2
	SHIFTJIS_CHARSET = 128
	HANGEUL_CHARSET = 129
	HANGUL_CHARSET = 129
	GB2312_CHARSET = 134
	CHINESEBIG5_CHARSET = 136
	OEM_CHARSET = 255
	JOHAB_CHARSET = 130
	HEBREW_CHARSET = 177
	ARABIC_CHARSET = 178
	GREEK_CHARSET = 161
	TURKISH_CHARSET = 162
	VIETNAMESE_CHARSET = 163
	THAI_CHARSET = 222
	EASTEUROPE_CHARSET = 238
	RUSSIAN_CHARSET = 204

	MAC_CHARSET = 77
	BALTIC_CHARSET = 186
	
	OUT_DEFAULT_PRECIS = 0
	OUT_STRING_PRECIS = 1
	OUT_CHARACTER_PRECIS = 2
	OUT_STROKE_PRECIS = 3
	OUT_TT_PRECIS = 4
	OUT_DEVICE_PRECIS = 5
	OUT_RASTER_PRECIS = 6
	OUT_TT_ONLY_PRECIS = 7
	OUT_OUTLINE_PRECIS = 8
	OUT_SCREEN_OUTLINE_PRECIS = 9
	OUT_PS_ONLY_PRECIS = 10
	
	CLIP_DEFAULT_PRECIS = 0
	CLIP_CHARACTER_PRECIS = 1
	CLIP_STROKE_PRECIS = 2
	
	DEFAULT_QUALITY = 0
	DRAFT_QUALITY = 1
	PROOF_QUALITY = 2
	NONANTIALIASED_QUALITY = 3
	ANTIALIASED_QUALITY = 4
	
	DEFAULT_PITCH = 0
	FIXED_PITCH = 1
	VARIABLE_PITCH = 2
	
	FW_DONTCARE = 0
	FW_THIN = 100
	FW_EXTRALIGHT = 200
	FW_ULTRALIGHT = 200
	FW_LIGHT = 300
	FW_NORMAL = 400
	FW_REGULAR = 400
	FW_MEDIUM = 500
	FW_SEMIBOLD = 600
	FW_DEMIBOLD = 600
	FW_BOLD = 700
	FW_EXTRABOLD = 800
	FW_ULTRABOLD = 800
	FW_HEAVY = 900
	FW_BLACK = 900
	
	def initialize(arg = {})
		@width = arg[:width]? arg[:weight]:0
		@height = arg[:height]? arg[:height]:0
		@escapement = arg[:escapement]? arg[:escapement]:0
		@orientation = arg[:orientation]? arg[:orientation]:0
		@weight = arg[:weight]? arg[:widget]: FW_MEDIUM
		@ltalic = arg[:ltalic]? arg[:ltalic]:0
		@underLine = arg[:underLine]? arg[:underLine]:0
		@strikeOut = arg[:strikeOut]? arg[:strikeOut]:0
		@charSet = arg[:charSet]? arg[:charSet]:ANSI_CHARSET
		@outPrecision = arg[:outPrecision]? arg[:outPrecision]:0
		@clipPrecision = arg[:clipPrecision]? arg[:clipPrecision]:0
		@quality = arg[:quality]? arg[:quality]:PROOF_QUALITY
		@pitchAndFamily = arg[:pitchAndFamily]? arg[:pitchAndFamily]:DEFAULT_PITCH
		@faceName = arg[:faceName]? arg[:faceName]:"Meriyo"
	end
	
	def apply
		pk = [@height, @width, @escapement, @orientation, @weight,
				@ltalic, @underLine, @strikeOut, @charSet, @outPrecision,
					@clipPrecision, @quality, @pitchAndFamily, @faceName].pack("LLLLLccccccccp")
		hf = WinAPI.call("gdi32", "CreateFontIndirect", pk)
		Win32API.new("user32", "SendMessage", "iiii", "i").call @widget.handle, XYGui::WM_SETFONT, hf, 1
	end
	
end