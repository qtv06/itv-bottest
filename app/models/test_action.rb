class TestAction < ApplicationRecord
  attr_accessor :id, :name
  belongs_to :action_type
  has_many :params, dependent: :destroy
end
