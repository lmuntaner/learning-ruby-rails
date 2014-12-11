class ChangeContacts < ActiveRecord::Migration
  def change
    add_index(:contacts, [:email, :user_id], unique: true)
  end
end
