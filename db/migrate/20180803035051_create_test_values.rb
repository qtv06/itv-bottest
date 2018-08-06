class CreateTestValues < ActiveRecord::Migration[5.2]
  def change
    create_table :test_values do |t|
      t.integer :test_script_id
      t.integer :test_action_id
      t.integer :param_id
      t.string :value

      t.timestamps
    end
  end
end
