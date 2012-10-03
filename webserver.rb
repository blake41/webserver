require 'socket'
require 'debugger'
load 'parser.rb'

puts 'starting up server'

server = TCPServer.new("0.0.0.0",8080)
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
		Parser.new(html_strings).parse unless html_strings.empty?
	end
end
