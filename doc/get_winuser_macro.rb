a = File.new("winuser_macro.txt", "w")
File.open("winuser.rh") do |file|
	file.each_line do |line|
		next unless line
		x = line.split(" ")
		if x && x.size == 3 && x[0] == "#define"
			next if x[1] =~ /[a-z]/
			x[2].gsub!("L", "") if x[2] =~ /[0-9]L/
			a.puts "\t#{x[1]} = #{x[2]}"
		end
	end
end