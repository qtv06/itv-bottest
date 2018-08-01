class TestCase < ApplicationRecord
  belongs_to :user
  belongs_to :test_suit
end
