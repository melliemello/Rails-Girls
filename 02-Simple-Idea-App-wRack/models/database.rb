#encoding: utf-8

require "yaml"


class Database
	attr_reader :database_path
	attr_accessor :all_entries
	attr_accessor :save
	attr_accessor :delete

	def initialize(database_path)
		@database_path = database_path
	end

	def all_entries
		YAML.load_file(self.database_path)
	end

	def save(idea, id=nil)
		all_entries = self.all_entries
		all_entries = {} if all_entries == nil
		id ||= all_entries.keys.max + 1 
		all_entries[id]= idea.to_hash

		File.open(self.database_path, 'w' ) do |out|
			YAML.dump(all_entries, out )
		end

	end

	def delete(params)
		all_entries = self.all_entries
		params.each do |key, val|
			all_entries[val.to_i] = {}
		end
		File.open(self.database_path, 'w' ) do |out|
			YAML.dump(all_entries, out )
		end
	end

	# def edit(params)
	# 	all_entries = YAML.load_file(self.database_path)
	# 	all_entries = all_entries[params["id"].to_i]
	# 	all_entries[:id] = params["id"].to_i
	# 	self.all_entries = all_entries
	# 	self
	# end

	# def update(params)
	# 	all_entries = YAML.load_file(self.database_path)
	# 	all_entries[params["id"].to_i][:idea_body] = params["idea_body"]
	# 	all_entries[params["id"].to_i][:idea_description] = params["idea_description"]
	# 	File.open(self.database_path, 'w' ) do |out|
	# 		YAML.dump(all_entries, out )
	# 	end
	# end

	def get_binding
		binding
	end
		

end
