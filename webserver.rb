require 'socket'
require 'debugger'
puts 'starting up server'

server = TCPServer.new("0.0.0.0",8080)
puts "Parent process is #{Process.pid}"
$PROGRAM_NAME = "Parent Server"
loop do
	session = server.accept
	if fork.nil?
		$PROGRAM_NAME = "Child Server"
		while input = session.gets
			puts "#{input} served by #{Process.pid}"
		end
	end
end
