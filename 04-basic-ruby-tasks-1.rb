class Integer 

	def prime?
		return false if self < 2
		divisors = Range.new(2, Math.sqrt(self))
		divisors.each {|divisor| return false if self % divisor == 0}
		true
	end
	
	def prime_factors
		list = []
		2.upto(self).each do |number|
			if self % number == 0 and number.prime? == true				
				list << [number] + (self/number).prime_factors
				break
			end			
		end
		list.flatten
	end

	def harmonic 
		(2..self).reduce(Rational(1)){|sum, number| sum += Rational(1,number)}
	end	

	def digits
		return self.abs.to_s.split(//).map{|digit| digit.to_i}
	end
end
 

class Array
	def frequencies
		self.reduce({}) do |frequencies_list, element|
			frequencies_list[element] = self.count(element)
			frequencies_list
		end
	end

	def average
		return self.reduce(:+)/self.length.to_f	
	end

	def drop_every(index)		
		self.reject do |element|
			element_position = self.index(element) + 1
			element_position % index == 0
		end		
	end

	def combine_with(array)
		max = self.length
		array[max-1] = [array.slice(max-1, array.length)] if array.length > max
		self.flat_map do |element| 
			 index = self.index(element)
			 array[index] != nil ? [element,array[index]].flatten : [element]
		end		
	end

end



def zig_zag(number)
	matrix = []
	(1..number*number).each_slice(number).with_index do |sequence, i|
		sequence = sequence.reverse if i.odd? == true
		matrix << sequence
	end
	matrix
end




