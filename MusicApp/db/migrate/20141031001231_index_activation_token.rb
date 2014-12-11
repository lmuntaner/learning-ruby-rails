class IndexActivationToken < ActiveRecord::Migration
  def change
    add_index(:users, :activation_token, unique: true)
  end
end
