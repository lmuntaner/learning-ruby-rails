class UpdatingIndexes < ActiveRecord::Migration
  def change
    remove_index(:visits, [:visitor_id, :visited_url_id])
    remove_index(:taggings, [:tagged_url_id, :tagged_topic_id])
    add_index(:taggings, :tagged_url_id)
    add_index(:taggings, :tagged_topic_id)
    add_index(:visits, :visitor_id)
    add_index(:visits, :visited_url_id)
  end
end
