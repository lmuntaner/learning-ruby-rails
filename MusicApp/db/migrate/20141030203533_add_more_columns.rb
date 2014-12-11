class AddMoreColumns < ActiveRecord::Migration
  def change
    add_column(:albums, :recorded_at, :string, null: false)
    add_column(:tracks, :lyrics, :text)
    add_column(:tracks, :bonus, :string, null: false)
  end
end
