require 'XYGuiCore'
require 'socket'

HTTP_HRAD_FORMAT = "GET %s HTTP/1.0 \r\n" + 
					"Host: %s \r\n" +
					"Accept: */* \r\n" + 
					"User-Agent: HttpDownloader \r\n" + 
					"Connection: Keep-Alive \r\n" +
					"\r\n"

XYApp.new("down") do |app|
	XYMainWindow.new(app, nil, {:x => 400, :y => 400, :width => 360, :height => 135, :fixed => true, :title => 'Http Downloader'}) do |wnd|
		ed = XYTextEdit.new(app, wnd, {:x => 0, :y => 0, :width => 260, :height => 60}) 
		go = XYPushButton.new(app, wnd, {:x => 275, :y => 10, :text => 'Go', :width => 60, :height => 40})
		pro = XYProgressBar.new(app, wnd, {:x => 10, :y => 70, :height => 15, :width => 282})
		tv = XYTextView.new(app, wnd, {:x => 304, :width => 40, :height => 15, :y => 71, :text => "0%"})
		stb = XYStatusBar.new(app, wnd, {:text => "Ready"})
		
		working = false
		
		go.connect(:ON_COMMAND) do |sender, data|
			if working
				stb.text = "Working... Please wait for a moment"
				break
			end
			
			working = true
			pro.value = 0
			url = ed.text 
			Thread.new do 
				stb.request {|s| s.text = "Analysing the url"}
				
				#-----------------------------------------------------
				bg = 0
				if url =~ /http:\/\//
					bg = 7
				else
					bg = 0
				end
				p = bg
				while p < url.length
					break if url[p] == '/'
					p += 1
				end
				host = url[bg, p-bg]
				path = url[p, url.length-p]
					#---
				begin
					io = TCPSocket.new(host, 80)
					io.print sprintf(HTTP_HRAD_FORMAT, path, host)
				rescue
					stb.request {|s| s.text = "Bad URL, Abort"}
					working = false
				end
				break if !working
				   #----
				sz = 0
				while line = io.gets
					if line =~ /Content-Length: [0-9]{1,}/
						sz = line.split(":")[1].to_i
					end
					if line == "\r\n"
						break
					end
					if line == "<title>404 Not Found</title>"
						stb.request {|s| s.text = "Bad file path, Abort"}
						working = false
						break
					end
				end
				break if !working
				stb.request {|s| s.text = "Downloading #{path.split('/').pop}, size: #{sz} bytes"}
				   #---
				opt = File.new(path.split('/').pop, "w")
				cmp = 0
				   #---
				
				while buf = io.read(65535)
					opt.write buf
					cmp += buf.size
					opt.flush
					rate = Float(cmp)/sz
					pro.request {|ps| ps.value = Integer(rate*10000)}
					tv.request {|tvr| tvr.text = sprintf("%.1f%%", rate*100)}
					
					break if cmp == sz		
				end
				opt.close
				io.close
				#-----------------------------------------------------
				
				working = false
				stb.request {|s| s.text = "Completed, you can give me new task now"}
			
			end
		end
		
	end.show
end.mainloop