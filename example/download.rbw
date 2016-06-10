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
		ed = XYTextEdit.new(app, wnd, {:x => 10, :y => 0, :width => 250, :height => 60}) 
		go = XYPushButton.new(app, wnd, {:x => 275, :y => 10, :text => 'Go', :width => 60, :height => 40})
		pro = XYProgressBar.new(app, wnd, {:x => 10, :y => 70, :height => 15, :width => 282})
		tv = XYTextView.new(app, wnd, {:x => 304, :width => 40, :height => 15, :y => 71, :text => "0%"})
		stb = XYStatusBar.new(app, wnd, {:text => "Ready"})
		
		working = false
		requestq =->(msg) {stb.request{|s| s.text = msg; working = false}}
		
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
				ana =-> (turl) do 
					bg = 0
					if turl =~ /http:\/\//
						bg = 7
					else
						bg = 0
					end
					p = bg
					while p < turl.length
						break if turl[p] == '/'
						p += 1
					end
					host = turl[bg, p-bg]
					path = turl[p, turl.length-p]
					return host,path
				end
				#---
				host, path = ana[url]
				begin
					io = TCPSocket.new(host, 80)
					io.print sprintf(HTTP_HRAD_FORMAT, path, host)
				rescue
					requestq["Bad URL, Abort"]
				end
				break if !working
				   #----
				sz = 0
				while line = io.gets
					if line =~ /404/
						requestq["Requestion file not found, Abort"]
					end
					if line =~ /302/
						
					end
					if line =~ /Content-Length: [0-9]{1,}/
						sz = line.split(":")[1].to_i
					end
					if line == "\r\n"
						break
					end
				end
				break if !working
				stb.request {|s| s.text = "Begin to Download #{path.split('/').last}, size: #{sz} bytes"}
				   #---
				opt = File.new(path.split('/').pop, "w")
				cmp = 0
				   #---
				
				qbuf = Queue.new
				reving = true
				wtr = Thread.new do
					loop do
						while qbuf.size > 0
							opt.write qbuf.pop
						end
						if !reving && qbuf.size == 0
							opt.flush
							break
						end
						sleep(0.02)
					end
				end
				sec = 1
				timer = Thread.new do
					loop do
						sleep(0.99)
						sec += 1
					end
				end
				while buf = io.read(65535)
					qbuf.push buf
					cmp += buf.size
						
					Thread.new do
						rate = Float(cmp)/sz
						pro.request {|ps| ps.value = Integer(rate*10000)}
						tv.request {|tvr| tvr.text = sprintf("%.1f%%", rate*100)}
						stb.request {|s| s.text = sprintf("%d/%d completed, averge speed %.1f kb/s", cmp, sz ,cmp/1024/sec)}
					end
					
					break if cmp == sz		
				end
				reving = false
				wtr.join
				timer.kill
				opt.close
				io.close
				#-----------------------------------------------------
				
				working = false
				stb.request {|s| s.text = "Completed, you can give me new task now"}
			
			end
		end
		
	end.show
end.mainloop