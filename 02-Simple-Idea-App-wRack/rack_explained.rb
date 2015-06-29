require "./router"
require "rack"

hello_world_app = MyApp.new
# use Rack::Reloader

def run(application)
  # network_connection = Network.listen_on(port: 4567)
  # network_connection.on_new_request do |request_parameters|

  request_parameters = {
    'REQUEST_URI' => '/',
    'REQUEST_PATH' => '/',
    'REQUEST_METHOD' => "GET",
    }

  response = application.call(request_parameters)

  http_status_code = response[0]
  http_headers     = response[1]
  content          = response[2]

  content_text = content.join("")

  if not http_headers.key?('Content-Length')
    http_headers['Content-Length'] = content_text.size
  end

  http_response_as_string = "HTTP/1.1 #{http_status_code} OK\n"
  http_headers.each do |header_name, header_value|
    http_response_as_string += "#{header_name}: #{header_value}\n"
  end
  http_response_as_string += "\n#{content_text}"
  
  puts http_response_as_string
end

run hello_world_app
