#encoding: utf-8

require "erb"
require "yaml"

all_translations = YAML.load_file("translations/translations.yml")

data_doc = YAML::load_stream(File.open("translations/translations.yml"))
second_doc = data_doc[1]
p all_translations

class Content
	def initialize(hash)  # Creates instance variables from any dictionary
		hash.each {|key, val|
			var_name = "@#{key}"  
    		instance_variable_set(var_name, val)
    		# self.class.__send__(:attr_writer, "#{key}")
		}
	end

  	def get_binding
  		 binding
  	end

end


class Template
	attr_reader :html

	def initialize(path)
		@html = ERB.new(File.read(path))
	end

	def render(content, language)
		textToRender = self.html.result(content.get_binding) 
		File.write("#{language}/test.html", textToRender) 
	end
		
end

all_translations.each do |language, translation|
	content = Content.new(translation)
	template = Template.new("templates/test.html.erb")
	template.render(content, language)
end






