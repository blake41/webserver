require 'socket'
puts 'starting up server'
server = TCPServer.new(8080)
while (session = server.accept)
	puts "connection established from #{session.peeraddr[2]} at
		#{session.peeraddr[3]}"
	puts "log: got input from client"
	input = session.gets
	puts input
	session.puts "Server: Welcome #{session.peeraddr[2]}\n"
	puts "log: sending goodbye"
	session.puts "Server: Goodbye\n"
end