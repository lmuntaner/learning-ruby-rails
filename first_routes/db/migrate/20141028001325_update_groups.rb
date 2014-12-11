class UpdateGroups < ActiveRecord::Migration
  def change
    remove_column(:groups, :contact_id)
    
    create_table :group_contacts do |t|
      t.integer :contact_id, null: false
      t.integer :group_id, null: false
      
      t.timestamps
    end
  end
end
