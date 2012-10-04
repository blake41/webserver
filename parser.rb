class Parser

	TEMP = "GET / HTTP/1.1\r\n"

	attr_accessor :http_strings, :headers

	def initialize(http_strings)
		@http_strings = http_strings
		self.http_strings.collect(&:chomp)
		self.headers = {}
	end

	def parse
		self.headers[:method] = self.parse_method(self.http_strings[0])[0]
		return self.headers
	end

	def parse_method(method_string)
		method_string.split(/\//).collect(&:strip)
	end

end