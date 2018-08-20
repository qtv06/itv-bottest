class CreateTestCases < ActiveRecord::Migration[5.2]
  def change
    create_table :test_cases do |t|
      t.references :user, foreign_key: true
      t.references :test_suit, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
