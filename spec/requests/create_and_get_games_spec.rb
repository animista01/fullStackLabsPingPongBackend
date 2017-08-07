require "spec_helper"

describe "Creates Posts and get index", type: :request do
  before(:each) do
    @user = create(:user)
    @opponent = create(:user)
  end
  it "retrieve 2 cycle histories" do
    post "/api/v1/games", { game: attributes_for(:game, user_id: @user.id, opponent_id: @opponent.id) }, { 'Authorization' => @user.access_token }

    post "/api/v1/games", { game: attributes_for(:game, opponent_score: 1, user_score: 21, user_id: @user.id, opponent_id: @opponent.id) }, { 'Authorization' => @user.access_token }

    post "/api/v1/games", { game: attributes_for(:game, opponent_score: 21, user_id: @user.id, opponent_id: @opponent.id) }, { 'Authorization' => @user.access_token }

    get "/api/v1/games", {}, { 'Authorization' => @user.access_token }
    @json_response ||= JSON.parse(response.body, symbolize_names: true)
    expect(@json_response[:games].size).to eq(3)
  end

end
