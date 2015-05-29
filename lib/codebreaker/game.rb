module Codebreaker
  class Game
    MAX_SCORE = 500
    MAX_ROUNDS = 500
    CODE_LENGTH = 4
    ROUND_PENALTY = 10
    HINT_PENALTY = 50

    attr_reader :round_number, :gues_results, :game_status, :hint_val

    def initialize
      @secret_code = ''
      @round_number = 0
      @gues_results = {}
      @game_status = 'play'
      @hint_val = ''
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
      @game_status = 'win' if result == '++++'
      @game_status = 'loose' if @round_number >= MAX_ROUNDS
      result
    end

    def hint
      if @hint_val.to_s.empty?
        hint_pos = Random.rand(CODE_LENGTH);
        hint_pos.times {@hint_val += '*'}
        @hint_val += @secret_code[hint_pos].to_s
        (CODE_LENGTH - hint_pos - 1).times {@hint_val += '*'}
      end
      @hint_val
    end

    def score
      hints_used = 0
      hints_used = 1 unless @hint_val.empty?
      MAX_SCORE - hints_used*HINT_PENALTY - @round_number*ROUND_PENALTY
    end
  end
end