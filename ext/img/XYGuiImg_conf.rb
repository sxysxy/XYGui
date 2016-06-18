require 'mkmf'

$LDFLAGS << " -lgdiplus"
create_makefile("XYGuiImg_ext")