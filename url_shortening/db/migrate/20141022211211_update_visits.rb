class UpdateVisits < ActiveRecord::Migration
  def change
    remove_index(:visits, [:visitor_id, :visited_url_id])
    add_index(:visits, [:visitor_id, :visited_url_id])
  end
end
