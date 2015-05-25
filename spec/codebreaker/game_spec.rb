require 'spec_helper'
 
module Codebreaker
  describe Game do
    let(:game) {Game.new}
      
    context "#start" do

      before do
        game.start
      end

      context 'when called first time' do
        before do
          @secret_code = game.instance_variable_get(:@secret_code)       
        end

        it "saves secret code" do
          expect(@secret_code).not_to be_empty
        end
        it "saves 4 numbers secret code" do
          expect(@secret_code.length).to eq(4)
        end
        it "saves secret code with numbers from 1 to 6" do
          expect(@secret_code).to match(/[1-6]+/)
        end
        it "set round number to 1" do
          expect(game.round_number).to eq(1)
        end
      end
        
      context 'when called not first time' do
        it "doesn't change the secret code" do
          expect{game.start}.not_to change{game.instance_variable_get(:@secret_code)}
        end
        it "increment round number" do
          expect{game.start}.to change{game.round_number}.by(1)
        end
      end
    end

    context "#check" do
      context 'with wrong arguments' do

        context 'when argument missing' do
          it "raise ArgumentError" do
            expect{game.check}.to raise_error(ArgumentError)
          end
        end

        context 'when arguments count more than one' do
          it "raise ArgumentError" do
            expect{game.check(1,2)}.to raise_error(ArgumentError)
          end
        end

        context 'when argument length != 4' do
          it "raise ArgumentError" do
            expect{game.check(13455)}.to raise_error(ArgumentError)
          end
        end

        context 'when argument aren\'t numbers from 1 to 6' do
          it "raise ArgumentError" do
            expect{game.check('r2d2')}.to raise_error(ArgumentError)
          end
        end
      end

      context 'with good argument' do
          @tests = [
            [3123, 5664, '', "returns '' when all number wrong"],
            [3123, 5614, '-', "returns \"-\" when one of the numbers belongs to SC, but stays not in write place"],
            [3123, 5164, '+', "returns \"+\" when one of the number in correct place"],
            [3123, 3131, '++-', "returns \"++-\" when one of the number in different position and 2 numbers in correct place"],
            [3123, 3123, '++++', "returns \"++++\" when user win the game"],
            [1234, 5555, ''], 
            [1234, 1551, '+'], 
            [1234, 5634, '++'], 
            [1234, 5234, '+++'], 
            [1234, 1234, '++++'], 
            [1234, 3556, '-'], 
            [1234, 3456, '--'], 
            [1234, 3451, '---'], 
            [1234, 3421, '----'],
            [1234, 1552, '+-'], 
            [1234, 1542, '+--'], 
            [1234, 1342, '+---'], 
            [1234, 1532, '++-'], 
            [1234, 1432, '++--'], 
            [1234, 1233, '+++'], 
            [1234, 1532, '++-'], 
            [1234, 1432, '++--'], 
            [1234, 2112, '--'], 
            [3123, 3333, '++'], 
            [3123, 3456, '+'], 
            [1113, 3111, '++--'], 
            [1113, 1111, '+++'], 
            [1113, 5553, '+'], 
            [1113, 3333, '+'],          
          ]

          @tests.each do |test|
            text = test[3] ? test[3] : "when secret_number = #{test[0]} and gues = #{test[1]} must return '#{test[2]}'"
            it text do
              game.instance_variable_set(:@secret_code, test[0].to_s)
              expect(game.check(test[1])).to eq(test[2])
            end
          end
        end
    end

    context "#hint" do
      
      it "can be called" do
        expect{game.hint}.not_to raise_error
      end
      it "can be called HINTS_COUNT times" do
        expect{Game::HINTS_COUNT.times {game.hint}}.not_to raise_error
      end
      it "can be called only HINTS_COUNT times" do
        Game::HINTS_COUNT.times {game.hint}
        expect{game.hint}.to raise_error
      end
      
      it "returns char number from 1 to 6" do
        game.instance_variable_set(:@secret_code, '3126')
        expect(game.hint).to match(/[1-6]+/)
      end
      it "returns one number of the secret code" do
        expect(game.instance_variable_get(:@secret_code)).to match /#{game.hint}/
      end
    end

    context "#score" do
      it "return FixNum" do
        expect(game.score).to be_instance_of(Fixnum)
      end
      it "return write value" do
        game.instance_variable_set(:@round_number, 5)
        game.instance_variable_set(:@hints_used, 5)
        val = Game::DEF_MAX_SCORE - 5*50 - 5*10
        expect(game.score).to eq(val)
      end
      it "changes with new round" do
        expect{game.start}.to change{game.score}
      end

    end

    context "#save" do
      xit "change the file" do
      end
    end

    context "#getScoreBoard" do
      xit "get Score Board" do
      end
    end



=begin
    context "#play" do
      it "show information about CONSTS"
      it "start the Game/New round"
      it "get user number"
      it "check number"
      it "can show hint at any time"
      it "can be stoped"
      it "repeat while user won or lost"
      it "call 'play again?'"
      it "can opt to save information about the game"
    end
=end

  end
end