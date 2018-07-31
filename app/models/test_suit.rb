class TestSuit < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: {maximum: 200}
  default_scope -> {order updated_at: :desc}
end
