class Person
  attr_accessor :name, :age

  def initialize(my_name, my_age)
    @name = my_name
    @age  = my_age
  end

  def introduce
    "Hello, I'm #{name}! How are you?"
  end

  def Person.type
    "A PERSON CLASS"
  end
end

pesho = Person.new "Pesho", 55
gosho = Person.new "Goshko", 6

pesho.name = "PESHO!!!!!!1!"

Person.introduce

puts pesho.introduce
puts pesho.age
puts gosho.introduce
puts gosho.age