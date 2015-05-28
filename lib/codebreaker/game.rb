module Codebreaker
  class Game
    HINTS_COUNT = 2
    DEF_MAX_SCORE = 500
    CODE_LENGTH = 4
    ROUND_PENALTY = 10
    HINT_PENALTY = 50

    attr_reader :round_number, :gues_and_results

    def initialize
      @secret_code = ""
      @round_number = 0
      @hints_used = 0
      @gues_results = {}
    end
 
    def start
      CODE_LENGTH.times {
      	@secret_code += (Random.rand(6) + 1).to_s
      } if @secret_code.empty?
    end

    def check (gues)
      raise ArgumentError, 'argument length must be equal 4' unless gues.to_s.length == CODE_LENGTH
      raise ArgumentError, 'argument must contain only numbers from 1 to 6' unless gues.to_s[/[1-6]+/].length == CODE_LENGTH
      
      pluses = minuses = '' 
      sc_array = @secret_code.split('')
      gues_array = gues.to_s.split('')

      gues_array.each_with_index do |val, index|
        if (val == sc_array[index]) 
          sc_array[index] = '0'
          gues_array[index] = '+'
          pluses += '+'
        end
      end

      gues_array.each do |val|
        if (sc_array.include?(val))
          sc_array[sc_array.find_index(val)] = '-'
          minuses += '-'
        end
      end
      result = pluses + minuses
      @gues_results[gues.to_s] = result
      @round_number += 1
      result
    end

    def hint
      raise 'Called hint to many times' unless @hints_used < HINTS_COUNT
      @hints_used += 1     
      @secret_code[Random.rand(4)]
    end

    def score
      DEF_MAX_SCORE - @hints_used*HINT_PENALTY - @round_number*ROUND_PENALTY
    end
  end
end