  class Database
  attr_accessor :database_path

  def initialize(database_path)
    @database_path = database_path
  end

  def all
    YAML.load_file(self.database_path)
  end

  def save(record, id=nil)
    id ||= all.keys.max + 1
    all_entries = all
    all_entries[id] = record
    File.open(self.database_path, "w") do |file|
      YAML.dump(all_entries, file)
    end
  end

  def delete(id)
    entries = all
    entries.delete(id)
    File.open(self.database_path, "w") do |file|
      YAML.dump(entries, file)
    end
  end

end

