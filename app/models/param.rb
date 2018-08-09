class Param < ApplicationRecord
  attr_accessor :id, :name, :test_action_id, :param_value
  belongs_to :test_action
end
