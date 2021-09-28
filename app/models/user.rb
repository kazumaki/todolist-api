class User < ApplicationRecord
  has_many :tasks
  validates :email, presence: true, length: { minimum: 5 }, uniqueness: true
end
