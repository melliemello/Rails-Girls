require "./router"

use Rack::Reloader
m = MyApp.new
run m