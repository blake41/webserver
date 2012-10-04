class Master

	NUM_WORKERS = 3

	def initialize(socket)
		@socket = socket
		@app = Rack::Builder.parse_file("#{File.expand_path File.dirname(__FILE__)}/../../sample_rails/config.ru")
	end

	def start
		@wpids = []
		NUM_WORKERS.times do
			pid = fork do
				puts "spinning up worker process #{Process.pid}"
				$PROGRAM_NAME = "Worker"
				start_workers
			end
			@wpids << pid
		end
		self.trap_signals
		Process.waitall
	end

	def start_workers
		Worker.new(@socket, @app)
	end

	def trap_signals
		Signal.trap(:INT) do
			@wpids.each do |wpid|
				Process.kill(:INT, wpid)
			end
		end
	end

end