class IdeasController
  attr :request

  def initialize(request)
    @request = request
  end

  def index
    @ideas = Idea.all
    render "ideas"
    # "idea: #{@ideas.inspect}"
  end

  def new
    if request.post?
      idea = Idea.new(request)
      database = Idea.db
      database.save(idea)
      # headers["Location"] = "/" #DOESN't work?
      "The idea was saved"
    else
      render 'new'
    end
  end

  def delete
    if request.post?
      database = Idea.db
      database.delete(request.params)
    end
  end

  def edit
    if request.get?
      @id = request.params['id']
      @idea = Idea.find(@id)
      render "edit"
    elsif request.post?
      idea = Idea.new(request)
      database = Idea.db
      database.save(idea, request.params["id"].to_i)
    end
  end


  def render(template_name)
    ERB.new(File.read("templates/#{template_name}.html.erb").force_encoding("utf-8")).result(binding)
  end
end


