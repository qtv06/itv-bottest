class ChangeAgeToEmailInUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :age, :integer
    add_column :users, :email, :string
  end
end
