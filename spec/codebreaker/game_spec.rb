require 'spec_helper'
 
module Codebreaker
  describe Game do
    let(:game) {Game.new}
      
    context "#start" do

      let(:another_game) {Game.new}

      before do
        game.start
        @secret_code = game.instance_variable_get(:@secret_code)       
        @turns_count = game.instance_variable_get(:@turns_count)
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
      it "saves secret code with random numbers from 1 to 6" do
        another_game.start
        expect(@secret_code).not_to eq(another_game.instance_variable_get(:@secret_code))
      end
      it "doesn't change the secret code when run again" do
        expect{game.start}.not_to change{@secret_code}
      end
      it "saves turns count" do
        expect(@turns_count).not_to be_empty
      end
      it "increment turns count" do
        expect{game.start}.to change{@turns_count}.by(1)
      end
    end

    context "#check" do
      before do
        @game = double()
      end

      it "returns \"\" when user don't guess any number" 
      it "returns \"-\" when one of the numbers belongs to SC, but stays not in write place" 
      it "returns \"+\" when one of the number in correct place" 
      it "returns \"++-\" when one of the number in different position and 2 numbers in correct place" 
      it "returns \"++++\" when user win the game" 
    end

    context "#hint" do
      it "returns number"
      it "returns one number"
      it "returns one number of the secret code"    
      it "returns the first number of the secret code"
      it "returns the second number of the secret code when it is called twice in the game"
      it "can be called only HINTS_COUNT_CONST times"
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