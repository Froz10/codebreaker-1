def check (gues)
  @secret_code = '3123'

  raise ArgumentError, 'argument length must be equal 4' unless gues.to_s.length == 4
  raise ArgumentError, 'argument must contain only numbers from 1 to 6' unless gues.to_s.match /[1,6]+/
  
  pluses = minuses = '' 
  sc_array = @secret_code.split('')
  gues.to_s.split('').each_with_index do |val, index|
	if (val == sc_array[index]) 
	  sc_array[index] = 0
	  pluses += '+'
	elsif (sc_array.include?(val))
	  sc_array[sc_array.find_index(val)] = 0
	  minuses += '-'
	end
  end
  result = pluses + minuses
end

print check(1234)
puts