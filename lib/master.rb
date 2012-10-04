class Master

	NUM_WORKERS = 3

	def initialize(socket)
		@socket = socket
		@app = Rack::Builder.parse_file("#{File.expand_path File.dirname(__FILE__)}/../../sample_rails/config.ru")
	end

	def start
		NUM_WORKERS.times do
			fork do
				puts "spinning up worker process #{Process.pid}"
				$PROGRAM_NAME = "Worker"
				start_workers
			end
		end
		Process.waitall
	end

	def start_workers
		Worker.new(@socket, @app)
	end

end