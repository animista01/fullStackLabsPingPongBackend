require 'rails_helper'

RSpec.describe Leaderboard, type: :model do
  it "is valid with a content, send at option and user id" do
  	expect(build(:leaderboard)).to be_valid
  end

end
