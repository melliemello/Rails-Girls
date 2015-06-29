


class Model
  attr_reader :id

  def initialize(attributes = {}, id = nil)
    self.attributes = attributes
    @id = id
  end

  def self.db
    Database.new("./database/#{name.downcase}s.yaml")
  end

  def self.all
    db.all.map do |id, attributes|
      new(attributes, id)
    end
  end

  def self.find(id)
    attributes = db.all[id]
    new(attributes, id) if attributes
  end

  def self.delete_many(array_if_ids)
    array_if_ids.each do |id|
      find(id.to_i).delete
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attributes=(new_attributes = {})
    filtered_attributes = new_attributes.select {|key, _| self.class.attribute_names.include? key}
    @attributes = self.attributes.merge(filtered_attributes)
  end

  def save
    self.class.db.save(self.attributes, id)
  end

  def delete
    self.class.db.delete(id)
  end

  def method_missing(method_name, *args)
    attribute_name = method_name.to_s.chomp("=").to_sym
    if not self.attributes.include?(attribute_name)
      return super
    elsif method_name.to_s.end_with?("=")
      self.attributes[attribute_name] = args[0]
    else 
      self.attributes[method_name]
    end
  end
end

