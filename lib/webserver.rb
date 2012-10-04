require 'socket'
require 'debugger'
require 'spyglass_parser'
require 'master'
require 'worker'
require 'rack/server'
require 'rack/builder'

class Server
	puts 'starting up server'
	# lets create a socket and listen on it
	# we dont actually accept the connection requests until we call accept on the socket
	server = Socket.new(:INET, :STREAM)
	socket_address = Socket.pack_sockaddr_in(8080, "0.0.0.0")
	server.bind(socket_address)
	server.listen(10)

	puts "Parent process is #{Process.pid}"
	$PROGRAM_NAME = "Socket Holder"
	fork do
		$PROGRAM_NAME = "Master"
		puts "spinning up master #{Process.pid}"
		Master.new(server).start
	end
	# loop do
	# 	session = server.accept
	# 	$PROGRAM_NAME = "Child Server"
	# 	fork do

	# 	end
	# end

	Process.waitall
end
