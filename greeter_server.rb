require 'socket'

class GreeterServer
  def initialize(host = '127.0.0.1', port)
    @host = host
    @port = port
    @server = TCPServer.new host, port
  end

  def run
    puts "Server started at %s, port %s" % [@host, @port]

    loop do
      Thread.start(@server.accept) do |client|
        client.puts "Hi, this is Greeter Server. Please enter your name:\n\r"
        name = client.gets
        client.puts "Have a nice evening, %s" % [name]
        client.close
      end
    end
  end
end


port = ARGV.length == 2 ? ARGV[1] : ARGV[0]
host = ARGV.length == 2 ? ARGV[0] : '127.0.0.1'
app = GreeterServer.new host, port
app.run
  
