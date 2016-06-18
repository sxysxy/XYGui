require 'mkmf'

$LDFLAGS << " -lgdiplus"
$CXXFLAGS << " -fpermissive"
create_makefile("XYGuiImg_ext")