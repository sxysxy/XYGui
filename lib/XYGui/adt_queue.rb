=begin

	v1.0.0  by sxysxy           2016.03.30
=end

class ADTQueue
	attr_reader :data
	attr_reader :free
	attr_reader :maxsize
	attr_reader :size
	
	def initialize(maxsize)
		@data = Array.new(maxsize, nil)
		@free = maxsize
		@maxsize = maxsize
		@mutex = Mutex.new
		
		@size = 0
		@head = 0
		@tail = 0
	end
	
	def push(elem)
		@mutex.lock
		r = nil
		begin
			if (@free > 0)
				@data[@tail] = elem
				@tail += 1
				@tail %= @maxsize
			
				@free -= 1
				@size += 1
				r = true
			else
				r = false
			end
		ensure
			@mutex.unlock
			return r
		end
	end
	
	def pop
		@mutex.lock
		ret = nil
		begin
			if @size > 0
				ret = @data[@head]
				@head += 1
				@head = @head % @maxsize
			
				@free += 1
				@size -= 1
			else
				ret = nil
			end
		ensure
			@mutex.unlock
			return ret
		end
	end
	
	def front #Do not need mutex, because the queue won't be chenged
		return @size > 0? @data[@head]: nil
	end
	
	def clear
		@mutex.lock
		begin
			@data.fill(nil)
			@free = @maxsize
			@size = 0
			@head = 0
			@tail = 0
		ensure
			@mutex.unlock
		end
	end
end

#test
=begin
q = ADTQueue.new(3)
q.push(1)
q.push(2)
q.push(3)
print q.data   #=> [1,2,3]

print q.pop    #=> 1
print q.pop    #=> 2
q.push(4)     
q.push(5)
print q.data   #=> [4,5,3]
print q.pop    #=> 3
print q.pop    #=> 4
q.push(6)
print q.pop    #=> 5
print q.data   #=> [4,5,6]
print q.pop    #=> 6

if q.pop == nil
	puts "empty!"
end

q.push(7)     
q.push(8)
q.push(9)
print q.data   #=> [7,8,9]
if q.push(10) == false
	puts "Queue is Full!"
end

=end