class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body, null: true
      t.integer :commentable_id, null: true
      t.string :commentable_type, null: true

      t.timestamps
    end
    add_index(:comments, [:commentable_id, :commentable_type])
  end
end
