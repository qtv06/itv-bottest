class CreateTestScripts < ActiveRecord::Migration[5.2]
  def change
    create_table :test_scripts do |t|
      t.integer :test_case_id
      t.integer :test_action_id
      t.integer :user_id
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
