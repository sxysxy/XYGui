require 'XYGui/xy_gllabel.rb'
require 'XYGui/xy_messagebox.rb'

begin 
	require 'opengl'
rescue LoadError => e
	XYMessageBox.show("Tip", "Opengl needed, you can run 'gem install opengl' ")
	exit
end