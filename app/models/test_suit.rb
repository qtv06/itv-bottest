class TestSuit < ApplicationRecord
  attr_accessor :name, :id
  belongs_to :user
  has_many :test_cases, dependent: :destroy
  validates :name, presence: true, length: {maximum: 200}
  default_scope -> {order updated_at: :desc}
end
