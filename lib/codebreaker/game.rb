module Codebreaker
  class Game
    def initialize
      @secret_code = ""
    end
 
    def start
      4.times {@secret_code += Random.rand(7).to_s} if @secret_code.empty?
    end
  end
end