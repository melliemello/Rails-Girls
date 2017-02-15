require 'socket'

class ChatServer
  def initialize(host = '127.0.0.1', port)
    @host = host
    @port = port
    @server = TCPServer.new host, port
    @users = {}
  end

  def run
    puts MESSAGES[:server_started] % [@host, @port]

    loop do
      thread = Thread.start(@server.accept) do |client|
        client.puts 'Please enter your name:'
        nick_name = client.gets.strip
        @users[nick_name] = client
        client.puts "Great! Now you can enjoy this chat  as user #{nick_name}\r\n"

        loop do
          message = client.gets.strip
          client.close if message == "exit"
          @users.each do |other_name, user|
            user.puts  "<%s>: %s \r\n" % [nick_name, message] if other_name != nick_name
          end
        end
      end
      thread.abort_on_exception = true
    end
  end
end


MESSAGES = {
  server_started: "Server started at %s, port %s"
}

port = ARGV.length == 2 ? ARGV[1] : ARGV[0]
host = ARGV.length == 2 ? ARGV[0] : '127.0.0.1'
app = ChatServer.new host, port
app.run

  
