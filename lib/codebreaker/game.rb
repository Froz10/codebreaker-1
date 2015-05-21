module Codebreaker
  class Game
    HINTS_COUNT = 2

    attr_reader :round_number

    def initialize
      @secret_code = ""
      @round_number = 0
      @hints_used = 0
    end
 
    def start
      4.times {
      	@secret_code += (Random.rand(6) + 1).to_s
      } if @secret_code.empty?
      @round_number += 1
    end

    def check (gues)
      raise ArgumentError, 'argument length must be equal 4' unless gues.to_s.length == 4
      raise ArgumentError, 'argument must contain only numbers from 1 to 6' unless gues.to_s[/[1-6]+/].length == 4
      
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

    def hint
      raise 'Called hint to many times' unless @hints_used < HINTS_COUNT
      @hints_used += 1     
      @secret_code[Random.rand(4)]
    end

  end
end