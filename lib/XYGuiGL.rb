require 'XYGui/xy_messagebox.rb'

begin 
	require 'opengl'
rescue
	XYMessageBox.show("Error!", "Opengl needed, please run gem install opengl")
end

require 'XYGui/xy_gllabel.rb'
