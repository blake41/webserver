require 'socket'
clientSession = TCPSocket.new("10.242.11.101",8080)
puts "log: saying Hello"
clientSession.puts "Client: Hello Server World!\n"
while !(clientSession.closed?) && (serverMessage = clientSession.gets)
	puts serverMessage
	if serverMessage.include?("Goodbye")
		puts "log: closing connection"
		clientSession.close
	end
end
