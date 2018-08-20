class AddStatusToTestCases < ActiveRecord::Migration[5.2]
  def change
    add_column :test_cases, :status, :string
  end
end
