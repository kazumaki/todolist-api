require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }

  # Association Test
  it { should have_many(:tasks) }

  # Validation Test

  it { should validate_presence_of(:email) }
  it { should validate_length_of(:email).is_at_least(5) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:password_digest) }
  it { should have_secure_password }

  it 'Do not allow emails with bad format' do
    user.email = 'foo@bar'
    expect(user).to be_invalid
  end
end
