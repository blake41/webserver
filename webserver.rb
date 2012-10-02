require 'socket'
puts 'starting up server'

server = TCPServer.new(8080)

workers = []
num_workers = 2
num_workers.times do
	master, worker = UNIXSocket.pair
	workers << worker
	if !fork
		loop do 
			conn = master.recv_io
			while input = conn.gets
				puts "#{input} processed by #{Process.pid}"
			end
		end
	end
end

loop do
	connection = server.accept
	w = workers.shift
	w.send_io(connection)
	connection.close
	workers << w
end