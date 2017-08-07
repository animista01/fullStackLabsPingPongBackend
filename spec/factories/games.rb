# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game do
    user_score 18
    user { FactoryGirl.create(:user) }
    opponent_score 21
    opponent { FactoryGirl.create(:user) }
  end
end
