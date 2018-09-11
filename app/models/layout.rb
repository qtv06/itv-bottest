class Layout < ApplicationRecord
  attr_accessor :name, :id
  belongs_to :user
end
