require 'socket'
puts 'starting up server'

server = TCPServer.new(8080)
loop do 
	session = server.accept
	if fork
		puts "connection established from #{session.peeraddr[2]} at
			#{session.peeraddr[3]}"
		while input = session.gets
			puts input
		end
	end
end
