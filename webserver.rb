require 'socket'
require 'debugger'
load 'parser.rb'

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
		html_strings = []
		while input = session.gets
			break if input == "\r\n"
			html_strings << input
		end
		method = Parser.new(html_strings).parse unless html_strings.empty?
	end
end
