require 'socket'
puts 'starting up server'

server = TCPServer.new(8080)

[:INT, :QUIT].each do |signal|
	Signal.trap(signal) {
		wpids.each { |wpid| Process.kill(signal, wpid)}
	}
end

wpids = []
5.times do
	wpids << fork do
		loop do
			session = server.accept
			while input = session.gets
				puts "#{input} processed by #{Process.pid}"
			end
		end
	end
end
Process.waitall