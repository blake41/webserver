require 'socket'
client = TCPSocket.new("10.242.11.101",8080)
while to_say = client.gets
	puts to_say
end
# while serverMessage = clientSession.gets
# 	puts serverMessage
# 		puts "log: closing connection"
# 		clientSession.close
# end
client.close