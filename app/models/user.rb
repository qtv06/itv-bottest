class User < ApplicationRecord
  has_many :test_suits, dependent: :destroy
  has_secure_password
end
