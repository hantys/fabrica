require 'rails_helper'

RSpec.describe User, type: :model do
  context 'New User' do
    it 'Create valid new user' do
      user = create(:user)
      expect(user).to be_valid
    end

    it "Verify deleted_at a new user" do
      user = create(:user)
      expect(user.deleted_at).to eq(nil)
    end
  end

  context 'Verify validates' do
    subject { create(:user) }
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }

    it 'email uniqueness' do
      user = create(:user)
      user2 = build :user, email: user.email
      user2.valid?
      expect(user2.errors[:email]).to be == ["já está em uso"]
    end

    it 'username uniqueness' do
      user = create(:user)
      user2 = build :user, username: user.username
      user2.valid?
      expect(user2.errors[:username]).to be == ["já está em uso"]
    end

    it 'password_confirmation == password' do
      user = create :user
      user.valid?
      expect(user.password).to be == user.password_confirmation
    end
  end
end
