require 'socket'

host = ARGV[0]
port = ARGV[1]

socket = TCPSocket.new host, port

loop do
  puts socket.gets
  socket.puts "milena"
  puts socket.gets

end