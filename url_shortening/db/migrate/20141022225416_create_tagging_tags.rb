class CreateTaggingTags < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :tagged_url_id, null: false
      t.integer :tagged_topic_id, null: false
      
      t.timestamps
    end
    
    add_index(:taggings, [:tagged_url_id, :tagged_topic_id])
    
    create_table :tag_topics do |t|
      t.string :tag_name, null: false
      
      t.timestamps
    end
    
    add_index(:tag_topics, :tag_name, unique: true)
  end
end
