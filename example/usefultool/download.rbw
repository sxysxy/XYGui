require 'XYGuiCore'
require 'socket'

HTTP_HRAD_FORMAT = "GET %s HTTP/1.0 \r\n" + 
					"Host: %s:80 \r\n" +
					"Accept: */* \r\n" + 
					"User-Agent: HttpDownloader_XYGui \r\n" + 
					"Connection: close \r\n" +
					"\r\n"
#-------------------------					
begin
#-------------------------

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
				next
			end
			
			#---
			begin   #Process Exception 
			#----
			
			
			working = true
			pro.value = 0
			url = ed.text 
			wk = Thread.new do 
				stb.request {|s| s.text = "Analysing the url"}
				tv.request {|tvr| tvr.text = "0.0"}
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
				begin
					host, path = ana[url]
					io = TCPSocket.new(host, 80)
					io.print sprintf(HTTP_HRAD_FORMAT, path, host)
				rescue
					requestq["Bad URL, Abort"]
				end
				next if !working
				   #----
				sz = 0
				while line = io.__send__(:gets)
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
				next if !working
				stb.request {|s| s.text = "Begin to Download size: #{sz} bytes"}
				   #---
				opt = File.new(path.split('/').pop, "wb") rescue requestq["Bad file name: #{path.split('/').pop},Abort"]
				next if !working || opt.class == TrueClass
						#I also don't know why opt can be a TrueClass instance but sometimes it just is...
					#-----------
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
						sleep(0.02)
					end
				end
				wtr.abort_on_exception = true
				#-----------------
				sec = 1
				timer = Thread.new do
					loop do
						sleep(0.99)
						sec += 1
					end
				end
				timer.abort_on_exception = true
				#----------------
				tbuf = Queue.new
				teller = Thread.new do
					loop do
						while tbuf.size > 0	
							retryt = 0
							begin
								tbuf.pop
								rate = Float(cmp)/sz
								pro.request {|poo| poo.value = Integer(rate*10000)}
								tv.request {|tvr| tvr.text = sprintf("%.1f%%", rate*100)}
								stb.request {|s| s.text = sprintf("%d/%d bytes completed, average speed %.1f kb/s", cmp, sz ,cmp/1024/sec)}
							rescue
								if retryt > 3
									next
								else
									retry
								end
							end
						end
						if !reving && tbuf.size == 0
							break
						end
						sleep(0.05)
					end
				end
				teller.abort_on_exception = true
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
				app.request.clear
				stb.request {|s| s.text = "Writing file..."}
				wtr.join
				begin
					opt.close
					io.close
				rescue
					
				ensure
					#-----------------------------------------------------
					stb.request {|s| s.text = "OK, saved to #{path.split('/').pop}"}
					tv.request {|tvr| tvr.text = "100.0%"}
					pro.request {|ps| ps.value = 10000}
					working = false
				end
			end
			wk.abort_on_exception = true
			#---
			rescue			#Process Exception
				stb.request {|s| s.text = "Error, Abort"}
				working = false
				next
			#----
			end
		end
		
	end.show
end.mainloop

#-------------------------------------------------------------------------------
rescue Exception => e
	case XYMessageBox.show("Error", e.message, :retry)
		when XYMessageBox::CANSEL then
			exit
		when XYMessageBox::RETRY then
			retry
	end
end
