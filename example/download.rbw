require 'XYGuiCore'
require 'socket'

HTTP_HRAD_FORMAT = "GET %s HTTP/1.0 \r\n" + 
					"Host: %s:80 \r\n" +
					"Accept: */* \r\n" + 
					"User-Agent: HttpDownloader_XYGui \r\n" + 
					"Connection: close \r\n" +
					"\r\n"

XYApp.new("down") do |app|
	XYMainWindow.new(app, nil, {:x => 400, :y => 400, :width => 400, :height => 135, :fixed => true, :title => 'Http Downloader'}) do |wnd|
		ed = XYTextEdit.new(app, wnd, {:x => 10, :y => 0, :width => 290, :height => 60}) 
		go = XYPushButton.new(app, wnd, {:x => 315, :y => 10, :text => 'Go', :width => 60, :height => 40})
		pro = XYProgressBar.new(app, wnd, {:x => 10, :y => 70, :height => 15, :width => 322})
		tv = XYTextView.new(app, wnd, {:x => 347, :width => 40, :height => 15, :y => 71, :text => "0.0%"})
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
						requestq["Relocation url are not supported now..."]
					end
					if line =~ /Content-Length: [0-9]{1,}/
						sz = line.split(":")[1].to_i
					end
					if line == "\r\n"
						break
					end
				end
				break if !working
				stb.request {|s| s.text = "Begin to Download size: #{sz} bytes"}
				   #---
				opt = File.new(path.split('/').pop, "wb")
				cmp = 0
				rate = nil
				   #---
				
				#---------------
				qbuf = Queue.new
				reving = true #Must true here, or the wtr&teller will be killed
				wtr = Thread.new do
					loop do
						while qbuf.size > 0
							opt.write qbuf.pop
						end
						if !reving && qbuf.size == 0
							opt.flush
							break
						end
						sleep(0.01)
					end
				end
				#-----------------
				sec = 1
				timer = Thread.new do
					loop do
						sleep(0.99)
						sec += 1
					end
				end
				#----------------
				tbuf = Queue.new
				teller = Thread.new do
					loop do
						while tbuf.size > 0
							rate = Float(cmp)/sz
							pro.request {|ps| ps.value = Integer(rate*10000)}
							tv.request {|tvr| tvr.text = sprintf("%.1f%%", rate*100)}
							stb.request {|s| s.text = sprintf("%d/%d bytes completed, average speed %.1f kb/s", cmp, sz ,cmp/1024/sec)}
						end
						if !reving && tbuf.size == 0
							break
						end
						sleep(0.01)
					end
				end
				#----------------
				while buf = io.read(131072)
					qbuf.push buf
					cmp += buf.size
					tbuf.push 2333
					break if cmp == sz		
				end
				#-----------------
				reving = false
				timer.kill
				teller.kill
				stb.request {|s| s.text = "Writing file..."}
				wtr.join
				
				opt.close
				io.close
				tv.request {|tvr| tvr.text = "100.0%"}
				pro.request {|ps| ps.value = 10000}
				#-----------------------------------------------------
				stb.request {|s| s.text = "OK, saved to #{path.split('/').pop}"}
				working = false
			end
		end
		
	end.show
end.mainloop