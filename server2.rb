require 'socket'
require 'debugger'
# load 'parser.rb'

puts 'starting up server'

# use sockets not server, bind and listen
# server = TCPServer.new("0.0.0.0",8080)
server = Socket.new(:INET, :STREAM)
socket_address = Socket.pack_sockaddr_in(8080, "0.0.0.0")
server.bind(socket_address)
server.listen(10)

loop do
	puts "first time"
	session = server.accept
	puts "do we ever get here?"
end


# we make two actual connection requests from the browswer, one for
# get request, and one for the favicon, thats why server.accept runs twice
# but the reason i couldnt see the second request in wireshark was because the first
# connection hadnt returned anything yet