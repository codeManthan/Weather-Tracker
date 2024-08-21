require 'rails_helper'

RSpec.describe User, type: :model do
  it "creates a valid user" do
    user = create(:user)
    expect(user).to be_valid
  end

  it "is invalid without a password" do
    user = build(:user, password: nil)
    expect(user).not_to be_valid
  end
end