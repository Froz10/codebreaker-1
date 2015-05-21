require 'spec_helper'
 
module Codebreaker
  describe Game do
      
    context "#start" do
      let(:game) {Game.new}

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
        let(:game) {Game.new}

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
        before(:all) do
          @game = Game.new
          @game.instance_variable_set(:@secret_code, '3123')
        end

        it "returns \"\" when all number wrong" do
          expect(@game.check('5664')).to be_empty
        end
        it "returns \"-\" when one of the numbers belongs to SC, but stays not in write place" do
          expect(@game.check('5614')).to eq('-')
        end
        it "returns \"+\" when one of the number in correct place"  do
          expect(@game.check('5164')).to eq('+')
        end
        it "returns \"++-\" when one of the number in different position and 2 numbers in correct place"  do
          expect(@game.check('3134')).to eq('++-')
        end
        it "returns \"++++\" when user win the game" do
          expect(@game.check('3123')).to eq('++++')
        end

        context 'without explain, but must work. Write your text:' do
          it '+' do
            expect(@game.check('5553')).to eq('+')
          end
          it '+-' do
            expect(@game.check(3333)).to eq('+-')
          end
          it '++--' do
            @game.instance_variable_set(:@secret_code, '1113')
            expect(@game.check(3111)).to eq('++--')
          end
          it '+++' do
            @game.instance_variable_set(:@secret_code, '1113')
            expect(@game.check(1111)).to eq('+++')
          end

        end
      end
    end

    context "#hint" do
      let(:game) {Game.new}
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

  end
end