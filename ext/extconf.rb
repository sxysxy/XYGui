require 'mkmf'

$LDFLAGS << "-lgdi32"
create_makefile("XYGui_ext")