require 'socket'
clientSession = TCPSocket.new("10.242.11.101",8080)
while to_say = gets.chomp
	break if to_say == "exit"
	clientSession.puts "#{to_say}\n"
end
# while serverMessage = clientSession.gets
# 	puts serverMessage
# 		puts "log: closing connection"
# 		clientSession.close
# end
clientSession.close