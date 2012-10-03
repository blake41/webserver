require 'socket'
puts 'starting up server'
server = TCPServer.new("0.0.0.0",8080)
session = server.accept
while to_say = gets
	session.puts"#{to_say}"
end

