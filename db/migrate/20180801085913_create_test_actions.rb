class CreateTestActions < ActiveRecord::Migration[5.2]
  def change
    create_table :test_actions do |t|
      t.string :name
      t.references :action_type, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end
