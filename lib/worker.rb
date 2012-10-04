class Worker

	def initialize(socket, app)
		@socket, @app = socket, app
		@parser = Spyglass::HttpParser.new
		respond_to_connection
	end

	def respond_to_connection
		loop do
			conn, conn_address = @socket.accept
			@parser.reset

      # The Rack spec requires that 'rack.input' be encoded as ASCII-8BIT.
      empty_body = ''
      empty_body.encode!(Encoding::ASCII_8BIT) if empty_body.respond_to?(:encode!)

      # The Rack spec requires that the env contain certain keys before being
      # passed to the app. These are the keys that aren't provided by each
      # incoming request, server-specific stuff.
      env = { 
        'rack.input' => StringIO.new(empty_body),
        'rack.multithread' => false,
        'rack.multiprocess' => true,
        'rack.run_once' => false,
        'rack.errors' => STDERR,
        'rack.version' => [1, 0]
      }

      # This reads data in from the client connection. We'll read up to 
      # 10000 bytes at the moment.
      data = []
      loop do
      	bytes = conn.gets
      	break if bytes == "\r\n"
      	data << bytes
      end
      # Here we pass the data and the env into the http parser. It parses
      # the raw http request data and updates the env with all of the data
      # it can withdraw.
      @parser.execute(env, data, 0)
      # Call the Rack app, goes all the way down the rabbit hole and back again.
      status, headers, body = @app.call(env)

      # These are the default headers we always include in a response. We
      # only speak HTTP 1.1 and we always close the client connection. At 
      # the monment keepalive is not supported.
      head = "HTTP/1.1 #{status}\r\n" \
      "Date: #{Time.now.httpdate}\r\n" \
      "Status: #{Rack::Utils::HTTP_STATUS_CODES[status]}\r\n" \
      "Connection: close\r\n"

      headers.each do |k,v|
        head << "#{k}: #{v}\r\n"
      end
      conn.write "#{head}\r\n"

      body.each { |chunk| conn.write chunk }
      body.close if body.respond_to?(:close)
      # Since keepalive is not supported we can close the client connection
      # immediately after writing the body.
      conn.close
      puts "#{Process.pid} served request"
    end
	end

end