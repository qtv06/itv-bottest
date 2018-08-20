class TestCase < ApplicationRecord
  attr_accessor :name, :test_suit_id, :created_at
  belongs_to :user
  belongs_to :test_suit
end
