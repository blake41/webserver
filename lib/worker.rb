class Worker

	def initialize(socket, app)
		@socket, @app = socket, app
		@parser = Spyglass::HttpParser.new
		respond_to_connection
	end

	def respond_to_connection
		loop do
			server = @socket.accept
			puts 'got connection, closing now'
			server.close
		end
	end

end