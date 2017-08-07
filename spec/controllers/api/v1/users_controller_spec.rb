require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  describe "POST #create" do
    context "with valid params" do
      before(:each) do
        @user_attributes = attributes_for(:user)
        post :create, { user: @user_attributes }, format: :json
      end
      it "creates a new user and return and access token" do
        expect(json_response).to include(:access_token)
        expect(json_response[:status]).to eq("User created successfully")
      end
   	end

   	context "with invalid params" do
      before(:each) do
        @user_attributes = attributes_for(:user, password: nil)
        post :create, { user: @user_attributes }, format: :json
      end
      it "creates a new user" do
        expect(json_response[:errors]).to include("Password can't be blank")
      end
   	end
  end
end
