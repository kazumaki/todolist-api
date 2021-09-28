class User < ApplicationRecord
  has_many :tasks
  validates :email, presence: true,
                    length: { minimum: 5 },
                    uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
end
