puts "parent process is #{Process.pid}"

if fork.nil?
	puts "im the child, my pid is #{Process.pid}"
else
	puts "im the parent, my pid is #{Process.pid}"
end
