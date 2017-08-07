require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = build(:user) }

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should be_valid }

  describe "when email is not present" do
	  before { @user = build(:user, email: nil) }
	  it { should_not be_valid }
	end

  describe "when name is not present" do
    before { @user = build(:user, name: nil) }
    it { should be_valid }
  end
end
