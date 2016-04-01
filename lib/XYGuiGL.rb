require 'XYGui/xy_messagebox.rb'

begin 
	require 'opengl'
rescue LoadError => e
	XYMessageBox.show("Tip", "Opengl needed, you can run 'gem install opengl' ")
	exit
end

begin 
	require 'glu'
rescue LoadError => e
	XYMessageBox.show("Tip", "glu needed, you can run 'gem install glu' ")
	exit
end

require 'XYGui/xy_gllabel.rb'
