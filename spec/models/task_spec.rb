require 'rails_helper'

RSpec.describe Task, type: :model do
  # Association test
  it { should belong_to(:user) }

  # Validation tests

  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(2) }
end
