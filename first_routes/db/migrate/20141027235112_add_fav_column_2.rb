class AddFavColumn2 < ActiveRecord::Migration
  def change
    change_column(:contacts, :favorite, :boolean, default: false)
    change_column(:contact_shares, :favorite, :boolean, default: false)
  end
end
