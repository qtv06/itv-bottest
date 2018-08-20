class CreateParams < ActiveRecord::Migration[5.2]
  def change
    create_table :params do |t|
      t.string :name
      t.references :test_action, foreign_key: true
      t.string :param_value

      t.timestamps
    end
  end
end
