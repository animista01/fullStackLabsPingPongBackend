require 'rails_helper'

RSpec.describe Game, type: :model do
  it "is valid with a user_score, opponent_id and opponent_score" do
  	expect(build(:game)).to be_valid
  end

  it "is invalid without a user_score" do
  	game = build(:game, user_score: nil)
  	game.valid?
  	expect(game.errors[:user_score]).to include("can't be blank")
  end

  it "is invalid without a opponent_id" do
  	game = build(:game, opponent_id: nil)
  	game.valid?
  	expect(game.errors[:opponent]).to include("can't be blank")
  end

  it "is invalid without a opponent_score" do
  	game = build(:game, opponent_score: nil)
  	game.valid?
  	expect(game.errors[:opponent_score]).to include("can't be blank")
  end
end
