class CreateLayouts < ActiveRecord::Migration[5.2]
  def change
    create_table :layouts do |t|
      t.string :name
      t.string :width
      t.string :height
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
