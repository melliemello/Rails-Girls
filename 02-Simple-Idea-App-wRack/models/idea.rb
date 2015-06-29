#encoding: utf-8

require "yaml"

class Model
  def Model.db
    Database.new("database/#{name.downcase}s.yaml")
  end

  def Model.all
    db.all_entries
  end

  def Model.find(id)
    new db.all_entries[id.to_i]
  end

  def get_binding
    binding
  end
end


class Idea < Model
  attr_accessor :messages
  attr_accessor :description
  attr_accessor :body

  def initialize(params)
    @description = params[:idea_description]
    @body =        params[:idea_body]
  end

  def to_hash
    {
      idea_description: self.description,
      idea_body:        self.body,
    }
  end
end



# b = Idea.new

# p b.render("../templates/index.html.erb")