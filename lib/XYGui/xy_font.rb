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
	
	def initialize(arg = {})
		@width = 0
		@height = 0
		@escapement = 0
		@orientation = 0
		@weight = 0
		@ltalic = 0
		@underLine = 0
		@strikeOut = 0
		@charSet = OEM_CHARSET
		@outPrecision = 0
		@clipPrecision = 0
		@quality = PROOF_QUALITY
		@pitchAndFamily = DEFAULT_PITCH
		@faceName = "Arial"
	end
	
	def apply
		pk = [@height, @width, @escapement, @orientation, @weight,
				@ltalic, @underLine, @strikeOut, @charSet, @outPrecision,
					@clipPrecision, @quality, @pitchAndFamily, @faceName].pack("LLLLLccccccccp")
		hf = WinAPI.call("gdi32", "CreateFontIndirect", pk)
		Win32API.new("user32", "SendMessage", "iiii", "i").call @widget.handle, XYGui::WM_SETFONT, hf, 1
	end
	
end