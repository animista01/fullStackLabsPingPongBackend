require 'spec_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do

  describe "POST #create" do
  	before(:all) do
    	@user = create(:user)
   	end

    context "when the credentials are correct" do
      before(:each) do
        credentials = { email: @user.email, password: "secret" }
        post :create, { user: credentials }
      end

      it "returns the user record corresponding to the given credentials" do
        @user.reload
        expect(json_response[:access_token]).to eql @user.access_token
      end
    end

    context "when the credentials are incorrect" do
      it "returns a json with an error" do
        credentials = { email: @user.email, password: "invalidpassword" }
        post :create, { user: credentials }

        expect(json_response[:errors]).to eql "Invalid email or password"
      end

      it "returns a json with an error" do
        credentials = { email: "invalid_email@gmail.com", password: "secret" }
        post :create, { user: credentials }

        expect(json_response[:errors]).to eql "Invalid email or password"
      end
    end
  end
end