class User < ApplicationRecord
  has_secure_password
  has_many :tasks
  validates :password_digest, presence: true
  validates :email, presence: true,
                    length: { minimum: 5 },
                    uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
end
