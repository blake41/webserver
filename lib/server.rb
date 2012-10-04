require 'socket'
require 'debugger'
require 'spyglass_parser'

puts 'starting up server'

# lets create a socket and listen on it
# we dont actually accept the connection requests until we call accept on the socket
server = Socket.new(:INET, :STREAM)
socket_address = Socket.pack_sockaddr_in(8080, "0.0.0.0")
server.bind(socket_address)
server.listen(10)

puts "Parent process is #{Process.pid}"
$PROGRAM_NAME = "Parent Server"
loop do
	session = server.accept
	$PROGRAM_NAME = "Child Server"
	fork do

	end
end
