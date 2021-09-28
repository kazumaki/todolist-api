require 'rails_helper'

RSpec.describe User, type: :model do
  # Association Test
  it { should have_many(:tasks) }

  # Validation Test

  it { should validate_presence_of(:email) }
  it { should validate_length_of(:email).is_at_least(5) }
  it { should validate_uniqueness_of(:email) }

end
