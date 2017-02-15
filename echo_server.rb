require 'socket'

class EchoServer
  def initialize(host = '127.0.0.1', port)
    @host = host
    @port = port
    @server = TCPServer.new host, port
  end

  def run
    puts "Server started at %s, port %s" % [@host, @port]

    loop do
      Thread.start(@server.accept) do |client|
        client.puts "Who dares to disturb the Echo Server? What is the magic word? Guess and break this horrible loop:\r\n"
        while (input = client.gets.strip) != 'please'
          client.puts "%s\n\r" % [input]
        end
        client.close
      end
    end
  end
end


port = ARGV.length == 2 ? ARGV[1] : ARGV[0]
host = ARGV.length == 2 ? ARGV[0] : '127.0.0.1'
app = EchoServer.new host, port
app.run
