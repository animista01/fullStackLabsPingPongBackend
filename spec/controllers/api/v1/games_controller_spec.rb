require 'spec_helper'

RSpec.describe Api::V1::GamesController, type: :controller do
  describe "POST #create" do
    context "with valid params" do
      before(:each) do
        @user = create(:user)
        @opponent = create(:user)

        api_authorization_header @user.access_token
      end
      it "create a new game" do
        post :create, { game: attributes_for(:game, user_id: @user.id, opponent_id: @opponent.id) }

        expect(json_response[:game]).to include(:id)
        expect(json_response[:game]).to include(:user_score)
        expect(json_response[:game]).to include(:user_id)
        expect(json_response[:game]).to include(:opponent_score)
        expect(json_response[:game]).to include(:opponent_id)
        expect(json_response[:game]).to include(:created_at)
        expect(json_response[:status]).to eq("Game created successfully")
      end
    end
    context "with invalid params" do
      before(:each) do
        @user = create(:user)
        api_authorization_header @user.access_token
      end
      it "create a new post" do
        post :create, { game: attributes_for(:game) }

        expect(response.status).to eq(400)
        expect(json_response[:errors]).to eq(["Opponent can't be blank"])
      end
    end
  end

  describe "GET #index" do
    before(:each) do
      @user = create(:user)
      @opponent = create(:user)

      api_authorization_header @user.access_token
      4.times { create(:game, user_id: @user.id, opponent_id: @opponent.id) }
    end
    it "assigns all games as @games" do
      get :index
      expect(json_response[:games].size).to eq(4)
    end
  end

  describe "GET #show" do
    before(:each) do
      @user = create(:user)
      @opponent = create(:user)

      api_authorization_header @user.access_token
      @game = create(:game, user_id: @user.id, opponent_id: @opponent.id)
    end
    it "Get a specific game" do
      get :show, { id: @game.to_param }

      expect(json_response).to include(:id)
      expect(json_response).to include(:user_score)
      expect(json_response).to include(:user_id)
      expect(json_response).to include(:opponent_score)
      expect(json_response).to include(:opponent_id)
    end
  end

end
