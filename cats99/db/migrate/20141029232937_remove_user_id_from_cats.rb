class RemoveUserIdFromCats < ActiveRecord::Migration
  def change
    remove_column(:cats, :user_id)
    add_column(:cat_rental_requests, :user_id, :integer)
    add_index(:cat_rental_requests, :user_id)
  end
end
