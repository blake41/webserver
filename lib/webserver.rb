require 'socket'
require 'spyglass_parser'
require 'master'
require 'worker'
require 'rack/server'
require 'rack/builder'
require 'stringio'

class Server
	port = 8080
	puts "starting up server on port #{port} "
	# lets create a socket and listen on it
	# we dont actually accept the connection requests until we call accept on the socket
	server = Socket.new(:INET, :STREAM)
	socket_address = Socket.pack_sockaddr_in(port, "0.0.0.0")
	server.bind(socket_address)
	server.listen(10)

	puts "Parent process is #{Process.pid}"
	$PROGRAM_NAME = "Socket Holder Server"
	master_pid = fork do
		$PROGRAM_NAME = "Master Server"
		puts "spinning up master #{Process.pid}"
		Master.new(server).start
	end

	Signal.trap(:INT) do
		Process.kill(:INT, master_pid)
	end

	Process.waitall
end
