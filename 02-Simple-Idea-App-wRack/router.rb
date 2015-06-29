#encoding: utf-8
require "./models/idea.rb"
require "./models/database.rb"
require "./controllers/ideas_controller"
require "erb"
require "yaml"

class MyApp
  

  def call(env)  
    path = env["REQUEST_PATH"][1..-1]
    request = Rack::Request.new(env)
    headers = {'Content-Type' => "text/html"}

    ideas_controller = IdeasController.new(request)

    case path
      when ""
        body = ideas_controller.index

      when "new"
        body = ideas_controller.new

      when "delete"
        body = ideas_controller.delete
        # content = Database.new("database/ideas.yaml").all_entries 
        # content.delete(request.params) if request.post?
        # body = "The entry was successfully deleted"

      when "edit"
        body = ideas_controller.edit

      when "visits"
        body = "visits #{self.counter}"
        headers = {'Content-Type' => "text/plain"}

    end 

      [200, headers , [body] ]
  end

  def counter
    if @counter
      @counter +=1
    else
      @counter = 1
    end
  end
end
